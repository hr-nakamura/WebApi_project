using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
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
            return (Tab);
        }

        public XmlDocument 要員一覧(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            object json_data = 要員一覧_json(Json);
            XmlDocument xmlDoc = hProc.makeXmlDoc(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            //var x = new projectBBS();
            //Dictionary<string, object> Tab = (Dictionary<string, object>)x.projectList_json(Json);
            //object Data = (object) Tab["Data"];


            return (xmlDoc);
        }
        class SampleData
        {
            public string a { get; set; }
            public string b { get; set; }
        }
    }
}