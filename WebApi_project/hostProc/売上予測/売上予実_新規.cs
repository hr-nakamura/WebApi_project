using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測
    {
        public object 売上予実_新規_json(String Json)
        {

            string funcName = "売上予実_新規";

            Debug.WriteLog("売上予実_新規_json");

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
        public XmlDocument 売上予実_新規(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData2>(Json);

            //XmlDocument xmlDoc = makeXmlDoc(para);
            XmlDocument xmlDoc = new XmlDocument();


            return (xmlDoc);
        }
        class SampleData2
        {
            public string a { get; set; }
            public string b { get; set; }
        }

    }
}
