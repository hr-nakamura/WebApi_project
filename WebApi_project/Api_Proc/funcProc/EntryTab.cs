using System;
using System.Web;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;
using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {
        XmlDocument methodList1()
        {
            //Debug.Write("methodList");
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            xmlDoc.AppendChild(xmlMain);
            root.SetAttribute("name", "EMG");
            xmlDoc.AppendChild(root);

            XmlElement root_xml = xmlDoc.CreateElement("xml");
            root.AppendChild(root_xml);

            Dictionary<string, object> list = (Dictionary<string, object>)EntryList();
            Dictionary<string, List<string>> Tab_xml = (Dictionary<string, List<string>>)list["xml"];

            foreach (var x1 in Tab_xml)
            {
                XmlElement node1 = xmlDoc.CreateElement("menu");
                string className = x1.Key;
                node1.SetAttribute("name", className);
                root_xml.AppendChild(node1);
                foreach (var methodName in x1.Value)
                {
                    XmlElement node2 = xmlDoc.CreateElement("menu");
                    node2.SetAttribute("type", "xml");
                    node2.SetAttribute("name", methodName);
                    node2.SetAttribute("mode", "method");
                    node2.SetAttribute("item", className);
                    node2.SetAttribute("func", methodName);
                    node1.AppendChild(node2);
                }
            }
            return (xmlDoc);
        }
        public object EntryList()
        {
            XmlDocument xmlDoc = new XmlDocument();
            //xmlDoc.CreateXmlDeclaration("1.0", null, null);

            //var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            //XmlElement root = xmlDoc.CreateElement("root");
            //xmlDoc.AppendChild(xmlMain);
            //root.SetAttribute("name", "EMG");
            //xmlDoc.AppendChild(root);

            //XmlElement root_xml = xmlDoc.CreateElement("xml");
            //XmlElement root_json = xmlDoc.CreateElement("json");
            //root.AppendChild(root_xml);
            //root.AppendChild(root_json);
            foreach (var item in xmlEntryTab)
            {
                makeMenu(item.Key,item.Value);
            }
            string jsonStr = JsonConvert.SerializeObject(xmlEntryTab);             // Json形式を文字列に
            var jo = JsonConvert.DeserializeObject(jsonStr);
            //            xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr, "root");       // Json文字列をXML　objectに


            return (jo);
        }
        JObject makeMenu(string name, Dictionary<string, string>item)
        {
            string[] x = name.Split('/');
            if ( x.Length > 2)
            {
                MyDebug.Write(">>>", x.Length.ToString(), name);
                int indexToRemove = 0;
                x = x.Where((source, index) => index != indexToRemove).ToArray();
                string xx = String.Join("/", x);
                makeMenu(xx, item);
            }
            else
            {
                //MyDebug.Write("=======",name);
                foreach (KeyValuePair<string, string> kvp in item)
                {
                    string key = kvp.Key;
                    string nameX = kvp.Value;
                    if( key == "func") MyDebug.Write("実行", "=======", name,nameX);
                }

            }
            JObject Json = new JObject();
            return (Json);
        }

        public Dictionary<string, Dictionary<string, string>> xmlEntryTab = new Dictionary<string, Dictionary<string, string>>() {
            { "ABC/機能",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "hostProc/TestA" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "ABC/機能/xyz",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "hostProc/TestB" },
                { "option", "{year:2022,actual:5}" }
            } },            
            { "ABC/機能/zzz",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "hostProc/TestC" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "ABC",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "hostProc/TestD" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_部門",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_分類",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_新規",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_新規2",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "費用状況",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "要員一覧",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
        };
    }
}
