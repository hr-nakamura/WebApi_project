using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;

namespace WebApi_project.hostProc
{
    public partial class 売上予測
    {
        public XmlDocument 売上予実_分類(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData4>(Json);

            var para = "売上予実_分類";
            //XmlDocument xmlDoc = makeXmlDoc(para);
            XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }
        class SampleData4
        {
            public string a { get; set; }
            public string b { get; set; }
        }

    }
}

