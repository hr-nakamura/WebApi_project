using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using System.Xml;
using Newtonsoft.Json;
using System.Reflection;

using WebApi_project.Models;
using WebApi_project.hostProc;

using DebugHost;

namespace WebApi_project.Controllers
{
    public class ValuesController : ApiController
    {
        // GET api/<controller>/5
        public string Get()
        {
            XmlDocument xmlDoc = new XmlDocument();

            Debug.Write("Get-0");

            return (xmlDoc.OuterXml);

        }
        public String Get(string Item,  string Json)
        {
            paraOut("GET", Item, Json);

            var hProc = new hostProcEntry();

            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            return (xmlDoc.OuterXml);
        }

        // POST api/<controller>
        public string Post([FromBody] ProjectJson para)
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

            var hProc = new hostProcEntry();
            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            return (xmlDoc.OuterXml);
        }


        // PUT api/<controller>/5
        public string Put([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("PUT", Item, Json);

            var hProc = new hostProcEntry();
            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            return (xmlDoc.OuterXml);
        }

        // DELETE api/<controller>/5
        public string Delete([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("Delete", Item, Json);

            var hProc = new hostProcEntry();
            XmlDocument xmlDoc = hProc.Entry(Item, Json);

            return (xmlDoc.OuterXml);
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