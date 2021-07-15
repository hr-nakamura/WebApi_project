using System;
using System.Web;
using System.Reflection;
using System.Xml;
using System.Data.SqlClient;
using System.Linq;
using System.Data;
using System.Collections.Generic;

using Util;
using DebugHost;

namespace WebApi_project.hostProc
{
    public class hostProc
    {
        // DBコネクション
        public string DB_connectString = "";
        public Boolean DB_status = true;
        public string DB_result;
        public SqlConnectionStringBuilder DB_builder = new SqlConnectionStringBuilder();

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
                    break;
                case "NAKAMURA-RD":
                    DB_mode = "データベース_naka";
                    break;
                case "EMG-APSV":
                    DB_mode = "データベース_EMG";
                    break;
                default:
                    DB_mode = "データベース";
                    break;
            }


            HttpContext context = HttpContext.Current;
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
        public XmlDocument makeXmlDoc(string msg)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            XmlElement data1 = xmlDoc.CreateElement("data");
            XmlElement data2 = xmlDoc.CreateElement("data");

            var comment = xmlDoc.CreateComment(msg);
            xmlDoc.AppendChild(xmlMain);
            xmlDoc.AppendChild(comment);
            xmlDoc.AppendChild(root);
            root.AppendChild(data1);
            root.AppendChild(data2);
            data2.InnerText = "A123";
            data2.SetAttribute("class", "c123");
            data2.SetAttribute("id", "id123");
            data1.InnerText = "A111";
            data1.SetAttribute("class", "c111");
            data1.SetAttribute("id", "id111");
            return (xmlDoc);
        }
        public Dictionary<string, List<string>> methodList()
        {
            //object o_obj = new object();
            //String nameSpace = "WebApi_project.hostProc";

            Dictionary<string, List<string>> Tab = new Dictionary<string, List<string>>();
            Dictionary<string, object> work = new Dictionary<string, object>();
            Assembly assm = Assembly.GetExecutingAssembly();

            List<string> methdList_X = new List<string>()
                {
                "Entry","makeXmlDoc"
                };

            // 指定した名前空間のクラスをすべて取得
            var types = assm.GetTypes()
                .Where(p => p.Namespace == "WebApi_project.hostProc")
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
                    //Debug.Write(className,methodName, m.ReturnType.ToString());
                    if (!methdList_X.Contains(methodName))
                    {
                        if (m.ReturnType == typeof(XmlDocument))
                        {
                            if (!Tab.ContainsKey(className))
                            {
                                var methodTab = new List<string>();
                                Tab.Add(className, methodTab);
                            }
                            //Type classType = Type.GetType(nameSpace + "." + className);
                            //var obj = Activator.CreateInstance(classType);

                            Tab[className].Add(methodName);
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
