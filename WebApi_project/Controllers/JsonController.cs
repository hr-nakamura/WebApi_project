﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using System.Xml;
using Newtonsoft.Json;
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
            var hProc = new hostProc.hostProc();
            object Tab = hProc.methodList_json();

            HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Tab));
            return (response);

        }
        public HttpResponseMessage Get(string mailAddr)
        {
            string jsonStr = "{'mailAddr':'" + mailAddr + "'}";
            var jProc = new hostProc.projectInfo();
            object Obj = jProc.json_memberInfo(jsonStr);

            var response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }
        public HttpResponseMessage Get(string Item, string Json)
        {
            paraOut("GET", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody] ProjectJson para)
        {

            HttpContext context = HttpContext.Current;
            var Request = context.Request;

            var Item = para.Item;
            var Json = para.Json;
            paraOut("POST", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }


        // PUT api/<controller>/5
        public HttpResponseMessage Put([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("PUT", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            HttpResponseMessage response = response_conv(JsonConvert.SerializeObject(Obj));
            return (response);
        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            paraOut("Delete", Item, Json);

            var hProc = new hostProcEntry_json();
            object Obj = hProc.Entry(Item, Json);

            var response = response_conv(JsonConvert.SerializeObject(Obj));
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