using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using System.Xml;
using Newtonsoft.Json;
using System.Reflection;
using System.Net.Http;


using WebApi_project.Models;
using WebApi_project.hostProc;

using DebugHost;

namespace WebApi_project.Controllers
{
    public class XmlController : ApiController
    {
        // GET api/<controller>/5
        public HttpResponseMessage Get()
        {
            var hProc = new hostProc.hostProc();
            XmlDocument xmlDoc = hProc.methodList();

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);

        }
        public HttpResponseMessage Get(string Item,  string Json)
        {
            paraOut("GET", Item, Json);

            var hProc = new entryProc.entryProcEntry();

            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody] ProjectJson para)
        {

            HttpContext context = HttpContext.Current;
            var Request = context.Request;
            var work1 = Request.UrlReferrer.Host;
            var work2 = Request.UrlReferrer.LocalPath;
            var work3 = Request.UrlReferrer.Port;
            ////Debug.Write(work);

            var Item = para.Item;
            var Json = para.Json;
            paraOut("POST", Item, Json);

            var hProc = new entryProc.entryProcEntry();
            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }


        // PUT api/<controller>/5
        public HttpResponseMessage Put([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("PUT", Item, Json);

            var hProc = new entryProc.entryProcEntry();
            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("Delete", Item, Json);

            var hProc = new entryProc.entryProcEntry();
            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }
        HttpResponseMessage response_conv(string value)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response.Content = new StringContent(value);
            return (response);
        }
        void paraOut(String Mode, String Item, String Json)
        {
            string[] ItemWork = Item.Split('/');
            var work = new List<string>();
            work.Add(Mode);
            work.Add(ItemWork[0]);
            work.Add(ItemWork[1]);
            work.Add(Json);
            //Debug.WriteLog("[" + string.Join("][", work) + "]");
        }
    }
}