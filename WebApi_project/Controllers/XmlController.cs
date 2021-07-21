using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Xml;

namespace WebApi_project.Controllers
{
    public class XmlController : ApiController
    {
        // GET api/<controller>
        public HttpResponseMessage Get()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");

            var comment = xmlDoc.CreateComment("xml data");
            xmlDoc.AppendChild(xmlMain);
            xmlDoc.AppendChild(comment);
            xmlDoc.AppendChild(root);

            HttpResponseMessage response = new HttpResponseMessage();
            response.Content = new StringContent(xmlDoc.OuterXml);
            return (response);
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
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
    }
}