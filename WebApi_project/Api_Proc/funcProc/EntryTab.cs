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
        public XmlDocument xmlEntry(string Item, string Json)
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

            XmlElement root_xml = xmlDoc.CreateElement("test");
            root.AppendChild(root_xml);
            int i = 0;
            foreach (var item in xmlEntryTab)
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
                XmlElement menu = (XmlElement)p_menu.SelectSingleNode("menu[@mode='sub' and @name='"+x[0]+"']");
                if( menu == null) menu = xmlDoc.CreateElement("menu");
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
                menu.SetAttribute("mode", item["mode"]);
                menu.SetAttribute("option", item["option"]);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }
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
            { "projectCostProc/xml/projectInfo_XML_Detail",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Detail.asp" },
                { "option", "{pNum:20214693}" }
            } },
            { "projectCostProc/xml/projectInfo_XML_Join",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Join.asp" },
                { "option", "{pNum:20214693}" }
            } },
            { "projectCostProc/xml/projectInfoList_XML",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp" },
                { "option", "{s_yymm:202110,mCnt:12}" }
            } },
            { "売上予測/売上予実_部門",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_分類",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_新規",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_新規2",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "費用予測/費用状況",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "要員情報/要員一覧",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
        };
    }
}
