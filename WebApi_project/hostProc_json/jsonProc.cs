using System;
using System.Web;
using System.Xml;

namespace WebApi_project.hostProc
{
    public partial class jsonProc : hostProc
    {
        public jsonProc()
        {
        }
        public XmlDocument memberInfo(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);
            object json_data = json_memberInfo(Json);
            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }

    }
}
