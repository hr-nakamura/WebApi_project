using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;

namespace WebApi_project.hostProc
{
    public partial class 売上予測
    {
        public XmlDocument 売上予実_部門(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData3>(Json);

            var para = "売上予実_部門";
            //XmlDocument xmlDoc = makeXmlDoc(para);
            XmlDocument xmlDoc = new XmlDocument();


            return (xmlDoc);
        }
        class SampleData3
        {
            public string a { get; set; }
            public string b { get; set; }
        }

    }
}

