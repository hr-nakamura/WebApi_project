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
            var Tab = dbFunc_A();

            return (Tab);
        }
        public object dbFunc_A()
        {
            List<group> Info = new List<group>();
            Dictionary<string,Dictionary<string, Dictionary<string, object>>> Tab = new Dictionary<string, Dictionary<string, Dictionary<string, object>>>();
            SqlConnection DB;
            string gCode = "";
            Dictionary<string, object> Tab1 = new Dictionary<string, object>();
            string secMode = "直接";
            string dispMode = "統括";
            string s_yymm = "201810";
            string e_yymm = "201909";
            string secNum = "0,1,2";
            string s1 = "";
            string s2 = "";
            string s3 = "";
            string name = "";
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
                //if (secMode == "間接" && dispMode == "統括")
                //{
                //    sql.Append("    AND");
                //    sql.Append("    TM.部署ID >= 0");
                //}
                //else
                //{
                //    sql.Append("    AND");
                //    sql.Append("    TM.部署ID > 0");
                //}

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
                    var mode = (string)reader["直間"].ToString();
                    s1 = (string)reader["統括"].ToString();
                    s2 = (string)reader["部門"].ToString();
                    s3 = (string)reader["課"].ToString();
                    name = (string)reader["名前"].ToString();
                    gCode = (string)reader["gCode"].ToString();
                    //Debug.Write("====", s1, s2, s3);
                    group xxx = new group() { 直間 = mode, 名前 = name, 統括 = s1, 部門 = s2, 課 = s3, code = gCode };
                    Info.Add(xxx);

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
                                //Tab[s1][s2].Add("name", gCode);
                                //Debug.Write("Add3", s3);

                    }


//=======================================

                    //if (!Tab1.ContainsKey(s1))
                    //{
                    //    Tab1.Add(s1, name);
                    //}
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
        class group
        {
            public string 直間 { get; set; }
            public string 名前 { get; set; }
            public string code { get; set; }
            public string 統括 { get; set; }
            public string 部門 { get; set; }
            public string 課 { get; set; }
        }
    }
}
