using System;
using System.Web;
using System.Reflection;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {
        public XmlDocument Entry(string Item, string Json)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc = LoadAsp(Item, Json);
            return (xmlDoc);
        }
        public XmlDocument EntryList()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            xmlDoc.AppendChild(xmlMain);
            root.SetAttribute("name", "EMG");
            xmlDoc.AppendChild(root);

            XmlElement root_xml = xmlDoc.CreateElement("xml");
            root.AppendChild(root_xml);
            int i = 0;
            foreach (var item in EntryTab)
            {
                makeMenu(root_xml, item.Key, item.Key, item.Value, i);
                //root_xml.AppendChild(s_menu);
            }
            return (xmlDoc);
        }
        void makeMenu(XmlElement p_menu, string name, string fullName, Dictionary<string, string> item, int i)
        {
            string[] x = name.Split('/');
            XmlDocument xmlDoc = p_menu.OwnerDocument;
            if (x.Length > 1)
            {
                XmlElement menu = (XmlElement)p_menu.SelectSingleNode("menu[@mode='sub' and @name='" + x[0] + "']");
                if (menu == null) menu = xmlDoc.CreateElement("menu");
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("mode", "sub");
                p_menu.AppendChild(menu);

                int indexToRemove = 0;
                string[] z = x.Where((source, index) => index != indexToRemove).ToArray();
                string new_name = String.Join("/", z);
                makeMenu(menu, new_name, fullName, item, i);
            }
            else
            {
                XmlElement menu = xmlDoc.CreateElement("menu");
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("type", item["type"]);
                menu.SetAttribute("option", item["option"]);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }
        private XmlDocument LoadAsp(string name, string s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {

                var Tab = EntryTab[name];
                var type = Tab["type"];
                var func = Tab["func"];
                string opt = Tab["option"];


                string option = JsonMerge(opt, s_option);
                if (type == "json")
                {
                    var oJson = (JObject)LoadJson(func, option);
                    xmlDoc = JsonToXml(oJson);
                }
                else if (type == "xml")
                {
                    xmlDoc = LoadXml(func, option);
                }
                else if (type == "method")
                {
                    xmlDoc = LoadMethod(func, option);
                }
                var Declaration = xmlDoc.FirstChild.GetType().ToString();

                if (!(Declaration == "System.Xml.XmlDeclaration" || Declaration == "System.Xml.XmlProcessingInstruction"))
                {
                    XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
                    xmlDoc.PrependChild(declaration);
                }
                AddComment(xmlDoc, name);
                AddComment(xmlDoc, makeOption(option));
                //AddComment(xmlDoc, option);
                if (xmlDoc.InnerXml == "")
                {
                    AddComment(xmlDoc, func);
                    XmlElement root = xmlDoc.DocumentElement;
                    root.SetAttribute("memo", "データは見つかりませんでした");
                }

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
                if (method == null) throw new Exception("calss名[" + className + "] method名[" + methodName + "]が不明です");
                xmlDoc = (XmlDocument)method.Invoke(obj, new object[] { s_option });
                if (xmlDoc.InnerXml == "") xmlDoc.LoadXml("<root/>");
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
            if (jsonStr != null)
            {
                oJson = JObject.Parse(jsonStr);
                JsonArrayConvert(ref oJson, "月", "m");
            }
            return (oJson);
        }
        private string makeOption(JObject o_opt, string head = "")
        {
            var s_opt = JsonConvert.SerializeObject(o_opt);
            return (makeOption(s_opt, head));
        }

        private string makeOption(string s_opt, string head = "")
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

        private string JsonMerge(string s_dst, string s_src)
        {
            var o_src = (s_src == "" ? new JObject() : JObject.Parse(s_src));
            var o_dst = JObject.Parse(s_dst);
            o_dst = JsonMerge(o_dst, o_src);

            return (JsonConvert.SerializeObject(o_dst));
        }
        private JObject JsonMerge(JObject o_dst, JObject o_src)
        {
            o_dst.Merge(o_src);
            return (o_dst);
        }

    }
}