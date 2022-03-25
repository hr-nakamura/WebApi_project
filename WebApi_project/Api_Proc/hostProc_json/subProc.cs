﻿using System;
using System.Text;
using System.Collections.Generic;
using System.Xml;
using System.Text.RegularExpressions;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {

        public XmlDocument LoadAsp(string name, string s_option)
        {

            XmlDocument xmlDoc = new XmlDocument();
            var Tab = funcTab[name];
            var mode = Tab["mode"];
            var url = Tab["url"];
            var opt = Tab["option"];
            var option = JsonMerge(opt, s_option);

            if (mode == "json")
            {
                var oJson = (JObject)LoadJson(url, option);
                xmlDoc = JsonToXml(oJson);
            }
            else
            {
                xmlDoc = LoadXml(url, option);
            }
            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(option));
            xmlDoc.PrependChild(declaration);
            
            return (xmlDoc);
        }
        private XmlDocument LoadXml(string url, string s_option)
        {
            url += makeOption(s_option, "?");
            hostWeb h = new hostWeb();
            string xmlStr = h.GetRequest(url, "Shift_JIS");
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xmlStr);
            return (xmlDoc);
        }
        private JObject LoadJson(string url, string s_option)
        {
            url += makeOption(s_option, "?");
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            JObject oJson = JObject.Parse(jsonStr);
            ArrayConvert(ref oJson, "月", "m");

            return (oJson);
        }
        public string makeOption(JObject o_opt, string head = "")
        {
            var s_opt = JsonConvert.SerializeObject(o_opt);
            return (makeOption(s_opt, head ));
        }

        public string makeOption(string s_opt, string head = "")
        {

            var o_opt = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, object>>(s_opt);

            List<string> work = new List<string>();
            foreach (var item in o_opt)
            {
                if (item.Value.ToString() == "" || item.Value.ToString() == "-999") continue;
                work.Add(item.Key + "=" + item.Value.ToString());
            }
            string result = head + String.Join("&", work);
            return (result);
        }

        public string JsonMerge(string s_dst, string s_src)
        {
            var o_src = (s_src == "" ? new JObject() : JObject.Parse(s_src));
            var o_dst = JObject.Parse(s_dst);
            o_dst = JsonMerge(o_dst,o_src);

            return ( JsonConvert.SerializeObject(o_dst) );
        }
        public JObject JsonMerge(JObject o_dst, JObject o_src)
        {
            o_dst.Merge(o_src);
            return (o_dst);
        }
        public XmlDocument AddComment(XmlDocument xmlDoc, string comment)
        {
            var comment_node = xmlDoc.CreateComment(comment);
            xmlDoc.PrependChild(comment_node);

            return (xmlDoc);
        }
        public XmlDocument JsonToXml(JObject oJson)
        {
            string sJson = JsonConvert.SerializeObject(oJson);             // Json形式を文字列に
            XmlDocument xmlDoc = JsonToXml(sJson);
            return (xmlDoc);
        }
        public XmlDocument JsonToXml(string sJson)
        {
            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(sJson, "root");       // Json文字列をXML　objectに
            return (xmlDoc);
        }


        public void ArrayConvert(ref JObject oJson, string tag_name, string atr_name)
        {
            foreach (var item in (JObject)oJson)
            {
                var Key = item.Key;
                var Value = item.Value;
                if (Value.Type.ToString() == "Object")
                {
                    if( Value.First != null) Value.First.AddBeforeSelf(new JProperty("@name", Key));
                    var target_Value = (JObject)oJson[Key];
                    ArrayConvert(ref target_Value, tag_name, atr_name);
                }
                else if (Value.Type.ToString() == "Array")
                {
                    oJson[Key] = (JObject)JsonArrayConvert(Value, tag_name, atr_name);
                }
                else
                {
                }
            }
        }
        private JObject JsonArrayConvert(object oJson, string tag_name, string atr_name)
        {
            List<string> work = new List<string>();
            int i = 0;
            foreach (var value in (JArray)oJson)
            {
                work.Add(" {'@" + atr_name + "':" + i++.ToString() + ",'#text':'" + value.ToString() + "'}");
            }

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("{");
            sb.AppendLine(" '" + tag_name + "': [");
            sb.AppendLine(String.Join(",", work));
            sb.AppendLine(" ]");
            sb.AppendLine("}");

            JObject Json = (JObject)JsonConvert.DeserializeObject(sb.ToString());
            return (Json);

        }
    }
}
