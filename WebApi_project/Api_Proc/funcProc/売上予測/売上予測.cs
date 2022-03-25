using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

using WebApi_project.Models;
using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測 : hostProc
    {
        Dictionary<string, Dictionary<string, string>> funcTab = new Dictionary<string, Dictionary<string, string>>() {
            { "売上予実_部門",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_分類",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_新規",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_新規2",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } }
        };
        private JObject loadJson(String s_option, string url)
        {
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            JObject oJson = JObject.Parse(jsonStr);
            ArrayConvert(ref oJson, "月", "m");

            return (oJson);
        }
        public XmlDocument 売上予実_部門(String s_option)
        {
            var Tab = funcTab["売上予実_部門"];
            var mode = Tab.ContainsKey("mode");
            var url = Tab["url"];
            var opt = JObject.Parse(Tab["option"]);
            var para = new JsonOption.projectPara();
            
            var s_para = JsonConvert.SerializeObject(para);

            var option = JsonMerge(s_para, s_option);

            url += makeOption(option, "?");
            var oJson = (JObject)loadJson(option,url);

            XmlDocument xmlDoc = JsonToXml(oJson);

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public XmlDocument 売上予実_分類(String s_option)
        {
            var para = new JsonOption.projectPara();
            para.actual = "5";
            para.yymm = "";
            var s_para = JsonConvert.SerializeObject(para);

            var option = JsonMerge(s_para, s_option);

            string url = "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" + makeOption(option, "?");
            var oJson = (JObject)loadJson(option, url);

            XmlDocument xmlDoc = JsonToXml(oJson);

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public XmlDocument 売上予実_新規(String s_option)
        {
            var para = new JsonOption.projectPara();
            para.actual = "5";
            para.yymm = "";
            var s_para = JsonConvert.SerializeObject(para);

            var option = JsonMerge(s_para, s_option);

            string url = "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" + makeOption(option, "?");
            var oJson = (JObject)loadJson(option, url);

            XmlDocument xmlDoc = JsonToXml(oJson);

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public XmlDocument 売上予実_新規2(String s_option)
        {
            var para = new JsonOption.projectPara();
            para.actual = "5";
            para.yymm = "";
            var s_para = JsonConvert.SerializeObject(para);

            var option = JsonMerge(s_para, s_option);

            string url = "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" + makeOption(option, "?");
            var oJson = (JObject)loadJson(option, url);

            XmlDocument xmlDoc = JsonToXml(oJson);

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
    }

}
