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
    public partial class 費用予測
    {
        string DB_connectString;
        string funcName = "費用状況_json";
        public 費用予測()
        {
            hostProc hProc = new hostProc();
            DB_connectString = hProc.DB_connectString;
        }
        public object 費用状況_json(String Json)
        {

            Debug.WriteLog("費用状況_json");

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
        public XmlDocument 費用状況(String Json)
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