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
    public class JsonController : ApiController
    {
        // GET api/<controller>/5
        public object Get()
        {
            var hProc = new hostProc.hostProc();
            object Tab = hProc.methodList_json();

            return (Tab);

        }
        public object Get(string mailAddr)
        {
            var jProc = new hostProc.jsonProc();
            object Obj = jProc.json_memberInfo(mailAddr);

            return (Obj);
        }
        public object Get(string Item, string Json)
        {
            paraOut("GET", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);
            return (Obj);
        }

        // POST api/<controller>
        public object Post([FromBody] ProjectJson para)
        {

            HttpContext context = HttpContext.Current;
            var Request = context.Request;

            var Item = para.Item;
            var Json = para.Json;
            paraOut("POST", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            return (Obj);
        }


        // PUT api/<controller>/5
        public object Put([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("PUT", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            return (Obj);
        }

        // DELETE api/<controller>/5
        public object Delete([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("Delete", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            return (Obj);
        }
        void paraOut(String Mode, String Item, String Json)
        {
            //string[] ItemWork = Item.Split('/'); 
            //var work = new List<string>();
            //work.Add(Mode);
            //work.Add(ItemWork[0]);
            //work.Add(ItemWork[1]);
            //work.Add(Json);
            //Debug.WriteLog("[" + string.Join("][", work) + "]");

        }
    }
}