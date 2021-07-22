using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Xml;
using Newtonsoft.Json;

namespace WebApi_project.Controllers
{
    public class TestController : ApiController
    {
        // GET api/<controller>
        public HttpResponseMessage Get()
        {
            HttpResponseMessage returnValue;

            XmlDocument xmlDoc = new XmlDocument();
            var hProc = new hostProc.hostProc();

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab[nameof(mName)] = mName;
            Tab.Add("mName", mName);
            Tab.Add("DB_Conn", hProc.DB_connectString);
            Tab.Add("DB_status", (hProc.DB_status ? "OK" : "NG"));
            Tab.Add("DB_result", hProc.DB_result);

            xmlDoc = makeXmlDoc(Tab);
            returnValue = response_conv(xmlDoc.OuterXml);
            return (returnValue);
        }

        // GET api/<controller>/5
        public HttpResponseMessage Get(String mode)
        {
            HttpResponseMessage returnValue;
            if ( mode == "json")
            {
                var hProc = new hostProc.hostProc();

                string mName = Environment.MachineName;

                Dictionary<string, string> Tab = new Dictionary<string, string>();
                //Tab[nameof(mName)] = mName;
                Tab.Add("mName", mName);
                Tab.Add("DB_Conn", hProc.DB_connectString);
                Tab.Add("DB_status", (hProc.DB_status ? "OK" : "NG"));
                Tab.Add("DB_result", hProc.DB_result);

                returnValue = response_conv(JsonConvert.SerializeObject(Tab));

            }
            else if( mode == "xml")
            {
                XmlDocument xmlDoc = new XmlDocument();
                var hProc = new hostProc.hostProc();
                string mName = Environment.MachineName;
                Dictionary<string, string> Tab = new Dictionary<string, string>();
                Tab.Add("mName", mName);
                Tab.Add("DB_Conn", hProc.DB_connectString);
                Tab.Add("DB_status", (hProc.DB_status ? "OK" : "NG"));
                Tab.Add("DB_result", hProc.DB_result);

                xmlDoc = makeXmlDoc(Tab);
                returnValue = response_conv(xmlDoc.OuterXml);
            }
            else
            {
                returnValue = response_conv("漢字の\n変換\nabcd\n12345");

            }
            return (returnValue);
        }
        HttpResponseMessage response_conv(string value)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response.Content = new StringContent(value);
            return (response);
        }
        // POST api/<controller>
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }

        XmlDocument makeXmlDoc(Dictionary<string, string> Tab)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");

            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.AppendChild(xmlMain);
            xmlDoc.AppendChild(comment);
            xmlDoc.AppendChild(root);

            foreach (var x in Tab)
            {
                XmlElement data = xmlDoc.CreateElement("json");
                data.InnerText = x.Value;
                data.SetAttribute("name", x.Key);
                root.AppendChild(data);
            }

            return (xmlDoc);
        }

    }
}