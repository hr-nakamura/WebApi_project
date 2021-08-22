using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class jsonProc
    {
        public XmlDocument 部門リスト(String Json)
        {
            if (Json == "{}")
            {
                //Json = "{dispCmd:'EMG',year:'2021', yosoku:'3', fix:'70' }";
                Json = "{dispCmd:'統括一覧',year:'2021', yosoku:'3', fix:'70' }";
                //Json = "{dispCmd:'詳細',統括:'営業本部',year:'2021', yosoku:'3', fix:'70' }";
            }
            var o_json = JsonConvert.DeserializeObject<cmd_部門収支>(Json);
            object json_data = json_部門リスト(o_json);
            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }

        public Dictionary<string, group> json_部門リスト(cmd_部門収支 o_json)
        {
            //Json = "{year:'2021',secMode:'全社',dispMode:'全社'}";
            // secMode : 開発、間接、全社
            // dispMode : 全社、統括、部門、グループ
            List<db_group> dataTab = get_group_data(o_json);                                  // DBからデータ取得
            Dictionary<string, group> Tab = convert_group_data(dataTab);                    // 取得したデータを加工

            return (Tab);
        }
        List<db_group> get_group_data(cmd_部門収支 o_json)
        {
            List<db_group> dataTab = new List<db_group>();
            Dictionary<string, group> Tab = new Dictionary<string, group>();
            SqlConnection DB;
            Dictionary<string, object> Tab1 = new Dictionary<string, object>();
            string secMode = o_json.secMode;          // 開発、間接、全社
            string dispMode = o_json.dispMode;        // 統括、
            int year = o_json.year;
            string s_yymm = ((year -1)*100 + 10).ToString();
            string e_yymm = ((year * 100) + 9).ToString();
            //string secNum = "";
            string mode = "";
            string s1 = "";
            string s2 = "";
            string s3 = "";
            string name = "";
            string code = "";
            switch (secMode)
            {
                case "開発":
                    mode = "0,1";
                    break;
                case "間接":
                    mode = "2";
                    break;
                default:
                    mode = "0,1,2";
                    break;
            }

            try
            {
                DB = new SqlConnection(DB_connectString);
                DB.Open();
                Debug.noWrite("DB Open", DB_connectString);

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
                sql.Append("    TM.直間 IN(@mode)");
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
                sql.Replace("@mode", SqlUtil.Parameter("number", mode));
                var x = sql.ToString();

                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.noWrite("reader Start");


                while (reader.Read())
                {
                    mode = (string)reader["直間"].ToString();
                    s1 = (string)reader["統括"].ToString();
                    s2 = (string)reader["部門"].ToString();
                    s3 = (string)reader["課"].ToString();
                    name = (string)reader["名前"].ToString();
                    code = (string)reader["gCode"].ToString();
                    db_group data = new db_group()
                    {
                        直間 = (string)reader["直間"].ToString(),
                        統括 = (string)reader["統括"].ToString(),
                        部門 = (string)reader["部門"].ToString(),
                        課 = (string)reader["課"].ToString(),
                        名前 = (string)reader["名前"].ToString(),
                        code = (string)reader["gCode"].ToString()
                    };


                    dataTab.Add(data);
                }
                Debug.noWrite("reader Close");
                reader.Close();

                Debug.noWrite("DB Close");
                DB.Close();
                Debug.noWrite("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message,s1,s2,s3,name);
            }
            finally
            {
                Debug.noWrite("DB null");
                DB = null;
            }
            return (dataTab);
        }

        Dictionary<string, group> convert_group_data(List<db_group> dataTab)
        {
            Dictionary<string, group> Tab = new Dictionary<string, group>();
            string mode = "";
            string s1 = "";
            string s2 = "";
            string s3 = "";
            string name = "";
            string code = "";
            dataTab.ForEach(group =>
            {
                //Debug.Write(group.直間, group.統括, group.部門, group.課, group.code, group.名前);
                mode = group.直間;
                s1 = group.統括;
                s2 = group.部門;
                s3 = group.課;
                code = group.code;
                name = group.名前;

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

                    //Debug.Write("Add1", s1, s2, s3);
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

                    //Debug.Write("Add2", s1, s2, s3);
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
            });


            //Debug.Write("=======");
            //foreach (string 統括 in Tab.Keys)
            //{
            //    var x = Tab[統括];
            //    costList cost = new costList(直間: x.直間, 統括: x.統括, 部門: x.部門, 課: x.課, 部署コード: x.codes);
            //    Debug.Write(統括, Tab[統括].codes);
            //}
            //Debug.Write("=======");
            //group Tab1 = Tab["開発本部"];

            //foreach (string 部門 in Tab1.list.Keys)
            //{
            //    var x = Tab1.list[部門];
            //    costList cost = new costList(直間: x.直間, 統括: x.統括, 部門: x.部門, 課: x.課, 部署コード: x.codes);
            //    Debug.Write(部門, Tab1.list[部門].codes);
            //}
            //Debug.Write("=======");
            //group Tab2 = Tab["開発本部"].list["第1開発部"];
            //foreach (string 課 in Tab2.list.Keys)
            //{
            //    var x = Tab2.list[課];
            //    costList cost = new costList(直間: x.直間, 統括: x.統括, 部門: x.部門, 課: x.課, 部署コード: x.codes);
            //    Debug.Write(課, Tab2.list[課].codes);
            //}




            return (Tab);
        }

        class db_group
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
