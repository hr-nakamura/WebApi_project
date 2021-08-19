using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Linq;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class QOSMIO : hostProc
    {
        int yymmAdd(int yymm, int mCnt)
        {
            int yy = yymm / 100;
            int mm = yymm % 100;

            int ym = (yy * 12) + mm;
            ym += mCnt;
            yy = ym / 12;
            mm = ym % 12;
            if (mm == 0) { yy--; mm = 12; }
            return ((yy * 100) + mm);
        }
        int yymmDiff(int base_yymm, int yymm)
        {
            int b_yy = base_yymm / 100;
            int b_mm = base_yymm % 100;
            int yy = yymm / 100;
            int mm = yymm % 100;

            mm += (yy - b_yy) * 12;
            int n = (mm - b_mm);
            return (n);
        }

        int dayChk(int yymm,int adjustDayCnt)
        {

            int yy = yymm / 100;
            int mm = yymm % 100;
            Dictionary<DateTime, bool> dBuff = new Dictionary<DateTime, bool>();
            DateTime sDate = new DateTime(yy, mm, 1);
            DateTime eDate = sDate.AddMonths(1).AddDays(-1);
            DateTime curDate = sDate;
            do
            {
                dBuff.Add(curDate, "0,6".Contains(curDate.DayOfWeek.ToString("d")));            // "0":日 ,"6":土
                curDate = curDate.AddDays(1);
            } while (curDate <= eDate);


            string SQL = "";
            StringBuilder sql = new StringBuilder("");

            SqlConnection DB = new SqlConnection(DB_connectString);
            DB.Open();
            sql.Append(" SELECT *");
            sql.Append(" FROM EMG.dbo.勤務出勤日");
            sql.Append(" WHERE 日付 BETWEEN @sDate AND @eDate");
            sql.Append(" AND memberID = 0");

            sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
            sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
            SQL = sql.ToString();
            DateTime targetDay;
            bool offDay;
            SqlDataReader reader = dbRead(DB, SQL);
            while (reader.Read())
            {
                targetDay = (DateTime)reader["日付"];
                offDay = (bool)reader["offDay"];
                if(dBuff.ContainsKey(targetDay)) dBuff[targetDay] = offDay;
            }
            reader.Close();
            DB.Close();
            DB.Dispose();

            int Cnt = 0;
            DateTime target = new DateTime();
            foreach ( DateTime n in dBuff.Keys )
            {
                target = n;
                if (dBuff[n] == false) Cnt++;           // 出勤日を数える
                if (Cnt > adjustDayCnt) break;
            }
            Debug.Write(yymm.ToString(), target.Day.ToString());
            return (target.Day);
        }

        string 確定日(int year, int? yosokuCnt)
        {
            int adjustDayCnt = 7;
            //int? yosokuCnt = null;
            //int year = 2021;


            DateTime d = DateTime.Today;
            int yymm = (d.Year * 100) + d.Month;
            int OKday = dayChk(yymm, adjustDayCnt);
            yymm = (d.Day < OKday ? yymmAdd(yymm, -1) : yymmAdd(yymm, 0));      // データ有効月の計算(12日以前は前々月)

            int b_yymm = ((year - 1) * 100) + 10;

            int actualCnt = yymmDiff(b_yymm, yymm);

            if (actualCnt >= 12) actualCnt = 12;

            if (!yosokuCnt.HasValue)        // nullの時
            {
                yosokuCnt = 12 - actualCnt;
            }
            else
            {
                if (yosokuCnt == 0)
                {
                    //	すべて計画
                    actualCnt = 0;
                    yosokuCnt = 0;
                }
                else if (yosokuCnt < 0)
                {
                    // 残り全て予測
                    yosokuCnt = 12 - actualCnt;
                }
            }

            string Buff = "";
            var dispCnt = 12;
            var s_yymm = ((year - 1) * 100) + 10;


            // 次回の確定日のお知らせ
            if (actualCnt >= 0 && actualCnt < dispCnt)
            {
                int c_yymm = yymmAdd(s_yymm, actualCnt);
                int c_yy = c_yymm / 100;
                int c_mm = c_yymm % 100;
                int n_yymm = yymmAdd(c_yymm, 1);
                int n_yy = n_yymm / 100;
                int n_mm = n_yymm % 100;
                int n_dd = dayChk(n_yymm, adjustDayCnt);

                Buff = String.Concat(c_yy ,"年" ,c_mm ,"月の実績表示は" ,n_yy ,"年" ,n_mm ,"月" ,n_dd ,"日以降です");
            }
            else if (actualCnt == dispCnt)
            {
                Buff = "(すべて実績データです)";
            }
            else
            {
                Buff = "実績データはありません";
            }
            return (Buff);
        }
        void test()
        {
            int year = 2021;
            int? yosokuCnt = null;
            string Buff = 確定日(year,yosokuCnt);

            Debug.Write(Buff);
        }

        public object json_projectTest(String Json)
        {
            test();


            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            Tab.Add("mName", mName);
            Tab.Add("className", className);
            Tab.Add("methodName", methodName);
            Tab.Add("DB_Conn", DB_connectString);


            //            dbFunc_A();
            //object Tab = (object)testFunc();


            return (Tab);
        }

        public class RootObject
        {
            public List<group> hireSchedules { get; set; }
        }

        object testFuncX()
        {
            string mailAddr = "nakamura@eandm.co.jp";
            string jsonStr = "{'mailAddr':'" + mailAddr + "'}";
            hostWeb hWeb =new hostWeb();
            //var ret = hWeb.GetRequest("https://localhost:44308/WebApi/project/api/json" + "?mailAddr=" + mailAddr);
            var ret = hWeb.GetRequest("https://localhost:44308/WebApi/project/api/json" + "?item=jsonProc/memberInfo&json=" + jsonStr );
            return ("");
        }



        public XmlDocument projectTest(String Json)
        {

            Debug.WriteLog("projectTest");

            XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }

        /*
        var adjustDayCnt = 7
        var OK_DAY = dayChk(new Date(),adjustDayCnt)

        function dayChk(d,targetCnt)
            {
           var DB = Server.CreateObject("ADODB.Connection")
           var RS = Server.CreateObject("ADODB.Recordset")
           DB.Open( Session("ODBC") )
           DB.DefaultDatabase = "kansaDB"

           var sDate,eDate,curDate,n
           var value

           sDate = JsDateSerial(d.getFullYear(), d.getMonth()+1, 1)
           eDate = JsDateAdd("m", 1, sDate)
           eDate = JsDateAdd("d", -1, eDate)

        //------------------------------------------------------------------
           curDate = sDate 
           var n
           var dBuff = new Array()
           do{
              n = dBuff.length
              dBuff[n] = new Object;
              dBuff[n].日付 = JsFormatDateTime(curDate,2)
              dBuff[n].曜日 = JsWeekday(curDate) - 1
              dBuff[n].offDay = (dBuff[n].曜日 == 0 || dBuff[n].曜日 == 6 ? 1 : 0) 
              curDate = JsDateAdd("d", 1, curDate)
              }while(JsDay(curDate) != 1)

        //========================================================
        // 「土日以外で休み」及び「土日で出勤」する日のデータを更新する

           var SQL,date,offDay,yy,mm,dd
           SQL  = " SELECT *"
           SQL += " FROM EMG.dbo.勤務出勤日"
           SQL += " WHERE 日付 BETWEEN '" + JsFormatDateTime(sDate,2) + "' AND '" + JsFormatDateTime(eDate,2) + "'"
           SQL += "   AND"
           SQL += "   memberID=0"
           RS = DB.Execute(SQL)
           while( !RS.EOF ){
              date   = RS.Fields("日付").Value
              offDay = RS.Fields("offDay").Value
              n = JsDateDiff("d",JsFormatDateTime(sDate,2),JsFormatDateTime(date,2))
              dBuff[n].offDay = (offDay == true ? 1 : 0)
              RS.MoveNext()
              }
           RS.Close()
           DB.Close()
           var Cnt = 0
           for( n in dBuff ){
              if( dBuff[n].offDay == 0 ) Cnt++
              if( Cnt > targetCnt ) break;
              }
           var selDate = dBuff[n].日付
           var d = new Date(selDate)
           var OK_DAY = d.getDate()
           return(OK_DAY)
           }


         */

        class projectPara
        {
            public string visitBBS { get; set; }
            public string limitYear { get; set; }
        }
    }
}
