using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc.要員情報
{
    public class 要員情報 
    {
        string DB_connectString;

        public 要員情報()
        {
            hostProc hProc = new hostProc();
            DB_connectString = hProc.DB_connectString;
        }
        public object 売上予実_新規_json(String Json)
        {

            string funcName = "要員一覧";

            Debug.WriteLog("要員一覧_json");

            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);
            var work = new List<string>();
            work.Add("Item");
            work.Add("Func");
            work.Add("Json");

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab[nameof(mName)] = mName;
            Tab.Add("funcName", funcName);
            Tab.Add("mName", mName);
            Tab.Add("DB_Conn", DB_connectString);

            return (Tab);
        }

        public XmlDocument 要員一覧(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            //XmlDocument xmlDoc = makeXmlDoc(para);
            XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }
        class SampleData
        {
            public string a { get; set; }
            public string b { get; set; }
        }
    }
}