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
    public class 要員情報 
    {
        hostProc hProc;
        string DB_connectString;

        public 要員情報()
        {
            hProc = new hostProc();
            DB_connectString = hProc.DB_connectString;
        }
        public object 要員一覧_json(String Json)
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Dictionary<string, object> Info = new Dictionary<string, object>();
            Dictionary<string, object> Data = new Dictionary<string, object>();

            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Info.Add("mName", mName);
            Info.Add("className", className);
            Info.Add("methodName", methodName);
            Info.Add("DB_Conn", DB_connectString);

            Tab.Add("Info", (object)Info);
            Tab.Add("Data", (object)Data);

            //XmlDocument xmlDoc = new XmlDocument();
            Tab = dbFunc_A();

            return (Tab);
        }

        public XmlDocument 要員一覧(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            object json_data = 要員一覧_json(Json);
            XmlDocument xmlDoc = hProc.Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            //var x = new projectBBS();
            //Dictionary<string, object> Tab = (Dictionary<string, object>)x.projectList_json(Json);
            //object Data = (object) Tab["Data"];

            return (xmlDoc);
        }
        Dictionary<string, object> dbFunc_A()
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
                //sql.Append(" WHERE");
                //sql.Append("    MAST.pName IS NOT NULL");


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
        SqlDataReader dbRead(SqlConnection DB, string sql)
        {
            SqlCommand cmd = null;
            try
            {
                Debug.Write("cmd Start");
                cmd = new SqlCommand(sql, DB);
                SqlDataReader reader = cmd.ExecuteReader();
                return (reader);
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message);
                return (null);
            }
            finally
            {
                Debug.Write("cmd Dispose");
                cmd.Dispose();
                cmd = null;
            }
        }

        class SampleData
        {
            public string a { get; set; }
            public string b { get; set; }
        }
    }
}