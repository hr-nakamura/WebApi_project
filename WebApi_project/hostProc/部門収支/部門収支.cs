using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class 部門収支
    {
    public XmlDocument 部門収支_XML(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            var para = "部門収支_XML";
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
