using System;
using System.Text;
using System.Web;
using System.Reflection;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;
using WebApi_project.Models;
using DebugHost;
using System.IO;

namespace WebApi_project.hostProc
{
    public partial class entryProc 
    {
        private static SortedDictionary<string, EntryInfoXml> EntryTab_xml = new SortedDictionary<string, EntryInfoXml>();
        private static SortedDictionary<string, EntryInfoJson> EntryTab_json = new SortedDictionary<string, EntryInfoJson>();
        private static Encoding Encode = Encoding.GetEncoding("shift_jis");

        public XmlDocument Entry(EntryInfoXml EntryInfo_Xml,string Item, string Json)
        {
            EntryInfo_Xml = GetEntryTab_xml(Item);
            EntryInfo_Xml.option = JsonMerge(EntryInfo_Xml.option, Json);

            XmlDocument xmlDoc = new XmlDocument();

            var hProc = new hostProc();
            if (hProc.local_mode)                // ローカルモード(IPAddress: 10:*.*.*)以外の時
            {
                xmlDoc = LoadFunc_Local(EntryInfo_Xml);
            }
            else
            {
                xmlDoc = LoadFunc(EntryInfo_Xml);
            }

            MyDebug.Json(EntryInfo_Xml.option);

            return (xmlDoc);
        }
        public JObject Entry(EntryInfoJson EntryInfo_Json, string Item, string Json)
        {
            EntryInfo_Json = GetEntryTab_json(Item);
            EntryInfo_Json.option = JsonMerge(EntryInfo_Json.option, Json);

            JObject jObj = new JObject();
            var hProc = new hostProc();
            if (hProc.local_mode)                // ローカルモード(IPAddress: 10:*.*.*)以外の時
            {
                jObj = LoadFunc_Local(EntryInfo_Json);
            }
            else
            {
                jObj = LoadFunc(EntryInfo_Json);
            }
            return (jObj);
        }
        private JObject LoadFunc(EntryInfoJson EntryInfo_Json)
        {
            var type = EntryInfo_Json.type;
            var data = EntryInfo_Json.data;
            string opt = EntryInfo_Json.option;
            JObject jObj = new JObject();
            var hProc = new hostProc();
            if (type == "method")
            {
                jObj = LoadMethod(EntryInfo_Json);
            }
            else if (type == "json")
            {
                jObj = LoadJson(EntryInfo_Json);
            }
            return (jObj);
        }
        private XmlDocument LoadFunc(EntryInfoXml EntryInfo_Xml)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {

                var type = EntryInfo_Xml.type;
                var data = EntryInfo_Xml.data;
                string option = EntryInfo_Xml.option;

                var hProc = new hostProc();
                if( type == "method")
                {
                    xmlDoc = LoadMethod(EntryInfo_Xml);
                }
                else if (type == "json")
                {
                    xmlDoc = LoadJson(EntryInfo_Xml);
                }
                else if (type == "xml")
                {
                    xmlDoc = LoadXml(EntryInfo_Xml);
                }
                else
                {
                    xmlDoc = LoadText(EntryInfo_Xml);
                }
                var Declaration = xmlDoc.FirstChild.GetType().ToString();

                if (!(Declaration == "System.Xml.XmlDeclaration" || Declaration == "System.Xml.XmlProcessingInstruction"))
                {
                    XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
                    xmlDoc.PrependChild(declaration);
                }
                string comment = System.Web.HttpUtility.UrlDecode(makeOption(option), Encode);
                //hProc.AddComment(xmlDoc, name);
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
        private JObject LoadMethod(EntryInfoJson EntryInfo_Json)
        {
            //JObject jObj = new JObject();
            var option = EntryInfo_Json.option;
            string Item = EntryInfo_Json.data.Trim('/');
            string[] ItemWork = Item.Split('/');
            if (ItemWork.Length != 2) throw new Exception("引数[" + option + "]が不明です");

            string className = ItemWork[0];
            string methodName = ItemWork[1];

            String nameSpace = "WebApi_project.hostProc";

            Type classType = Type.GetType(string.Concat(nameSpace, ".", className));
            if (classType == null) throw new Exception("calss名[" + className + "]が不明です");
            var obj = Activator.CreateInstance(classType);
            MethodInfo method = classType.GetMethod(methodName);
            if (method == null) throw new Exception("calss名[" + className + "] method名[" + methodName + "]が不明です");

            var jsonObj = method.Invoke(obj, new object[] { option });
            var jsonStr = JsonConvert.SerializeObject(jsonObj);
            var jObj = JObject.Parse(jsonStr);
            return (jObj);
        }
        private XmlDocument LoadMethod(EntryInfoXml EntryInfo_Xml)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {
                var option = EntryInfo_Xml.option;
                string Item = EntryInfo_Xml.data.Trim('/');
                string[] ItemWork = Item.Split('/');
                if (ItemWork.Length != 2) throw new Exception("引数[" + option + "]が不明です");

                string className = ItemWork[0];
                string methodName = ItemWork[1];

                String nameSpace = "WebApi_project.hostProc";

                Type classType = Type.GetType(string.Concat(nameSpace, ".", className));
                if (classType == null) throw new Exception("calss名[" + className + "]が不明です");
                var obj = Activator.CreateInstance(classType);
                MethodInfo method = classType.GetMethod(methodName);
                if (method == null) throw new Exception("calss名[" + className + "] method名[" + methodName + "]が不明です");
                xmlDoc = (XmlDocument)method.Invoke(obj, new object[] { option });
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

        private XmlDocument LoadXml(EntryInfoXml EntryInfo_Xml)
        {
            XmlDocument xmlDoc = new XmlDocument();
            var url = EntryInfo_Xml.data;
            var option = EntryInfo_Xml.option;
            url += makeOption(option, "?");
            hostWeb h = new hostWeb();
            string xmlStr = h.GetRequest(url, "Shift_JIS");
            if (xmlStr == null) xmlStr = "<root/>";
            xmlDoc.LoadXml(xmlStr);
            return (xmlDoc);
        }
        private JObject LoadJson(EntryInfoJson EntryInfo_Json)
        {
            var hProc = new hostProc();
            JObject oJson = new JObject();
            var url = EntryInfo_Json.data;
            var option = EntryInfo_Json.option;
            url += makeOption(option, "?");
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            if (!String.IsNullOrEmpty(jsonStr))
            {
                oJson = JObject.Parse(jsonStr);
                hProc.JsonArrayConvert(ref oJson, "月", "m");
            }
            return (oJson);
        }
        private XmlDocument LoadJson(EntryInfoXml EntryInfo_Xml)
        {
            XmlDocument xmlDoc = new XmlDocument();
            var hProc = new hostProc();
            JObject oJson = new JObject();
            var url = EntryInfo_Xml.data;
            var option = EntryInfo_Xml.option;
            url += makeOption(option, "?");
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            if (!String.IsNullOrEmpty(jsonStr))
            {
                oJson = JObject.Parse(jsonStr);
                hProc.JsonArrayConvert(ref oJson, "月", "m");
                xmlDoc = hProc.JsonToXml(oJson);
            }
            else
            {
                MyDebug.Write("読込できませんでした", url);
                xmlDoc.LoadXml("<root/>");
                xmlDoc.DocumentElement.InnerText = "読込できませんでした" + url;
            }
            return (xmlDoc);
        }
        private XmlDocument LoadText(EntryInfoXml EntryInfo_Xml)
        {
            System.Text.Encoding enc_utf8 = System.Text.Encoding.GetEncoding("UTF-8");
            System.Text.Encoding enc_euc = System.Text.Encoding.GetEncoding("euc-jp");
            System.Text.Encoding enc_sjis = System.Text.Encoding.GetEncoding("Shift_Jis");
            var url = EntryInfo_Xml.data;
            var option = EntryInfo_Xml.option;

            option = makeOption(option, "");
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
        private SortedDictionary<TKey, TValue> Marge<TKey, TValue>(SortedDictionary<TKey, TValue> a,
                                                    SortedDictionary<TKey, TValue> b)
        {
            var table = new SortedDictionary<TKey, TValue>();
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
        private EntryInfoXml GetEntryTab_xml(string Item)
        {

            if (EntryTab_xml.Count == 0)
            {
                Type type = typeof(WebApi_project.hostProc.hostProc);
                FieldInfo[] fields = type.GetFields(BindingFlags.Public | BindingFlags.Instance);
                foreach (FieldInfo f in fields)
                {
                    if (f.FieldType.Name == "SortedDictionary`2" && f.ToString().Contains("EntryInfoXml"))
                    {
                        FieldInfo field = type.GetField(f.Name);
                        var obj = Activator.CreateInstance(type);
                        var oDic = field.GetValue(obj);
                        EntryTab_xml = Marge(EntryTab_xml, (SortedDictionary<string, EntryInfoXml>)oDic);
                    }
                }
            }
            try
            {
                var Tab = (Item != "" ? EntryTab_xml[Item] : new EntryInfoXml());
                return (Tab);
            }catch(Exception ex)
            {
                var x = ex.Message;
                return (null);
            }

        }
        private EntryInfoJson GetEntryTab_json(string Item)
        {
            bool stat = false;
            if (EntryTab_json.Count == 0)
            {
                Type type = typeof(WebApi_project.hostProc.hostProc);
                FieldInfo[] fields = type.GetFields(BindingFlags.Public | BindingFlags.Instance);
                foreach (FieldInfo f in fields)
                {
                    if (f.FieldType.Name == "SortedDictionary`2" && f.ToString().Contains("EntryInfoJson"))
                    {
                        FieldInfo field = type.GetField(f.Name);
                        var obj = Activator.CreateInstance(type);
                        var oDic = field.GetValue(obj);
                        EntryTab_json = Marge(EntryTab_json, (SortedDictionary<string, EntryInfoJson>)oDic);
                    }
                }
            }
            else
            {
                foreach (var item in EntryTab_json)
                {
                    if (Item == item.Key) stat = true;
                }
            }
            var Tab = (Item != "" && stat == true ? EntryTab_json[Item] : new EntryInfoJson());
            return (Tab);
        }

        public XmlDocument EntryList()
        {
            GetEntryTab_xml("");
            GetEntryTab_json("");

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            xmlDoc.AppendChild(xmlMain);
            root.SetAttribute("name", "EMG");
            xmlDoc.AppendChild(root);

            XmlElement root_sample = xmlDoc.CreateElement("sample");
            root.AppendChild(root_sample);

            XmlElement root_xml = xmlDoc.CreateElement("xml");
            root.AppendChild(root_xml);
            foreach (var item in EntryTab_xml)
            {
                if(item.Key.IndexOf("_sample/") == 0)
                {
                    makeMenu(root_sample, item.Key, item.Key, item.Value, EntryTab_xml);
                }
                else
                {
                    makeMenu(root_xml, item.Key, item.Key, item.Value, EntryTab_xml);
                }
                //root_xml.AppendChild(s_menu);
            }
            XmlElement root_json = xmlDoc.CreateElement("json");
            root.AppendChild(root_json);
            foreach (var item in EntryTab_json)
            {
                makeMenu(root_json, item.Key, item.Key, item.Value, EntryTab_json);
                //root_xml.AppendChild(s_menu);
            }
            return (xmlDoc);
        }
        private void makeMenu(XmlElement p_menu, string name, string fullName, EntryInfoXml EntryInfo_Xml, SortedDictionary<string, EntryInfoXml> EntryTab_Xml)
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
                makeMenu(menu, new_name, fullName, EntryInfo_Xml, EntryTab_Xml);
            }
            else
            {
                XmlElement menu = xmlDoc.CreateElement("menu");
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("table", "xml");
                menu.SetAttribute("type", EntryInfo_Xml.type);
                menu.SetAttribute("option", EntryInfo_Xml.option);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }
        private void makeMenu(XmlElement p_menu, string name, string fullName, EntryInfoJson EntryInfo_Json, SortedDictionary<string, EntryInfoJson> EntryTab_Json)
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
                makeMenu(menu, new_name, fullName, EntryInfo_Json, EntryTab_Json);
            }
            else
            {
                XmlElement menu = xmlDoc.CreateElement("menu");
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("table", "json");
                menu.SetAttribute("type", EntryInfo_Json.type);
                menu.SetAttribute("option", EntryInfo_Json.option);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }
        XmlDocument LoadFunc_Local(EntryInfoXml EntryInfo_Xml)
        {
            XmlDocument xmlDoc = new XmlDocument();
            string workString = "";
            var hProc = new hostProc();
            hostWeb hWeb = new hostWeb();

            string fName  = EntryInfo_Xml.dataX;
            var type = (EntryInfo_Xml.typeX != null ? EntryInfo_Xml.typeX : EntryInfo_Xml.type);

            var urlMode = ValidHttpURL(fName);

            if (urlMode)
            {
                var option = EntryInfo_Xml.option;
                string url = fName + makeOption(option, "?");
                workString = hWeb.GetRequest(url, "Shift_JIS");
            }
            else
            {
                string filePath = hProc.basePath + fName;
                if (File.Exists(filePath))
                {
                    //Console.WriteLine("存在します");
                    StreamReader r = new StreamReader(filePath, Encode);
                    workString = r.ReadToEnd();
                }
            }
            if (!String.IsNullOrEmpty(workString))
            {
                if( type == "json")
                {
                    JObject oJson = JObject.Parse(workString);
                    hProc.JsonArrayConvert(ref oJson, "月", "m");
                    xmlDoc = hProc.JsonToXml(oJson);
                }
                else if (type == "xml")
                {
                    xmlDoc.LoadXml(workString);
                }
                var Declaration = xmlDoc.FirstChild.GetType().ToString();
                if (!(Declaration == "System.Xml.XmlDeclaration" || Declaration == "System.Xml.XmlProcessingInstruction"))
                {
                    XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
                    xmlDoc.PrependChild(declaration);
                }
            }
            return (xmlDoc);
        }
        JObject LoadFunc_Local(EntryInfoJson EntryInfo_Json)
        {
            JObject jObj = new JObject();
            string fName = EntryInfo_Json.dataX;
            var urlMode = ValidHttpURL(fName);
            if(urlMode)
            {
                hostWeb h = new hostWeb();
                string jsonStr = h.GetRequest(fName, "Shift_JIS");
                if (!String.IsNullOrEmpty(jsonStr))
                {
                    jObj = JObject.Parse(jsonStr);
                }
            }
            else
            {
                var hProc = new hostProc();
                string filePath = hProc.basePath + fName;
                if (File.Exists(filePath))
                {
                    //Console.WriteLine("存在します");
                    StreamReader r = new StreamReader(filePath, Encode);
                    string jsonString = r.ReadToEnd();
                    jObj = JObject.Parse(jsonString);
                }
            }
            return (jObj);
        }
        static bool ValidHttpURL(string s)
        {
            Uri uriResult;
            return Uri.TryCreate(s, UriKind.Absolute, out uriResult) && uriResult.Scheme == Uri.UriSchemeHttp;
        }
        public string Entry_Check(string Item)
        {
            var hProc = new hostProc();
            string jsonStr = null;
            EntryInfoXml EntryInfo_Xml = GetEntryTab_xml(Item);
            EntryInfoJson EntryInfo_json = GetEntryTab_json(Item);
            if (EntryInfo_Xml != null || EntryInfo_json != null)
            {
                string target_url, option;
                if (EntryInfo_Xml != null)
                {
                    target_url = hProc.local_mode ? EntryInfo_Xml.dataX : EntryInfo_Xml.data;
                    option = JsonMerge(EntryInfo_Xml.option, "{queryChk:'1'}");

                }
                else
                {
                    target_url = hProc.local_mode ? EntryInfo_json.dataX : EntryInfo_json.data;
                    option = JsonMerge(EntryInfo_json.option, "{queryChk:'1'}");

                }
                string url = target_url + makeOption(option, "?");

                hostWeb h = new hostWeb();
                jsonStr = h.GetRequest(url, "Shift_JIS");

                try
                {
                    // 戻り値がjson?
                    JObject jsonObject = JObject.Parse(jsonStr);
                }
                catch (Exception ex)
                {
                    var s = ex.Message;
                    var work = HttpUtility.UrlDecode(url, Encode);
                    var Msg = new Dictionary<string, string>()
                        {
                            { "message" , "応答がありませんでした"},
                            { "Item"    , Item},
                            { "url"     , work }
                        };

                    // Dictionaryをシリアライズします。
                    jsonStr = System.Text.Json.JsonSerializer.Serialize(Msg);
                }
            }
            else
            {
                EntryInfoJson EntryInfo_Json = GetEntryTab_json(Item);
                string target_url = EntryInfo_Json.data;
                jsonStr = null;     // "{'error':'ABC'}";
                var Msg = new Dictionary<string, string>()
                        {
                            { "message" , "xmlTabにはありませんでした"},
                            { "Item"    , Item},
                            {"url"      , target_url }
                        };
                jsonStr = System.Text.Json.JsonSerializer.Serialize(Msg);
            }
            return (jsonStr);

        }

    }
}