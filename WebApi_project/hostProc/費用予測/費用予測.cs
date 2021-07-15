using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 費用予測 
    {
        public XmlDocument 費用状況(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            var para = "費用状況";
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