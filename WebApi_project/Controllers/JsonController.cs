using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net.Http;

using WebApi_project.Models;
using WebApi_project.hostProc;

using DebugHost;

namespace WebApi_project.Controllers
{
    public class JsonController : ApiController
    {
        // GET api/<controller>/5
        public HttpResponseMessage Get()
        {
            MyDebug.noWrite("Json", "Get");
            var hProc = new hostProc.hostProc();
            object Tab = hProc.methodList_xml_json();

            HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Tab));
            return (response);

        }
        public HttpResponseMessage Get(string Item)
        {
            MyDebug.noWrite("Json", "Get string Item, string Json", Item );
            
            var hProc = new hostProc.entryProc();
            EntryInfoXml EntryInfo = hProc.GetEntryTab_xml(Item);

            string url = EntryInfo.data;
            url += "?json=1";

            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");


            HttpResponseMessage response = new HttpResponseMessage();
            return (response);
        }
        public HttpResponseMessage Get(string Item, string Json)
        {
            MyDebug.noWrite("Json", "Get string Item, string Json", Item, Json.ToString());
            var hProc = new hostProc.entryProc();

            EntryInfoJson EntryInfo = new EntryInfoJson();
            object Obj = hProc.Entry(EntryInfo, Item, Json);

            HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody] ProjectJson para)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            HttpContext context = HttpContext.Current;
            var Request = context.Request;

            var Item = para.Item;
            var Json = para.Json;

            //var hProc = new entryProc.entryProc();
            //object Obj = hProc.Entry_json(Item, Json);

            //HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }


        // PUT api/<controller>/5
        public HttpResponseMessage Put([FromBody] ProjectJson para)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            var Item = para.Item;
            var Json = para.Json;

            //var hProc = new entryProc.entryProc();
            //object Obj = hProc.Entry_json(Item, Json);

            //HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete([FromBody] ProjectJson para)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            var Item = para.Item;
            var Json = para.Json;
            paraOut("Delete", Item, Json);

            //var hProc = new entryProc.entryProc();
            //object Obj = hProc.Entry_json(Item, Json);

            //var response = response_conv(JsonConvert.SerializeObject(Obj));
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