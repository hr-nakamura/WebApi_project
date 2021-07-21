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
    public class QOSMIO :hostProc
    {
        public object json_projectTest(String Json)
        {
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


            dbFunc_A();



            return (Tab);
        }

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

            sql.Replace("@Numb", SqlUtil.Parameter(2));
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
