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
        //XmlDocument methodList1()
        //{
        //    //Debug.Write("methodList");
        //    XmlDocument xmlDoc = new XmlDocument();
        //    xmlDoc.CreateXmlDeclaration("1.0", null, null);

        //    var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
        //    XmlElement root = xmlDoc.CreateElement("root");
        //    xmlDoc.AppendChild(xmlMain);
        //    root.SetAttribute("name", "EMG");
        //    xmlDoc.AppendChild(root);

        //    XmlElement root_xml = xmlDoc.CreateElement("xml");
        //    root.AppendChild(root_xml);

        //    Dictionary<string, object> list = (Dictionary<string, object>)EntryList();
        //    Dictionary<string, List<string>> Tab_xml = (Dictionary<string, List<string>>)list["xml"];

        //    foreach (var x1 in Tab_xml)
        //    {
        //        XmlElement node1 = xmlDoc.CreateElement("menu");
        //        string className = x1.Key;
        //        node1.SetAttribute("name", className);
        //        root_xml.AppendChild(node1);
        //        foreach (var methodName in x1.Value)
        //        {
        //            XmlElement node2 = xmlDoc.CreateElement("menu");
        //            node2.SetAttribute("type", "xml");
        //            node2.SetAttribute("name", methodName);
        //            node2.SetAttribute("mode", "method");
        //            node2.SetAttribute("item", className);
        //            node2.SetAttribute("func", methodName);
        //            node1.AppendChild(node2);
        //        }
        //    }
        //    return (xmlDoc);
        //}
        public XmlDocument EntryList()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");
            xmlDoc.AppendChild(xmlMain);
            root.SetAttribute("name", "EMG");
            xmlDoc.AppendChild(root);

            XmlElement root_xml = xmlDoc.CreateElement("test");
            root.AppendChild(root_xml);
            int i = 0;
            foreach (var item in xmlEntryTab)
            {
                XmlElement s_menu = makeMenu(root_xml, item.Key, item.Key, item.Value, i);
                //root_xml.AppendChild(s_menu);
            }
            return (xmlDoc);
        }
        XmlElement makeMenu(XmlElement p_menu, string name, string fullName, Dictionary<string, string> item, int i)
        {
            string[] x = name.Split('/');
            XmlDocument xmlDoc = p_menu.OwnerDocument;
            XmlElement menu = xmlDoc.CreateElement("menu");
            if (x.Length > 1)
            {
                int indexToRemove = 0;
                string[] z = x.Where((source, index) => index != indexToRemove).ToArray();
                string new_name = String.Join("/", z);
                menu.SetAttribute("name", z[0]);
                menu.SetAttribute("data", fullName);
                menu.SetAttribute("i", i++.ToString());
                XmlElement s_menu = makeMenu(menu, new_name, fullName, item, i);
                p_menu.AppendChild(s_menu);
            }
            else
            {
                menu.SetAttribute("name", x[0]);
                menu.SetAttribute("mode", "method");
                menu.SetAttribute("data", fullName);
                menu.SetAttribute("i", i++.ToString());
                p_menu.AppendChild(menu);
            }
            return (menu);
        }
        //XmlElement makeMenux(XmlElement menu, string name, Dictionary<string, string>item)
        //{
        //    XmlDocument xmlDoc = menu.OwnerDocument;
        //    MyDebug.Write("--makeMenu", xmlDoc.SelectSingleNode("root/test").InnerXml);
        //    string[] x = name.Split('/');
        //    if (x.Length > 1)
        //    {
        //        name = x[0];
        //        XmlElement node = xmlDoc.CreateElement("menu");

        //        int indexToRemove = 0;
        //        string[] z = x.Where((source, index) => index != indexToRemove).ToArray();
        //        node.SetAttribute("name", z[0]);
        //        //node.SetAttribute("user", "ZZ");
        //        string new_name = String.Join("/", z);
        //        XmlElement s_menu = makeMenu(node, new_name, item);
        //        menu.AppendChild(s_menu);
        //    }
        //    else
        //    {
        //        XmlElement ret_menu = xmlDoc.CreateElement("menu");
        //        MyDebug.Write("memo", "実行" + item["func"]);
        //        menu.SetAttribute("name", x[0]);
        //        menu.SetAttribute("mode", item["mode"]);
        //        //menu.SetAttribute("func", item["func"]);
        //        //menu.SetAttribute("option", item["option"]);
        //        //menu.SetAttribute("memo", x.Length.ToString());
        //    }
        //    //JObject Json = new JObject();
        //    return (menu);
        //}

        public Dictionary<string, Dictionary<string, string>> xmlEntryTab = new Dictionary<string, Dictionary<string, string>>() {
            { "ABC",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "hostProc/TestD" },
                { "option", "{year:2022,actual:5}" }
            } },
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
            //{ "売上予測/売上予実_部門",new Dictionary<string, string>(){
            //    { "mode", "json" },
            //    { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
            //    { "option", "{year:2022,actual:5}" }
            //} },
            //{ "売上予測/売上予実_分類",new Dictionary<string, string>(){
            //    { "mode", "json" },
            //    { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
            //    { "option", "{year:2022,actual:5}" }
            //} },
            //{ "売上予測/売上予実_新規",new Dictionary<string, string>(){
            //    { "mode", "json" },
            //    { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
            //    { "option", "{year:2022,actual:5}" }
            //} },
            //{ "売上予測/売上予実_新規2",new Dictionary<string, string>(){
            //    { "mode", "json" },
            //    { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
            //    { "option", "{year:2022,actual:5}" }
            //} },
            //{ "費用予測/費用状況",new Dictionary<string, string>(){
            //    { "mode", "json" },
            //    { "func", "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" },
            //    { "option", "{year:2022,actual:5}" }
            //} },
            //{ "要員情報/要員一覧",new Dictionary<string, string>(){
            //    { "mode", "xml" },
            //    { "func", "http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp" },
            //    { "option", "{year:2022,actual:5}" }
            //} },
        };
    }
}
