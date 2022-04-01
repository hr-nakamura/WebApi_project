using System;
using System.Text;
using System.Collections.Generic;
using System.Xml;
using System.Text.RegularExpressions;
using System.Reflection;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {


        public XmlDocument LoadAsp(string name, string s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            var Tab = xmlEntryTab[name];
            var mode = Tab["mode"];
            var func = Tab["func"];
            string opt = Tab["option"];


            string option = JsonMerge(opt, s_option);
            if (mode == "json")
            {
                var oJson = (JObject)LoadJson(func, option);
                xmlDoc = JsonToXml(oJson);
            }
            else if(mode == "xml")
            {
                xmlDoc = LoadXml(func, option);
            }
            else if( mode == "method")
            {
                xmlDoc = LoadMethod(func, option);
            }
            var Declaration = xmlDoc.FirstChild.GetType().ToString();

            if( Declaration != "System.Xml.XmlDeclaration")
            {
                XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
                xmlDoc.PrependChild(declaration);
            }
            AddComment(xmlDoc, name);
            AddComment(xmlDoc, makeOption(option));
            //AddComment(xmlDoc, option);
            if (xmlDoc.InnerText == "")
            {
                AddComment(xmlDoc, func);
                XmlElement root = xmlDoc.DocumentElement;
                root.SetAttribute("memo", "データは見つかりませんでした");
            }

            return (xmlDoc);

        }
        public XmlDocument TestX(string url, string s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml("<root name='TestX'><TestX>TestX</TestX></root>");
            return (xmlDoc);
        }
        private XmlDocument LoadMethod(string url, string s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            { 
                string[] ItemWork = url.Split('/');
                if (ItemWork.Length != 2) throw new Exception("引数[" + s_option + "]が不明です");

                string className = ItemWork[0];
                string methodName = ItemWork[1];

                String nameSpace = "WebApi_project.hostProc";

                Type classType = Type.GetType(string.Concat(nameSpace, ".", className));
                if (classType == null) throw new Exception("calss名[" + className + "]が不明です");
                var obj = Activator.CreateInstance(classType);
                MethodInfo method = classType.GetMethod(methodName);
                if (method == null) throw new Exception("method名[" + methodName + "]が不明です");
                xmlDoc = (XmlDocument)method.Invoke(obj, new object[] { url, s_option });
                if (xmlDoc.InnerText == "") xmlDoc.LoadXml("<root/>");
                return (xmlDoc);
            }
            catch (Exception ex)
            {
                xmlDoc.CreateXmlDeclaration("1.0", null, null);

                var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
                XmlElement error = xmlDoc.CreateElement("error");
                var comment = xmlDoc.CreateComment(ex.Message);

                //xmlDoc.AppendChild(xmlMain);
                xmlDoc.AppendChild(error);
                error.AppendChild(comment);
                return (xmlDoc);
            }
            finally
            {
                //Debug.WriteErr("finally");
            }
        }
        private XmlDocument LoadXml(string url, string s_option)
        {
            url += makeOption(s_option, "?");
            hostWeb h = new hostWeb();
            string xmlStr = h.GetRequest(url, "Shift_JIS");
            XmlDocument xmlDoc = new XmlDocument();
            if (xmlStr == null) xmlStr = "<root/>";
            xmlDoc.LoadXml(xmlStr);

            return (xmlDoc);
        }
        private JObject LoadJson(string url, string s_option)
        {
            JObject oJson = new JObject();
            url += makeOption(s_option, "?");
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            if(jsonStr != null)
            {
                oJson = JObject.Parse(jsonStr);
                JsonArrayConvert(ref oJson, "月", "m");
            }
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
                if (item.Value.ToString() == "") continue;
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
            var root = xmlDoc.SelectSingleNode("/root");
            xmlDoc.InsertBefore(comment_node, root);

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


        public void JsonArrayConvert(ref JObject oJson, string tag_name, string atr_name)
        {
            foreach (var item in (JObject)oJson)
            {
                var Key = item.Key;
                var Value = item.Value;
                if (Value.Type.ToString() == "Object")
                {
                    if( Value.First != null) Value.First.AddBeforeSelf(new JProperty("@name", Key));
                    var target_Value = (JObject)oJson[Key];
                    JsonArrayConvert(ref target_Value, tag_name, atr_name);
                }
                else if (Value.Type.ToString() == "Array")
                {
                    oJson[Key] = (JObject)ArrayConvert(Value, tag_name, atr_name);
                }
                else
                {
                }
            }
        }
        private JObject ArrayConvert(object oJson, string tag_name, string atr_name)
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
