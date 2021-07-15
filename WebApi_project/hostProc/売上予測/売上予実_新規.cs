using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;

namespace WebApi_project.hostProc
{
    public partial class 売上予測
    {
        public XmlDocument 売上予実_新規(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData2>(Json);

            var para = "売上予実_新規";
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
