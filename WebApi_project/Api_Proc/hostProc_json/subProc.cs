using System;
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
        public XmlDocument AddComment(XmlDocument xmlDoc, string comment)
        {
            var comment_node = xmlDoc.CreateComment(comment);
            xmlDoc.PrependChild(comment_node);

            return (xmlDoc);
        }
        public XmlDocument JsonToXml(JObject oJson)
        {
            string sJson = JsonConvert.SerializeObject(oJson);             // Json形式を文字列に

            sJson = Regex.Replace(sJson, "・", "·");

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
            foreach (var x in (JObject)oJson)
            {
                var Key = x.Key;
                var Value = x.Value;
                if (Value.Type.ToString() == "Object")
                {
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
