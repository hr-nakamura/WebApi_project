using System;
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
        public XmlDocument 要員一覧(String s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            Dictionary<string, section>  x = xxx();
            //xmlDoc = JsonToXml(x);
            return (xmlDoc);
        }

        Dictionary<string, section> xxx()
        {
            Dictionary<string, string> Tab = new Dictionary<string, string>();
            StringBuilder sql = new StringBuilder("");

            string gCode;
            string T_name,H_name,B_name,G_name;
            List<string> TabX = new List<string>();
            int year = 2021;
            int mCnt = 12;
            int s_yymm = ((year - 1) * 100 + 10);
            int e_yymm = yymmAdd(s_yymm, mCnt - 1);
            string yakuStr = "1,2,34,35,37,38,39,40,41,42,43,44,88";
            //string dispMode = "統括";
            //string dispName = "開発本部";
            string dispMode = "本部";
            string dispName = "開発本部/";
            //string dispMode = "部門";
            //string dispName = "開発本部//第2開発部";
            //string dispMode = "グループ";
            //string dispName = "開発本部//第2開発部/第2開発課";
            ////string dispMode = "間接";
            //string dispName = "本社管理部門";
            string CondStr = "";

            Dictionary<string, string> dict = new Dictionary<string, string>()
                            {
                { "統括","TM.統括 = '" + dispName + "'" },
                { "本部","TM.統括+'/'+TM.本部 = '" + dispName + "'" },
                { "部門","TM.統括+'/'+TM.本部+'/'+TM.部門 ='" + dispName + "'" },
                { "グループ","TM.統括+'/'+TM.本部+'/'+TM.部門+'/'+TM.グループ ='" + dispName + "'" },
                { "コード","DATA.部署ID = '" + dispName + "'" },
                { "間接","DATA.直間 = 2" }
            };
            if (!dict.TryGetValue(dispMode, out CondStr))
            {
                CondStr = "DATA.直間 = -1";
            }

            Dictionary<string, section> xxxTab = new Dictionary<string, section>();
            section sec;
            member men;
            string mID;
            int yymm;
            //string SQL = sql.ToString();
            SqlConnection DB = new SqlConnection(DB_connectString);
            DB.Open();

            sql.Clear();
            sql.Append(" SELECT *");
            sql.Append("      FROM(");

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
            sql.Append("      社籍   = RTRIM(DATA.社籍),");
            sql.Append("      区分   = DATA.区分,");
            sql.Append("      mID    = DATA.memberID,");
            sql.Append("      名前   = MAST.姓 + MAST.名,");
            sql.Append("      よみ   = MAST.姓よみ + MAST.名よみ");
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
            sql.Append(" UNION ALL");

            sql.Append(" SELECT");
            sql.Append("       yymm   = DATA.yymm,");
            sql.Append("      T_name = '本社部門',");
            sql.Append("      H_name = '',");
            sql.Append("      B_name = '本社',");
            sql.Append("      G_name = (SELECT 部署名 FROM EMG.dbo.部署マスタ WHERE DATA.部署ID=部署コード AND SUBSTRING(CONVERT(char(6),DATA.yymm),1,4) + '/' +SUBSTRING(CONVERT(char(6),DATA.yymm),5,2) + '/01' BETWEEN 開始 and 終了),");
            sql.Append("      部署ID = DATA.部署ID,");
            sql.Append("      役職ID = DATA.役職ID,");
            sql.Append("      部署名 = (SELECT 部署名 FROM EMG.dbo.部署マスタ WHERE DATA.部署ID=部署コード AND SUBSTRING(CONVERT(char(6),DATA.yymm),1,4) + '/' +SUBSTRING(CONVERT(char(6),DATA.yymm),5,2) + '/01' BETWEEN 開始 and 終了),");
            sql.Append("      役職名 = (SELECT 役職名 FROM EMG.dbo.役職マスタ WHERE DATA.役職ID=役職コード AND SUBSTRING(CONVERT(char(6),DATA.yymm),1,4) + '/' +SUBSTRING(CONVERT(char(6),DATA.yymm),5,2) + '/01' BETWEEN 開始 and 終了),");
            sql.Append("      直間   = DATA.直間,");
            sql.Append("      休職   = DATA.休職,");
            sql.Append("      社籍   = RTRIM(DATA.社籍),");
            sql.Append("      区分   = DATA.区分,");
            sql.Append("      mID    = DATA.memberID,");
            sql.Append("      名前   = MAST.姓 + MAST.名,");
            sql.Append("      よみ   = MAST.姓よみ + MAST.名よみ");
            sql.Append(" FROM");
            sql.Append("      要員所属データ DATA");
            sql.Append("      LEFT JOIN EMG.dbo.社員基礎データ MAST ON DATA.memberID = MAST.社員ID");
            sql.Append(" WHERE");
            sql.Append("      DATA.yymm BETWEEN @s_yymm AND @e_yymm");
            sql.Append("      AND");
            sql.Append("      DATA.区分 IN(0,1,2,10)");
            sql.Append("      AND");
            sql.Append("      (DATA.直間 = 2 OR DATA.役職ID IN(@yakuStr))");
            sql.Append("      AND (SELECT 部署名 FROM EMG.dbo.部署マスタ WHERE DATA.部署ID=部署コード AND SUBSTRING(CONVERT(char(6),DATA.yymm),1,4) + '/' +SUBSTRING(CONVERT(char(6),DATA.yymm),5,2) + '/01' BETWEEN 開始 and 終了) = @dispName");
            //if (dispMode != "")
            //{
            //    sql.Append("      AND @CondStr");
            //}

            sql.Append(" ) as temp");

            sql.Append(" GROUP BY");
            sql.Append("      yymm,");
            sql.Append("      mID,");
            sql.Append("      T_name,");
            sql.Append("      H_name,");
            sql.Append("      B_name,");
            sql.Append("      G_name,");
            sql.Append("      部署ID,");
            sql.Append("      役職ID,");
            sql.Append("      部署名,");
            sql.Append("      役職名,");
            sql.Append("      直間,");
            sql.Append("      休職,");
            sql.Append("      社籍,");
            sql.Append("      区分,");
            sql.Append("      名前,");
            sql.Append("      よみ");
            sql.Append(" ORDER BY");
            sql.Append("      部署ID,");
            sql.Append("      yymm,");
            sql.Append("      よみ");

            sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
            sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
            sql.Replace("@yakuStr", SqlUtil.Parameter("number", yakuStr));
            sql.Replace("@CondStr", SqlUtil.Parameter("number", CondStr));
            sql.Replace("@dispName", SqlUtil.Parameter("string", dispName));

            string SQL = sql.ToString();

            SqlDataReader reader = dbRead(DB, SQL);
            while (reader.Read())
            {
                gCode = reader["部署ID"].ToString();
                mID = (string)reader["mID"].ToString();

                T_name = (string)reader["T_name"].ToString();
                H_name = (string)reader["H_name"].ToString();
                B_name = (string)reader["B_name"].ToString();
                G_name = (string)reader["G_name"].ToString();

                if (!xxxTab.ContainsKey(gCode))
                {
                    sec = new section();
                    sec.名前 = String.Join("",T_name,'/',H_name, '/', B_name, '/', G_name);
                    sec.member = new Dictionary<string, member>();
                    xxxTab.Add(gCode, sec);
                }
                if (!xxxTab[gCode].member.ContainsKey(mID))
                {
                    men = new member();
                    men.名前 = (string)reader["名前"].ToString();
                    men.月 = new List<Info>() { new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info(), new Info() };
                    xxxTab[gCode].member.Add(mID, men);
                }
                yymm = (int)reader["yymm"];
                var m = yymmDiff(s_yymm, yymm);
                Info Info = xxxTab[gCode].member[mID].月[m];
                Info.社籍 = (string)reader["社籍"].ToString();
                Info.役職 = (string)reader["役職名"].ToString();
                Info.休職 = (short)reader["休職"];
                Info.役職ID = (short)reader["役職ID"];
                Info.社員区分 = (short)reader["区分"];
            }
            reader.Close();

            DB.Close();
            DB.Dispose();

            return (xxxTab);
        }
        public class Info
        {
            public string 社籍 { get; set; }
            public string 役職 { get; set; }
            public short 役職ID { get; set; }
            public short 社員区分 { get; set; }
            public short 休職 { get; set; }
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
            sql.Append("      S_name = SM.統括+'/'+SM.本部+'/'+SM.部門,");
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
    }
}