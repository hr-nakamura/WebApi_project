﻿using System;
using System.Text;
using System.Web;
using System.Reflection;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;
using WebApi_project.Models;

namespace WebApi_project.hostProc
{
    public partial class entryProc 
    {
        private static Dictionary<string, EntryXmlInfo> EntryTab_xml = new Dictionary<string, EntryXmlInfo>();
        private static Dictionary<string, EntryJsonInfo> EntryTab_json = new Dictionary<string, EntryJsonInfo>();
        private static Encoding Encode = Encoding.GetEncoding("shift_jis");

        public XmlDocument Entry(string Item, string Json)
        {
            if (EntryTab_xml.Count == 0)
            {
                EntryTab_xml = GetEntryTab_xml();
            }
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc = LoadAsp(EntryTab_xml, Item, Json);
            return (xmlDoc);
        }
        public JObject Entry_json(string Item, string Json)
        {
            if (EntryTab_json.Count == 0)
            {
                EntryTab_json = GetEntryTab_json();
            }
            JObject jObj = new JObject();
            return (jObj);
        }
        private XmlDocument LoadAsp(Dictionary<string, EntryXmlInfo> EntryTab, string name, string s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {

                var Tab = EntryTab[name];
                var type = Tab.type;
                var data = Tab.data;
                string opt = Tab.option;

                var hProc = new hostProc();
                string option = JsonMerge(opt, s_option);
                if (type == "json")
                {
                    var oJson = (JObject)LoadJson(data, option);
                    xmlDoc = hProc.JsonToXml(oJson);
                }
                else if (type == "xml")
                {
                    xmlDoc = LoadXml(data, option);
                }
                else if (type == "method")
                {
                    xmlDoc = LoadMethod(data, option);
                }
                else
                {
                    xmlDoc = LoadText(data, option);
                }
                var Declaration = xmlDoc.FirstChild.GetType().ToString();

                if (!(Declaration == "System.Xml.XmlDeclaration" || Declaration == "System.Xml.XmlProcessingInstruction"))
                {
                    XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
                    xmlDoc.PrependChild(declaration);
                }
                string comment = System.Web.HttpUtility.UrlDecode(makeOption(option), Encode);
                hProc.AddComment(xmlDoc, name);
                hProc.AddComment(xmlDoc, data);
                hProc.AddComment(xmlDoc, comment);
                //AddComment(xmlDoc, option);
                if (xmlDoc.InnerXml == "")
                {
//                    AddComment(xmlDoc, data);
                    XmlElement root = xmlDoc.DocumentElement;
                    root.InnerText = "データは見つかりませんでした";
//                    root.SetAttribute("memo", "データは見つかりませんでした");
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
                url = url.Trim('/');
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
                if (xmlDoc.InnerXml == "") xmlDoc.LoadXml("<root comment='データがありません'/>");
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
        private XmlDocument LoadText(string url, string s_option)
        {
            System.Text.Encoding enc_utf8 = System.Text.Encoding.GetEncoding("UTF-8");
            System.Text.Encoding enc_euc = System.Text.Encoding.GetEncoding("euc-jp");
            System.Text.Encoding enc_sjis = System.Text.Encoding.GetEncoding("Shift_Jis");

            var option = makeOption(s_option, "");
            option = System.Web.HttpUtility.UrlEncode(option, enc_sjis);

            var urlX = url + "?" + option;

            XmlDocument xmlDoc = new XmlDocument();
            //xmlDoc.Load(urlX);

            hostWeb h = new hostWeb();
            string text = h.GetRequest(urlX, "Shift_JIS");
            xmlDoc.LoadXml("<root/>");
            xmlDoc.DocumentElement.InnerText = text;
            return (xmlDoc);
        }
        private XmlDocument LoadXml(string url, string s_option)
        {
            XmlDocument xmlDoc = new XmlDocument();
            url += makeOption(s_option, "?");
            hostWeb h = new hostWeb();
            string xmlStr = h.GetRequest(url, "Shift_JIS");
            if (xmlStr == null) xmlStr = "<root/>";
            xmlDoc.LoadXml(xmlStr);
            return (xmlDoc);
        }
        private JObject LoadJson(string url, string s_option)
        {
            var hProc = new hostProc();
            JObject oJson = new JObject();
            url += makeOption(s_option, "?");
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            if (jsonStr != null)
            {
                oJson = JObject.Parse(jsonStr);
                hProc.JsonArrayConvert(ref oJson, "月", "m");
            }
            return (oJson);
        }
        private string makeOption(JObject o_opt, string head = "")
        {
            var s_opt = JsonConvert.SerializeObject(o_opt);
            return (makeOption(s_opt, head));
        }

        //private string makeOption(string s_opt, string head = "")
        //{
        //    var query = System.Web.HttpUtility.ParseQueryString("", Encoding.GetEncoding("shift-jis"));
        //    var o_opt = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, object>>(s_opt);

        //    List<string> work = new List<string>();
        //    foreach (var item in o_opt)
        //    {
        //        if (item.Value.ToString() == "") continue;
        //        query.Add(item.Key, item.Value.ToString());
        //    }
        //    string query1 = "dispCmd=%93%9D%8A%87%88%EA%97%97&year=2022";
        //    string result = head + query1;
        //    return (result);
        //}

        private string makeOption(string s_opt, string head = "")
        {
            var o_opt = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, object>>(s_opt);

            List<string> work = new List<string>();
            foreach (var item in o_opt)
            {
                if (item.Value.ToString() == "") continue;
                work.Add(item.Key + "=" + System.Web.HttpUtility.UrlEncode(item.Value.ToString(), Encode));
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
        //==========================================================================================
        private Dictionary<TKey, TValue> Marge<TKey, TValue>(Dictionary<TKey, TValue> a,
                                                    Dictionary<TKey, TValue> b)
        {
            var table = new Dictionary<TKey, TValue>();
            foreach (var item in a)
            {
                table[item.Key] = item.Value;
            }

            foreach (var item in b)
            {
                if (!table.ContainsKey(item.Key))
                {
                    table[item.Key] = item.Value;
                }
            }

            return table;
        }
        private Dictionary<string, EntryXmlInfo> GetEntryTab_xml()
        {

            var EntryTab = new Dictionary<string, EntryXmlInfo>();

            Type type = typeof(WebApi_project.hostProc.hostProc);
            FieldInfo[] fields = type.GetFields(BindingFlags.Public | BindingFlags.Instance);
            foreach (FieldInfo f in fields)
            {
                if (f.FieldType.Name == "Dictionary`2" && f.ToString().Contains("EntryXmlInfo"))
                {
                    FieldInfo field = type.GetField(f.Name);
                    var obj = Activator.CreateInstance(type);
                    var oDic = field.GetValue(obj);
                    EntryTab = Marge(EntryTab, (Dictionary<string, EntryXmlInfo>)oDic);
                }
            }
            return (EntryTab);
        }
        private Dictionary<string, EntryJsonInfo> GetEntryTab_json()
        {

            var EntryTab = new Dictionary<string, EntryJsonInfo>();

            Type type = typeof(WebApi_project.hostProc.hostProc);
            FieldInfo[] fields = type.GetFields(BindingFlags.Public | BindingFlags.Instance);
            foreach (FieldInfo f in fields)
            {
                if (f.FieldType.Name == "Dictionary`2" && f.ToString().Contains("EntryJsonInfo"))
                {
                    FieldInfo field = type.GetField(f.Name);
                    var obj = Activator.CreateInstance(type);
                    var oDic = field.GetValue(obj);
                    EntryTab = Marge(EntryTab, (Dictionary<string, EntryJsonInfo>)oDic);
                }
            }
            return (EntryTab);
        }

        public XmlDocument EntryList()
        {
            if (EntryTab_xml.Count == 0)
            {
                EntryTab_xml = GetEntryTab_xml();
            }
            if (EntryTab_json.Count == 0)
            {
                EntryTab_json = GetEntryTab_json();
            }

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            xmlDoc.AppendChild(xmlMain);
            root.SetAttribute("name", "EMG");
            xmlDoc.AppendChild(root);

            XmlElement root_xml = xmlDoc.CreateElement("xml");
            root.AppendChild(root_xml);
            foreach (var item in EntryTab_xml)
            {
                makeMenuXml(root_xml, item.Key, item.Key, item.Value, EntryTab_xml);
                //root_xml.AppendChild(s_menu);
            }
            XmlElement root_json = xmlDoc.CreateElement("json");
            root.AppendChild(root_json);
            foreach (var item in EntryTab_json)
            {
                makeMenuJson(root_json, item.Key, item.Key, item.Value, EntryTab_json);
                //root_xml.AppendChild(s_menu);
            }
            return (xmlDoc);
        }
        void makeMenuXml(XmlElement p_menu, string name, string fullName, EntryXmlInfo value, Dictionary<string, EntryXmlInfo> EntryTab)
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
                makeMenuXml(menu, new_name, fullName, value, EntryTab);
            }
            else
            {
                XmlElement menu = xmlDoc.CreateElement("menu");
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("type", value.type);
                menu.SetAttribute("option", value.option);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }
        void makeMenuJson(XmlElement p_menu, string name, string fullName, EntryJsonInfo value, Dictionary<string, EntryJsonInfo> EntryTab)
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
                makeMenuJson(menu, new_name, fullName, value, EntryTab);
            }
            else
            {
                XmlElement menu = xmlDoc.CreateElement("menu");
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("type", value.type);
                menu.SetAttribute("option", value.option);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }
    }
}