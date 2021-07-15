using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;

using DebugHost;

namespace WebApi_project.hostProc.要員情報
{
    public class 要員情報 
    {

        public XmlDocument 要員一覧(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            var para = "要員一覧";
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