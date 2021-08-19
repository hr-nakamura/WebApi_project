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
        void test()
        {
            DateTime sDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month , 1);
            DateTime eDate = sDate.AddMonths(1).AddDays(-1);
            DateTime curDate = sDate;

            var a = 1;

/*

        //------------------------------------------------------------------
            curDate = sDate
           var n
           var dBuff = new Array()
           do
            {
                n = dBuff.length
              dBuff[n] = new Object;
                dBuff[n].日付 = JsFormatDateTime(curDate, 2)
              dBuff[n].曜日 = JsWeekday(curDate) - 1
              dBuff[n].offDay = (dBuff[n].曜日 == 0 || dBuff[n].曜日 == 6 ? 1 : 0)
              curDate = JsDateAdd("d", 1, curDate)
              } while (JsDay(curDate) != 1)



            DateTime sDate = DateTime.Parse(s_sDate);
            DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);


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

            SqlDataReader reader = dbRead(DB, SQL);
            while (reader.Read())
            {

            }
            reader.Close();
            DB.Close();
            DB.Dispose();
*/
            int year = 2020;
            int s_yymm = ((year - 1) * 100 + 10);
            int c_yymm = 202107;
            int actualCnt = 10;
            int yosokuCnt = 2;
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
