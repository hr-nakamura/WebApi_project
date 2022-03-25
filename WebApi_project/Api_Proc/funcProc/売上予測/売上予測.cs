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
        public XmlDocument 売上予実_部門(String s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            //var Tab  = hostProc.funcTab["売上予実_部門"];
            //var h = new hostProc();
            //var Tab  = funcTab["売上予実_部門"];
            //var mode = Tab["mode"];
            //var url  = Tab["url"];
            //var opt  = Tab["option"];

            //var option = JsonMerge(opt, s_option);

            //if( mode == "json")
            //{
            //    var oJson = (JObject)LoadJson(url, option);
            //    xmlDoc = JsonToXml(oJson);
            //}
            xmlDoc = LoadAsp("売上予実_部門", s_option);
            //XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            //AddComment(xmlDoc, makeOption(option));
            //xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public XmlDocument 売上予実_分類(String s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            //var Tab  = funcTab["売上予実_分類"];
            //var mode = Tab["mode"];
            //var url  = Tab["url"];
            //var opt  = Tab["option"];

            //var option = JsonMerge(opt, s_option);

            xmlDoc = LoadAsp("売上予実_分類", s_option);

            //XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            //AddComment(xmlDoc, makeOption(option));
            //xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public XmlDocument 売上予実_新規(String s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            var Tab  = funcTab["売上予実_新規"];
            var mode = Tab["mode"];
            var url  = Tab["url"];
            var opt  = Tab["option"];

            var option = JsonMerge(opt, s_option);

            if (mode == "json")
            {
                //var oJson = (JObject)LoadJson(url, option);
                //xmlDoc = JsonToXml(oJson);
            }

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public XmlDocument 売上予実_新規2(String s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            var Tab  = funcTab["売上予実_新規2"];
            var mode = Tab["mode"];
            var url  = Tab["url"];
            var opt  = Tab["option"];

            var option = JsonMerge(opt, s_option);

            if (mode == "json")
            {
                //var oJson = (JObject)LoadJson(url, option);
                //xmlDoc = JsonToXml(oJson);
            }

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
    }

}
