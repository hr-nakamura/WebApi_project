using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

using System.Xml;
using Newtonsoft.Json;
using WebApi_project.Models;
using WebApi_project.hostProc;

using DebugHost;

namespace WebApi_project.Controllers
{
    public class TestController : ApiController
    {
        public HttpResponseMessage Get()
        {
            MyDebug.noWrite("Test", "Get");

            var hProc = new hostProc.hostProc();
            XmlDocument xmlDoc = hProc.methodList();

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);

        }
        public HttpResponseMessage Get(string Item, string Json)
        {
            MyDebug.noWrite("Test", "Get string Item, string Json",Item,Json.ToString());
            var hProc = new entryProc.entryProc();

            XmlDocument xmlDoc = hProc.Entry_xml(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;

            var hProc = new entryProc.entryProc();
            XmlDocument xmlDoc = hProc.Entry_xml(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }


        // PUT api/<controller>/5
        public HttpResponseMessage Put([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;

            var hProc = new entryProc.entryProc();
            XmlDocument xmlDoc = hProc.Entry_xml(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;

            var hProc = new entryProc.entryProc();
            XmlDocument xmlDoc = hProc.Entry_xml(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }
        HttpResponseMessage response_conv(string value)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response.Content = new StringContent(value);
            return (response);
        }
    }
}
