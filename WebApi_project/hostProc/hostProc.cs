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
        public XmlDocument Json2Xml(object Tab)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");

            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.AppendChild(xmlMain);
            xmlDoc.AppendChild(comment);
            xmlDoc.AppendChild(root);

            var Tab1 = (Dictionary<string,object>)Tab;
            var data0 = root;
            foreach (var x1 in Tab1)
            {
                XmlElement data1 = xmlDoc.CreateElement("json");
                //Debug.Write("x1",(x1.Value).GetType().Name);
                if( (x1.Value).GetType().Name == "String")
                {
                    data1.InnerText = (string)x1.Value;
                    data1.SetAttribute("name", x1.Key);
                    data0.AppendChild(data1);
                }
                else
                {
                    var Tab2 = (Dictionary<string, object>)x1.Value;
                    data1.SetAttribute("name", x1.Key);
                    data0.AppendChild(data1);
                    foreach (var x2 in Tab2)
                    {
                        XmlElement data2 = xmlDoc.CreateElement(x1.Key);
                        //Debug.Write("x2", (x2.Value).GetType().Name);
                        if ((x2.Value).GetType().Name == "String")
                        {
                            data2.InnerText = (string)x2.Value;
                            data2.SetAttribute("name", x2.Key);
                            data1.AppendChild(data2);
                        }
                        else
                        {
                            var Tab3 = (Dictionary<string, object>)x2.Value;
                            data2.SetAttribute("name", x2.Key);
                            root.AppendChild(data2);
                            foreach (var x3 in Tab3)
                            {
                                XmlElement data3= xmlDoc.CreateElement(x2.Key);
                                //Debug.Write("x3", (x3.Value).GetType().Name);
                                if ((x3.Value).GetType().Name == "String")
                                {
                                    data3.InnerText = (string)x3.Value;
                                    data3.SetAttribute("name", x3.Key);
                                    data2.AppendChild(data3);
                                }
                                else
                                {

                                }
                            }
                        }
                    }
                }
            }

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
                "Entry","Json2Xml"
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
