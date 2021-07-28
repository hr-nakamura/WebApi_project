using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class jsonProc
    {
        public XmlDocument 部門リスト(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);
            object json_data = json_部門リスト(Json);
            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }

        public object json_部門リスト(string Json)
        {
            Json = "{year:'2018',secMode:'間接',dispMode:'統括'}";
            var Tab = dbFunc_A(Json);

            return (Tab);
        }
        public object dbFunc_A(string Json)
        {
        /*
        ＥＭＧ収支計画
        {
            "year": "2021",
            "secMode": "開発",
            "dispMode": "全社",
            "dispName": "",
            "listMode": "詳細",
            "haifuMode": false
        }
        統括収支計画
        {
            "year": "2021",
            "secMode": "開発",
            "dispMode": "統括",
            "dispName": "",
            "listMode": "一覧",
            "haifuMode": true
        }
        部門収支計画
        {
            "year": "2021",
            "secMode": "開発",
            "dispMode": "部門",
            "dispName": "",
            "listMode": "一覧",
            "haifuMode": true"
        }
        課 別収支
        {
            "year": "2021",
            "secMode": "開発",
            "dispMode": "グループ",
            "dispName": "営業本部",
            "listMode": "一覧",
            "haifuMode": true
        }
        */
            var o_json = JsonConvert.DeserializeObject<部門指定>(Json);
            Dictionary<string, group> Tab = new Dictionary<string, group>();
            SqlConnection DB;
            Dictionary<string, object> Tab1 = new Dictionary<string, object>();
            string secMode = o_json.secMode;          // 開発、間接、全社
            string dispMode = o_json.dispMode;          // 統括、
            int year = int.Parse(o_json.year);
            string s_yymm = ((year -1)*100 + 10).ToString();
            string e_yymm = ((year * 100) + 9).ToString();
            string secNum = "";
            string mode = "";
            string s1 = "";
            string s2 = "";
            string s3 = "";
            string name = "";
            string code = "";
            switch (secMode)
            {
                case "開発":
                    secNum = "0,1";
                    break;
                case "間接":
                    secNum = "2";
                    break;
                default:
                    secNum = "0,1,2";
                    break;
            }

            try
            {
                DB = new SqlConnection(DB_connectString);
                DB.Open();
                Debug.Write("DB Open", DB_connectString);

                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                sql.Append("   名前  = BMAST.部署名,");
                sql.Append("   直間  = TM.直間,");
                sql.Append("   統括  = TM.統括,");
                sql.Append("   部門  = TM.部門,");
                sql.Append("   課    = TM.グループ,");
                sql.Append("   gCode = TM.部署ID");

                sql.Append(" FROM");
                sql.Append("    統括本部マスタ TM");
                sql.Append("        LEFT JOIN EMG.dbo.部署マスタ BMAST ON TM.部署ID = BMAST.部署コード");
                sql.Append(" WHERE");
                sql.Append("    NOT(TM.開始 > @e_yymm or TM.終了 < @s_yymm)");
                sql.Append("    AND");
                sql.Append("    TM.直間 IN(@secNum)");
                if (secMode == "間接" && dispMode == "統括")
                {
                    sql.Append("    AND");
                    sql.Append("    TM.部署ID >= 0");
                }
                else
                {
                    sql.Append("    AND");
                    sql.Append("    TM.部署ID > 0");
                }

                sql.Append(" ORDER BY");
                sql.Append("    直間 desc,");
                sql.Append("    統括,");
                sql.Append("    部門,");
                sql.Append("    課,");
                sql.Append("    gCode");

                sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
                sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
                sql.Replace("@secNum", SqlUtil.Parameter("number", secNum));
                var x = sql.ToString();

                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.Write("reader Start");

                while (reader.Read())
                {
                    mode = (string)reader["直間"].ToString();
                    s1 = (string)reader["統括"].ToString();
                    s2 = (string)reader["部門"].ToString();
                    s3 = (string)reader["課"].ToString();
                    name = (string)reader["名前"].ToString();
                    code = (string)reader["gCode"].ToString();
                    if (s1 != "" && !Tab.ContainsKey(s1))
                    {
                        Tab.Add(s1, new group());
                        Tab[s1].直間 = mode;
                        Tab[s1].名前 = name;
                        Tab[s1].統括 = s1;
                        Tab[s1].部門 = s2;
                        Tab[s1].課 = s3;
                        Tab[s1].code = code;
                        Tab[s1].codes = code;
                        Tab[s1].list = new Dictionary<string, group>();

                        //Debug.Write("Add1", s1);
                    }
                    if ((s2 != "") && !Tab[s1].list.ContainsKey(s2))
                    {
                        Tab[s1].list.Add(s2, new group());
                        Tab[s1].list[s2].直間 = mode;
                        Tab[s1].list[s2].名前 = name;
                        Tab[s1].list[s2].統括 = s1;
                        Tab[s1].list[s2].部門 = s2;
                        Tab[s1].list[s2].課 = s3;
                        Tab[s1].list[s2].code = code;
                        Tab[s1].codes = String.Concat(Tab[s1].codes, ",", code);
                        Tab[s1].list[s2].codes = code;
                        Tab[s1].list[s2].list = new Dictionary<string, group>();

                        //Debug.Write("Add2", s1, s2);
                    }
                    if ((s2 != "" && s3 != "") && !Tab[s1].list[s2].list.ContainsKey(s3))
                    {
                        Tab[s1].list[s2].list.Add(s3, new group());
                        Tab[s1].list[s2].list[s3].直間 = mode;
                        Tab[s1].list[s2].list[s3].名前 = name;
                        Tab[s1].list[s2].list[s3].統括 = s1;
                        Tab[s1].list[s2].list[s3].部門 = s2;
                        Tab[s1].list[s2].list[s3].課 = s3;
                        Tab[s1].list[s2].list[s3].code = code;
                        Tab[s1].codes = String.Concat(Tab[s1].codes, ",", code);
                        Tab[s1].list[s2].codes = String.Concat(Tab[s1].list[s2].codes, ",", code);
                        Tab[s1].list[s2].list[s3].codes = code;
                        //Debug.Write("Add3", s1, s2, s3);
                    }
                }
                Debug.Write("reader Close");
                reader.Close();

                Debug.Write("DB Close");
                DB.Close();
                Debug.Write("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message,s1,s2,s3,name);
            }
            finally
            {
                Debug.Write("DB null");
                DB = null;
            }
            return (Tab);
        }
        /*
                     if (!Tab.ContainsKey(s1) && s1 != "")
                            {
                                Tab.Add(s1, new Dictionary<string, Dictionary<string, object>>());
                                //Debug.Write("Add1", s1);
                            }
                            else if (!Tab[s1].ContainsKey(s2) && s2 != "")
                            {
                                Tab[s1].Add(s2, new Dictionary<string, object>());
                                //Debug.Write("Add2", s2);
                            }
                            else if (!Tab[s1][s2].ContainsKey(s3) && s2 != "" && s3 != "")
                            {
                                Tab[s1][s2].Add(s3, new Dictionary<string, object>());
                                //Tab[s1][s2].Add("name", name);
                                //Debug.Write("Add3", s3);

                            }

         */
        public class 部門指定
        {
            public string year { get; set; }
            public string secMode { get; set; }
            public string dispMode { get; set; }
        }
        public class group
        {
            public string 直間 { get; set; }
            public string 名前 { get; set; }
            public string code { get; set; }
            public string codes { get; set; }
            public string 統括 { get; set; }
            public string 部門 { get; set; }
            public string 課 { get; set; }
            public Dictionary<string, group> list { get; set; }
        }
    }
}
