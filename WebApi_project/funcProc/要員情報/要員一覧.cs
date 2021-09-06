﻿using System;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Diagnostics;
using CodingSquareCS;

namespace WebApi_project.hostProc
{
    public class 要員情報 : hostProc
    {
        public object json_要員一覧(String Json)
        {
            //Dictionary<string, object> Tab = new Dictionary<string, object>();
            //Dictionary<string, object> Info = new Dictionary<string, object>();
            //Dictionary<string, object> Data = new Dictionary<string, object>();

            //string classPath = this.GetType().FullName;                                         //クラスパスの取得
            //string className = this.GetType().Name;                                             //クラス名の取得
            //string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得

            //string mName = Environment.MachineName;

            //Info.Add("mName", mName);
            //Info.Add("className", className);
            //Info.Add("methodName", methodName);
            //Info.Add("DB_Conn", DB_connectString);

            //Tab.Add("Info", (object)Info);

            var Tab = x();
            /*
                        string url = "http://localhost/Project/要員情報/要員一覧/xml/要員一覧_XML.asp?year=2021";
                        hostWeb h = new hostWeb();
                        string xmlStr = h.GetRequest(url);

                        Tab.Add("Data", xmlStr);
            */
            return (Tab);
        }

        public XmlDocument 要員一覧(String Json)
        {

            var sw = new StopWatch();
            sw.Start("計測開始"); // 計測開始

            Dictionary<string, dynamic> Tab = (Dictionary<string, dynamic>)json_要員一覧(Json);
            sw.Lap("変換");

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(Tab["Data"]);

            sw.Stop();
            return (xmlDoc);
        }
        Dictionary<string, section> x()
        {
            Dictionary<string, string> Tab = new Dictionary<string, string>();
            StringBuilder sql = new StringBuilder("");

            string gCode;
            string gName;
            List<string> TabX = new List<string>();
            int year = 2021;
            int mCnt = 12;
            int s_yymm = ((year - 1) * 100 + 10);
            int e_yymm = yymmAdd(s_yymm, mCnt - 1);
            string yakuStr = "1,2,34,35,37,38,39,40,41,42,43,44,88";
            string dispMode = "グループ";
            string dispName = "営業本部営業部営業1課";
            string CondStr = "";

            Dictionary<string, string> dict = new Dictionary<string, string>()
                            {
                { "統括","TM.統括 = '" + dispName + "'" },
                { "本部","TM.統括+TM.本部 = '" + dispName + "'" },
                { "部門","TM.統括+TM.本部+TM.部門 ='" + dispName + "'" },
                { "グループ","TM.統括+TM.本部+TM.部門+TM.グループ ='" + dispName + "'" },
                { "コード","DATA.部署ID = '" + dispName + "'" },
                { "間接","DATA.直間 = 2" }
            };
            if (!dict.TryGetValue(dispMode, out CondStr) ){
                CondStr = "DATA.直間 = -1";
            }

            
            sql.Clear();
            sql.Append(" SELECT");
            sql.Append("       yymm   = DATA.yymm,");
            sql.Append("      T_name = TM.統括,");
            sql.Append("      H_name = TM.本部,");
            sql.Append("      B_name = TM.部門,");
            sql.Append("      G_name = TM.グループ,");
            sql.Append("      部署ID = DATA.部署ID,");
            sql.Append("      役職ID = DATA.役職ID,");
            sql.Append("      部署名 = (SELECT 部署名 FROM EMG.dbo.部署マスタ WHERE DATA.部署ID=部署コード AND SUBSTRING(CONVERT(char(6),DATA.yymm),1,4) + '/' +SUBSTRING(CONVERT(char(6),DATA.yymm),5,2) + '/01' BETWEEN 開始 and 終了),");
            sql.Append("      役職名 = (SELECT 役職名 FROM EMG.dbo.役職マスタ WHERE DATA.役職ID=役職コード AND SUBSTRING(CONVERT(char(6),DATA.yymm),1,4) + '/' +SUBSTRING(CONVERT(char(6),DATA.yymm),5,2) + '/01' BETWEEN 開始 and 終了),");
            sql.Append("      直間   = DATA.直間,");
            sql.Append("      休職   = DATA.休職,");
            sql.Append("      社籍   = DATA.社籍,");
            sql.Append("      区分   = DATA.区分,");
            sql.Append("      mID    = DATA.memberID,");
            sql.Append("      名前   = MAST.姓 + MAST.名");
            sql.Append(" FROM");
            sql.Append("      要員所属データ DATA");
            sql.Append("      LEFT JOIN EMG.dbo.社員基礎データ MAST ON DATA.memberID = MAST.社員ID");
            sql.Append("      LEFT JOIN 統括本部マスタ         TM   ON DATA.部署ID   = TM.部署ID");
            sql.Append(" WHERE");
            sql.Append("      TM.開始 < @e_yymm AND TM.終了 >= @s_yymm");
            sql.Append("      AND");
            sql.Append("      DATA.yymm BETWEEN @s_yymm AND @e_yymm");
            sql.Append("      AND");
            sql.Append("      DATA.区分 IN(0,1,2,10)");
            sql.Append("      AND");
            sql.Append("       DATA.直間 <> 2 AND DATA.役職ID NOT IN(@yakuStr)");
            if (dispMode != "")
            {
                sql.Append("      AND @CondStr");
            }
            sql.Append(" GROUP BY");
            sql.Append("      DATA.yymm,");
            sql.Append("      TM.統括,");
            sql.Append("      TM.本部,");
            sql.Append("      TM.部門,");
            sql.Append("      TM.グループ,");
            sql.Append("      DATA.memberID,");
            sql.Append("      DATA.部署ID,");
            sql.Append("      DATA.役職ID,");
            sql.Append("      DATA.直間,");
            sql.Append("      DATA.休職,");
            sql.Append("      DATA.社籍,");
            sql.Append("      DATA.区分,");
            sql.Append("      MAST.姓 + MAST.名,");
            sql.Append("      MAST.姓よみ + MAST.名よみ");
            sql.Append(" ORDER BY");
            sql.Append("      部署ID,");
            sql.Append("      yymm,");
            sql.Append("      MAST.姓よみ + MAST.名よみ");

            sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
            sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
            sql.Replace("@yakuStr", SqlUtil.Parameter("number", yakuStr));
            sql.Replace("@CondStr", SqlUtil.Parameter("number", CondStr));

            Dictionary<string, section> xxxTab = new Dictionary<string, section>();
            section sec;
            Info Info;
            member men;
            string mID,mName;
            string SQL = sql.ToString();
            SqlConnection DB = new SqlConnection(DB_connectString);
            DB.Open();
            SqlDataReader reader = dbRead(DB, SQL);
            while (reader.Read())
            {
                gCode = reader["部署ID"].ToString();
                gName = (string)reader["部署名"].ToString();
                mID = (string)reader["mID"].ToString();
                mName = (string)reader["名前"].ToString();


                if ( !xxxTab.ContainsKey(gCode))
                {
                    sec = new section();
                    sec.名前 = gName;
                    sec.member = new Dictionary<string, member>();
                    xxxTab.Add(gCode, sec);
                }
                if (!xxxTab[gCode].member.ContainsKey(mID))
                {
                    men = new member();
                    men.名前 = mName;
                    men.月 = new List<Info>() { new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info() };
                    xxxTab[gCode].member.Add(mID, men);
                }
                xxxTab[gCode].member[mID].月[0].休職 = "123";
                /*
                                Info Info = new Info();
                                member men = new member();
                                men.月 = new List<Info>() { Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, };


                                sec.名前 = "開発";
                                sec.member = new Dictionary<string, member>();
                                sec.member.Add("451862", men);
                                sec.member["451862"].名前 = "中村";
                                sec.member["451862"].月[0].休職 = "222";

                                sec.member.Add("123456", men);
                                sec.member["123456"].名前 = "山田";
                                sec.member["123456"].月[0].休職 = "999";
                */




            }
            reader.Close();

            DB.Close();
            DB.Dispose();

            return (xxxTab);
        }
void xxx()
        {
            Dictionary<string, section> xxxTab = new Dictionary<string, section>();
            List<Info> Info2 = new List<Info>(12);

            Info Info1 = new Info();
            Info1.休職 = "123";
            member men = new member();
            men.名前 = "中村";
            men.月 = Info2;
            men.月[0] = Info1;
            //men.月[0].休職 = "120";

            section sec = new section();
            sec.名前 = "開発";
            sec.member = new Dictionary<string, member>();
            sec.member.Add("451862",men);

            xxxTab.Add("グループコード", sec);

            //xxxTab[secName][種別][大項目][項目][n];


        }
        public class Info
        {
            public string 役職ID { get; set; }
            public string 役職 { get; set; }
            public string 社員区分 { get; set; }
            public string 社籍 { get; set; }
            public string 休職 { get; set; }
        }
        public class member
        {
            public string 名前 { get; set; }
            public List<Info> 月 { get; set; }
        }
        public class section
        {
            public string 名前 { get; set; }
            public int 直間 { get; set; }
            public Dictionary<string, member> member { get; set; }
        }
/*
        m = yymmDiff(s_yymm, c_yymm)
		if( !IsObject(Tab[GrpID]) ) Tab[GrpID] = {名前:gName,直間:直間,member:{}}
		if( !IsObject(Tab[GrpID].member[mID]) ){
			Tab[GrpID].member[mID] = {名前:name,月:{}}
			}
		Tab[GrpID].member[mID].月[m] = { 役職ID: yaku,役職: yName,社員区分: 区分,社籍: 社籍,休職: 休職}
*/
void x2()
        {
            Dictionary<string, string> Tab = new Dictionary<string, string>();
            StringBuilder sql = new StringBuilder("");
            /*
                        string grpStr = "71,72";

                        sql.Clear();
                        sql.Append(" SELECT");
                        sql.Append("      mode  = BMAST.直間,");
                        sql.Append("      gName = BMAST.部署名,");
                        sql.Append("      gCode = BMAST.部署コード");
                        sql.Append(" FROM");
                        sql.Append("      EMG.dbo.部署マスタ BMAST");
                        sql.Append(" WHERE");
                        sql.Append("      BMAST.部署コード IN(@grrStr)");
                        sql.Append(" ORDER BY");
                        sql.Append("       BMAST.終了");
                        sql.Replace("@grrStr", SqlUtil.Parameter("number", grpStr));

                        string SQL = sql.ToString();
                        SqlConnection DB = new SqlConnection(DB_connectString);
                        DB.Open();
                        SqlDataReader reader = dbRead(DB, SQL);
                        string gCode;
                        string gName;
                        while (reader.Read())
                        {
                            //gCode = reader["gCode"].ToString();
                            //gName = (string)reader["gName"].ToString();
                            //Tab.Add(gCode, gName);
                        }
                        reader.Close();

                        DB.Close();
                        DB.Dispose();
            */
            string gCode;
            string gName;
            List<string> TabX = new List<string>();
            int year = 2021;
            int mCnt = 12;
            int s_yymm = ((year - 1) * 100 + 10);
            int e_yymm = yymmAdd(s_yymm, mCnt - 1);
            sql.Clear();
            sql.Append(" SELECT");
            sql.Append("      S_name = SM.統括+SM.本部+SM.部門,");
            sql.Append("      T_name = SM.統括,");
            sql.Append("      B_name = SM.部門,");
            sql.Append("      G_name = SM.グループ,");
            sql.Append("      G_code = SM.部署ID");
            sql.Append(" FROM");
            sql.Append("      統括本部マスタ SM");
            sql.Append(" WHERE");
            sql.Append("      SM.開始 <  @e_yymm");
            sql.Append("      AND");
            sql.Append("      SM.終了 >= @s_yymm");
            sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
            sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));

            string SQL = sql.ToString();
            SqlConnection DB = new SqlConnection(DB_connectString);
            DB.Open();
            SqlDataReader reader1 = dbRead(DB, SQL);
            while (reader1.Read())
            {
                gCode = reader1["S_name"].ToString();
                gName = (string)reader1["S_name"].ToString();
                TabX.Add(gName);
            }
            reader1.Close();

            DB.Close();
            DB.Dispose();

        }
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
    }
}