using System;
using System.Web;
using System.Reflection;
using System.Xml;
using System.Data.SqlClient;
using System.Linq;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Runtime.CompilerServices;
using System.IO;
using System.Text;

using System.Collections;



using Util;
using DebugHost;

namespace WebApi_project.hostProc
{
    public class hostProc
    {
        // DBコネクション
        public string basePath = "";
        public string DB_connectString = "";
        public Boolean DB_status = true;
        public string DB_result;
        public SqlConnectionStringBuilder DB_builder = new SqlConnectionStringBuilder();
        public string DB_comment = "123";
        public string LogPath = "";

        HttpContext context = HttpContext.Current;
        public hostProc()
        {
            //QOSMIO
            //HttpContext.Current.Request.Cookies("visitBBS");
            //HttpCookieCollection MyCookieColl;
            //MyCookieColl = HttpContext.Current.Request.Cookies;
            //String[] arr1 = MyCookieColl.AllKeys;

            string mName = Environment.MachineName;
            //Debug.Write("hostProc Start", mName);
            string DB_mode = "データベース";
            switch (mName)
            {
                case "QOSMIO":
                    DB_mode = "データベース_QOSMIO";
                    break;
                case "SURFACE-PC":
                    DB_mode = "データベース_SURFACE";
                    basePath = @"E:\GitHub\hr-nakamura\WebApi_project\WebApi_project";
                    break;
                case "NAKAMURA-RD":
                    DB_mode = "データベース_naka";
                    basePath = @"D:\GitHub\hr-nakamura\WebApi_project\WebApi_project";
                    break;
                case "NAKAMURA-RD2":
                    DB_mode = "データベース_naka";
                    basePath = @"D:\GitHub\hr-nakamura\WebApi_project\WebApi_project";
                    break;
                case "EMG-APSV":                            /// kansa Web サーバ
                    DB_mode = "データベース_EMG";
                    break;
                default:
                    DB_mode = "データベース";
                    break;
            }

            HttpContext context = HttpContext.Current;
            LogPath = context.Server.MapPath("/Log");

            string AppPath = context.Request.ApplicationPath;
            string iFile = context.Server.MapPath(AppPath + "/App_Data/system.ini");
            IniFile ini = new IniFile(iFile);



            string _DataSource = ini.GetValue(DB_mode, "DataSource", "");
            string _UserID = ini.GetValue(DB_mode, "UserID", "");
            string _Password = ini.GetValue(DB_mode, "Password", "");
            string _InitialCatalog = ini.GetValue(DB_mode, "InitialCatalog", "");
            string _Title = ini.GetValue(DB_mode, "Title", "読込失敗");

            //            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
            DB_builder.DataSource = _DataSource;
            DB_builder.UserID = _UserID;
            DB_builder.Password = _Password;
            DB_builder.InitialCatalog = _InitialCatalog;
            DB_connectString = DB_builder.ConnectionString;
            //Debug.Write("database connect", DB_connectString);

            //IP_Chech(_DataSource);

        }
        public string getAbsoluteFileName( string fileName )
        {
            HttpContext context = HttpContext.Current;
            string AppPath = context.Request.ApplicationPath;
            string iFile = context.Server.MapPath(AppPath + fileName);
            return (iFile);
        }
        public SqlDataReader dbRead(SqlConnection DB, string sql)
        {
            SqlCommand cmd = null;
            try
            {
                Debug.noWrite("cmd Start");
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
                Debug.noWrite("cmd Dispose");
                cmd.Dispose();
                cmd = null;
            }
        }
        void IP_Chech(string IPAddr)
        {
            //解決したいIPアドレス

            System.Net.IPHostEntry iphe;
            //Debug.Write("start");
            //IPHostEntryオブジェクトを取得
            try
            {
                iphe = System.Net.Dns.GetHostEntry(IPAddr);
                DB_result = iphe.HostName;
            }

            catch (Exception ex)
            {
                DB_result = ex.Message;
                DB_status = false;
            }
            finally
            {
            }
        }

        public JObject Jsonl_Info(object Json)
        {
            JObject O_Top = new JObject();
            ArrayList x = new ArrayList();
            x[0] = (int)0;
            CreateJson_Tree(x, O_Top, (JObject)Json);

            JObject Top = new JObject();
            Top.Add("全体", O_Top);

            JObject root = new JObject();
            root.Add("root", Top);

            //Debug.Json(root);
            string jsonStr = JsonConvert.SerializeObject(root);             // Json形式を文字列に

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr);       // Json文字列をXML　objectに

            //XmlDocument xmlDoc = new XmlDocument();
            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);

            //var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            //XmlElement root = xmlDoc.CreateElement("root");

            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.PrependChild(comment);
            xmlDoc.PrependChild(declaration);

            return (O_Top);
        }

        private void CreateJson_Tree(ArrayList x, JObject O_Top, JObject elem)
        {
            x[0] = (int)x[0] + 1;
            JArray A_elem = new JArray { };
            O_Top.Add("element" + x[0], A_elem);
            foreach (var m in (JObject)elem)
            {
                JObject O_elem;
                if (m.Value.Type.ToString() == "String")
                {
                    O_elem = new JObject { { "@string_name", m.Key }, { "#text", m.Value } };
                }
                else if (m.Value.Type.ToString() == "Integer")
                {
                    O_elem = new JObject { { "@integer_name", m.Key }, { "#text", m.Value } };
                }
                else
                {
                    O_elem = new JObject { { "@name", m.Key } };
                }

                A_elem.Add(O_elem);
                if (m.Value.Type.ToString() == "Object")
                {
                    CreateJson_Tree(x, O_elem, (JObject)m.Value);
                }
                else if (m.Value.Type.ToString() == "Array")
                {
                    CreateJson_Tree(x, O_elem, (JArray)m.Value);
                }
                //else if (m.Value.Type.ToString() == "Integer")
                //{
                //    CreateJson_Integer(O_elem, m.Value.ToString());
                //}
            }
            x[0] = (int)x[0] - 1;
        }
        private void CreateJson_Tree(ArrayList x, JObject O_Top, JArray elem)
        {
            JArray A_elem = new JArray { };
            O_Top.Add("array", A_elem);
            for (var c = 0; c < elem.Count(); c++)
            {
                JObject O_elem = new JObject { { "@m", c }, { "#text", elem[c] } };
                A_elem.Add(O_elem);
            }
        }
        //private void CreateJson_Integer(JObject O_Top, string elem)
        //{
        //    JArray A_elem = new JArray { };
        //    //O_Top.Add("string", new JObject { { "#text", elem } });
        //}
        //private void CreateJson_IntegerX(JObject O_Top, string elem)
        //{
        //    JArray A_elem = new JArray { };
        //    O_Top.Add("string", A_elem);
        //    for (var c = 0; c < elem.Count(); c++)
        //    {
        //        JObject O_elem = new JObject { { "@m", c }, { "#text", elem[c] } };
        //        A_elem.Add(O_elem);
        //    }
        //}
        public JObject getStat(
            [CallerMemberName] string callerMemberName = "",
            [CallerFilePath] string callerFilePath = "",
            [CallerLineNumber] int callerLineNumber = 0)
        {
            JObject Info = new JObject();

            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            string mName = Environment.MachineName;


            Info.Add("MachineName", mName);
            Info.Add("className", className);
            Info.Add("methodName", callerMemberName);
            //Info.Add("pathName", callerFilePath);
            //Info.Add("lineNumber", callerLineNumber);
            //Info.Add("DB_Conn", DB_connectString);
            return (Info);
        }
        public XmlDocument methodList()
        {
            //Debug.Write("methodList");
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            xmlDoc.AppendChild(xmlMain);
            root.SetAttribute("name", "EMG");
            xmlDoc.AppendChild(root);

            XmlElement root_xml = xmlDoc.CreateElement("xml");
            XmlElement root_json = xmlDoc.CreateElement("json");
            root.AppendChild(root_xml);
            root.AppendChild(root_json);

            Dictionary<string, object> list = methodList_xml_json();
            Dictionary<string, List<string>> Tab_xml =(Dictionary<string, List<string>>) list["xml"];
            Dictionary<string, List<string>> Tab_json = (Dictionary<string, List<string>>)list["json"];

            foreach (var x1 in Tab_xml)
            {
                XmlElement node1 = xmlDoc.CreateElement("menu");
                string className = x1.Key;
                node1.SetAttribute("name", className);
                root_xml.AppendChild(node1);
                foreach (var methodName in x1.Value)
                {
                    XmlElement node2 = xmlDoc.CreateElement("menu");
                    node2.SetAttribute("type", "xml");
                    node2.SetAttribute("name", methodName);
                    node2.SetAttribute("mode", "method");
                    node2.SetAttribute("item", className);
                    node2.SetAttribute("func", methodName);
                    node1.AppendChild(node2);
                }
            }
            foreach (var x1 in Tab_json)
            {
                XmlElement node1 = xmlDoc.CreateElement("menu");
                string className = x1.Key;
                node1.SetAttribute("name", className);
                root_json.AppendChild(node1);
                foreach (var methodName in x1.Value)
                {
                    XmlElement node2 = xmlDoc.CreateElement("menu");
                    node2.SetAttribute("type", "json");
                    node2.SetAttribute("name", methodName);
                    node2.SetAttribute("mode", "method");
                    node2.SetAttribute("item", className);
                    node2.SetAttribute("func", methodName);
                    node1.AppendChild(node2);
                }
            }
            return (xmlDoc);
        }
        public Dictionary<string, object> methodList_xml_json()
        {
            //object o_obj = new object();
            String nameSpace = "WebApi_project.hostProc";

            Dictionary<string, List<string>> xTab = new Dictionary<string, List<string>>();
            Dictionary<string, List<string>> Tab_xml = new Dictionary<string, List<string>>();
            Dictionary<string, List<string>> Tab_json = new Dictionary<string, List<string>>();
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Tab.Add("xml", Tab_xml);
            Tab.Add("json", Tab_json);
            Assembly assm = Assembly.GetExecutingAssembly();

            List<string> className_X = new List<string>()
                {
                "hostWeb"
                };
            List<string> methdName_X = new List<string>()
                {
                "Entry","Json2Xml","methodList"
                };

            // 指定した名前空間のクラスをすべて取得
            var types = assm.GetTypes()
                .Where(p => p.Namespace == nameSpace)
                .OrderBy(o => o.Name)
                .Select(s => s);

            foreach (Type t in types)
            {
                //Debug.Write("====",t.Name);
                string className = t.Name;
                var mList = t.GetMethods();

                foreach (var m in mList)
                {
                    string methodName = m.Name;
                    //Debug.Write(className, methodName, m.ReturnType.ToString());
                    if (!className_X.Contains(className) && !methdName_X.Contains(methodName))
                    {
                        if (m.ReturnType == typeof(Object) || m.ReturnType == typeof(XmlDocument))
                        {
                            //Debug.Write(className, methodName, m.ReturnType.ToString());
                        }

                        //Debug.Write(className, methodName, m.ReturnType.ToString());
                        if (m.ReturnType == typeof(XmlDocument))
                        {
                            if (!Tab_xml.ContainsKey(className))
                            {
                                var methodTab = new List<string>();
                                Tab_xml.Add(className, methodTab);
                            }
                            //Type classType = Type.GetType(nameSpace + "." + className);
                            //var obj = Activator.CreateInstance(classType);

                            Tab_xml[className].Add(methodName);
                            //Debug.Write(className, methodName, m.ReturnType.ToString());
                        }
                        else if (m.ReturnType == typeof(Object))
                        {
                            if (!Tab_json.ContainsKey(className))
                            {
                                var methodTab = new List<string>();
                                Tab_json.Add(className, methodTab);
                            }
                            //Type classType = Type.GetType(nameSpace + "." + className);
                            //var obj = Activator.CreateInstance(classType);

                            Tab_json[className].Add(methodName);
                            //Debug.Write(className, methodName, m.ReturnType.ToString());
                        }
                    }
                    else
                    {
                        //Debug.Write(className, methodName, m.ReturnType.ToString());
                    }
                }
            }
            return (Tab);
        }
    }
}

namespace WebApi_project.hostProc
{
    public class SqlUtil
    {
        public static string Parameter(string mode, object value)
        {
            string result = "";
            string typeName = value.GetType().Name;
            if (mode == "string" && typeName == "DateTime")
            {
                result = string.Concat("'", value.ToString(), "'");
            }
            else if (mode == "string")
            {
                result = string.Concat("'", value, "'");
            }
            else if (mode == "number")
            {
                result = value.ToString();
            }
            else
            {
                result = value.ToString();
            }
            return (result);
        }
    }
    public class DbUtil
    {

        public static SqlParameter LongParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.BigInt);
            if (value == null || value.ToString() == "")
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter IntParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.Int);
            if (value == null || value.ToString() == "")
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter SmallIntParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.SmallInt);
            if (value == null)
            {
                sqlParam.Value = 0;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter NVarCharParameter(string name, int size, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.NVarChar, size);
            if (value == null)
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter DateTimeParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.DateTime);
            if (value == null || value.ToString() == "")
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter TextParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.Text);
            sqlParam.Value = value;
            return (sqlParam);
        }

        public static SqlParameter XmlParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.Xml);
            sqlParam.Value = value;
            return (sqlParam);
        }

        public static SqlParameter VarBinaryParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.VarBinary);
            sqlParam.Value = value;
            return (sqlParam);
        }

    }

}
