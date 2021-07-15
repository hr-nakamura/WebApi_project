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
    public class QOSMIO 
    {
        string DB_connectString;
        public QOSMIO()
        {
            hostProc hProc = new hostProc();
            DB_connectString = hProc.DB_connectString;
        }
        public object projectTest_json(String Json)
        {

            Debug.WriteLog("projectTest_json");

            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);
            var work = new List<string>();
            work.Add("Item");
            work.Add("Func");
            work.Add("Json");

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab[nameof(mName)] = mName;
            Tab.Add("mName", mName);
            Tab.Add("DB_Conn", DB_connectString);

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

            Dictionary<string, string> o_json = (Dictionary<string, string>) projectTest_json(Json);

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

        class projectPara
        {
            public string visitBBS { get; set; }
            public string limitYear { get; set; }
        }
    }
}
