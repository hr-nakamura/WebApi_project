using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class QOSMIO : hostProc
    {
        public object json_projectTest(String Json)
        {
            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            //Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab.Add("mName", mName);
            //Tab.Add("className", className);
            //Tab.Add("methodName", methodName);
            //Tab.Add("DB_Conn", DB_connectString);


            //            dbFunc_A();
            object Tab = (object)testFunc();


            return (Tab);
        }
        public class Container
        {
            public class Nested
            {
                private Container parent;

                public Nested()
                {
                }
                public Nested(Container parent)
                {
                    this.parent = parent;
                }
            }
        }


        public class secInfo
        {
            public string 統括 { get; set; }
            public string 部門 { get; set; }
            public string 課 { get; set; }
        }
        public class costList
        {
            public string 種別 { get; set; }
            public string 直間 { get; set; }
            public secInfo 部署名 { get; set; }
            public string 部署コード{ get; set; }
            public accountInfo 合計 { get; set; }
            public accountInfo 計画 { get; set; }
            public accountInfo 予測 { get; set; }
            public accountInfo 実績 { get; set; }
            public accountInfo 配賦 { get; set; }
            public costList()
            {
                this.部署名 = new secInfo();
                this.合計 = new accountInfo();
                this.計画 = new accountInfo();
                this.予測 = new accountInfo();
                this.実績 = new accountInfo();
                this.配賦 = new accountInfo();
            }


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

        object testFunc()
        {

            costList cost = new costList();

            cost.部署名.部門 = "ABC";

            hostProc hProc = new hostProc();
            string basePath = hProc.basePath;

            //string filePath = basePath + @"\hostProc\QOSMIO\B_統括.json";
            string filePath = basePath + @"\hostProc\QOSMIO\部門リストデータ.json";

            string jsonString = File.ReadAllText(filePath, Encoding.GetEncoding("Shift_JIS"));
            var json = JsonConvert.DeserializeObject<List<group>>(jsonString);
            string mode = "";
            string s1 = "";
            string s2 = "";
            string s3 = "";
            string code = "";
            string name = "";

            Dictionary<string, group> Tab = new Dictionary<string, group>();
            json.ForEach(group =>
            {
                //Debug.Write(group.直間, group.統括, group.部門, group.課, group.code, group.名前);
                mode = group.直間;
                s1 = group.統括;
                s2 = group.部門;
                s3 = group.課;
                code = group.code;
                name = group.名前;

                if (  s1 != "" && !Tab.ContainsKey(s1))
                {
                    Tab.Add(s1, new group());
                    Tab[s1].直間 = mode;
                    Tab[s1].名前 = name;
                    Tab[s1].統括 = s1;
                    Tab[s1].部門 = s2;
                    Tab[s1].課 = s3;
                    Tab[s1].code = code;
                    Tab[s1].codes = code;
                    //Tab[s1].list = new Dictionary<string, group>();

                    //Debug.Write("Add1", s1);
                }
                if ( (s2 != "") && !Tab[s1].list.ContainsKey(s2) )
                {
                    Tab[s1].list.Add(s2, new group() );
                    Tab[s1].list[s2].直間 = mode;
                    Tab[s1].list[s2].名前 = name;
                    Tab[s1].list[s2].統括 = s1;
                    Tab[s1].list[s2].部門 = s2;
                    Tab[s1].list[s2].課 = s3;
                    Tab[s1].list[s2].code = code;
                    Tab[s1].codes = String.Concat(Tab[s1].codes,",",code);
                    Tab[s1].list[s2].codes = code;
                    //Tab[s1].list[s2].list = new Dictionary<string, group>();

                    //Debug.Write("Add2", s1, s2);
                }
                if ( (s2 != "" && s3 != "") && !Tab[s1].list[s2].list.ContainsKey(s3) )
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


            foreach (string 統括 in Tab.Keys)
            {
                Debug.Write(統括,Tab[統括].codes);
            }
            Debug.Write("=======");
            group Tab1 = Tab["開発本部"];

            foreach (string 部門 in Tab1.list.Keys)
            {
                Debug.Write(部門, Tab1.list[部門].codes);
            }
            Debug.Write("=======");
            group Tab2 = Tab["開発本部"].list["第1開発部"];
            foreach (string 課 in Tab2.list.Keys)
            {
                Debug.Write(課, Tab2.list[課].codes);
            }




            return (Tab);
        }
            //Dictionary<string, 
            //    Dictionary<string, 
            //    Dictionary<string, group>
            //    >
            //    > Tab = new Dictionary<string, Dictionary<string, Dictionary<string, group>>>();

            //string s1 = "abc";
            //string s2 = "xyz";
            //string s3 = "aaa";

            //if (!Tab.ContainsKey(s1) && s1 != "")
            //{
            //    Tab.Add(s1, new Dictionary<string, Dictionary<string, group>>());
            //    //Debug.Write("Add1", s1);
            //    }
            //else if (!Tab[s1].ContainsKey(s2) && s2 != "")
            //{
            //   Tab[s1].Add(s2, new Dictionary<string, group>());
            //   //Debug.Write("Add2", s2);
            //}
            //else if (!Tab[s1][s2].ContainsKey(s3) && s2 != "" && s3 != "")
            //{
            //    //Tab[s1][s2].Add(s3, new Dictionary<string, object>());
            //    //Tab[s1][s2].Add("name", name);
            //    //Debug.Write("Add3", s3);
            //}

        public XmlDocument projectTest(String Json)
        {

            Debug.WriteLog("projectTest");

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab = dbFunc_A();
            //dbFunc_A();
            Tab["ABC"] = "ABC";

            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);
            //var para = o_json.a;

            Dictionary<string, string> o_json = (Dictionary<string, string>) json_projectTest(Json);

            XmlDocument xmlDoc = makeXmlDoc(o_json);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }

        XmlDocument makeXmlDoc(Dictionary<string,string> Tab)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");

            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.AppendChild(xmlMain);
            xmlDoc.AppendChild(comment);
            xmlDoc.AppendChild(root);

            foreach(var x in Tab)
            {
                XmlElement data = xmlDoc.CreateElement("json");
                data.InnerText = x.Value;
                data.SetAttribute("name",x.Key);
                root.AppendChild(data);
            }

            return (xmlDoc);
        }

        Dictionary<string, object> dbFunc_A()
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            StringBuilder sql = new StringBuilder("");
            sql.Append(" SELECT");
            sql.Append("    pNum  = MAST.id,");
            sql.Append("    pName = MAST.mail");
            sql.Append(" FROM");
            sql.Append("    ログデータ MAST");
            sql.Append(" WHERE");
            sql.Append("    MAST.id = @Numb");
            DateTime toDay = DateTime.Now;

            sql.Replace("@Numb", SqlUtil.Parameter("number",2));
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = sql.ToString();
            //cmd.Parameters.Add(DbUtil.IntParameter("@Numb", 2));
            try
            {
                SqlConnection DB = new SqlConnection(DB_connectString);
                Debug.Write("DB Open");
                DB.Open();
                cmd.Connection = DB;

                SqlDataReader cReader = cmd.ExecuteReader();
                Debug.Write("cmd Dispose");
                cmd.Dispose();

                while (cReader.Read())
                {
                    int x = cReader.FieldCount;
                    string pNum = cReader["pNum"].ToString();
                    string pName = cReader["pName"].ToString();
                    Debug.Write(pNum, pName);
                }
                Debug.Write("reader Close");
                cReader.Close();
                Debug.Write("DB Close");
                DB.Close();
                Debug.Write("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message);
            }
            finally
            {
            }
            return (Tab);
        }

        Dictionary<string, object> dbFunc_AX()
        {
            SqlConnection DB;
            string pNum = "";
            string pName = "";
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            try
            {
                DB = new SqlConnection(DB_connectString);
                DB.Open();
                Debug.Write("DB Open", DB_connectString);

                StringBuilder sql = new StringBuilder("");
                sql.Append(" SELECT");
                sql.Append("    pNum  = MAST.id,");
                sql.Append("    pName = MAST.mail");
                sql.Append(" FROM");
                sql.Append("    ログデータ MAST");
                sql.Append(" WHERE");
                sql.Append("    MAST.id = 2");


                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.Write("reader Start");

                int i = 10;
                while (reader.Read())
                {
                    pNum = (string)reader["pNum"].ToString();
                    pName = (string)reader["pName"];
                    Debug.Write(pNum, pName);
                    if (!Tab.ContainsKey(pNum))
                    {
                        Tab.Add(pNum, pName);
                    }
                    if (i-- == 0) break;
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
                Debug.WriteLog(ex.Message);
            }
            finally
            {
                Debug.Write("DB null");
                DB = null;
            }
            return (Tab);
        }

        class projectPara
        {
            public string visitBBS { get; set; }
            public string limitYear { get; set; }
        }
    }
}
