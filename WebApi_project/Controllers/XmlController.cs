using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using System.Xml;
using Newtonsoft.Json;
using System.Reflection;
using System.Net.Http;

using System.Diagnostics;


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
            MyDebug.Write("Xml", "Get ：メニューデータ　読み込み");

            // 呼び出せるリストを戻す
            var hProc = new hostProc.entryProc();

            XmlDocument xmlDoc = hProc.EntryList();
            //XmlDocument xmlDoc = new XmlDocument();

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);

        }
        public HttpResponseMessage Get(string Item, string Json)
        {
            MyDebug.Write("Xml", "Get string Item, string Json",Item,Json.ToString());

            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            var hProc = new hostProc.entryProc();

            EntryInfoXml EntryInfo = new EntryInfoXml();
            XmlDocument xmlDoc = hProc.Entry(EntryInfo, Item, Json);

            stopwatch.Stop();

            string[] Arry = new string[] { "実行時間(Xml)", Item, stopwatch.Elapsed.ToString() };
            AddComment(xmlDoc, Arry);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }
        private void AddComment(XmlDocument xmlDoc, string[] Arry)
        {
            string work = "[" + string.Join("][", Arry) + "]";
            XmlComment comm = xmlDoc.CreateComment("[" + string.Join("][", Arry) );
            XmlNode root = xmlDoc.SelectSingleNode("root");
            xmlDoc.InsertBefore(comm, root);
        }
        // POST api/<controller>
        public HttpResponseMessage Post([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;

            var hProc = new hostProc.entryProc();
            EntryInfoXml EntryTab = new EntryInfoXml();
            XmlDocument xmlDoc = hProc.Entry(EntryTab, Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }


        // PUT api/<controller>/5
        public HttpResponseMessage Put([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;

            var hProc = new hostProc.entryProc();
            EntryInfoXml EntryTab = new EntryInfoXml();
            XmlDocument xmlDoc = hProc.Entry(EntryTab, Item, Json);

            HttpResponseMessage response = response_conv(xmlDoc.OuterXml);
            return (response);
        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete([FromBody] ProjectJson para)
        {
            var Item = para.Item;
            var Json = para.Json;
            var hProc = new hostProc.entryProc();
            EntryInfoXml EntryTab = new EntryInfoXml();
            XmlDocument xmlDoc = hProc.Entry(EntryTab,Item, Json);

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