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
    public class 要員情報 : hostProc
    {
        public object json_要員一覧(String Json)
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

            string url = "http://localhost/Project/要員情報/要員一覧/xml/要員一覧_XML.asp?year=2021";
            hostWeb h = new hostWeb();
            string xmlStr = h.GetRequest(url);

            Tab.Add("Data", xmlStr);

            return (Tab);
        }

        public XmlDocument 要員一覧(String Json)
        {
            Dictionary<string, dynamic> Tab = (Dictionary<string, dynamic>)json_要員一覧(Json);

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(Tab["Data"]);

            return (xmlDoc);
        }
    }
}