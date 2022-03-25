using System;
using System.Web;
using System.Xml;
using System.Reflection;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

using System.IO;
using System.Text.Json;
using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 費用予測 : hostProc
    {
        public XmlDocument 費用状況(String s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            var Tab = funcTab["費用状況"];
            var mode = Tab["mode"];
            var url = Tab["url"];
            var opt = Tab["option"];

            var option = JsonMerge(opt, s_option);

            if (mode == "json")
            {
                var oJson = (JObject)LoadJson(url, option);
                xmlDoc = JsonToXml(oJson);
            }

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
    }
}