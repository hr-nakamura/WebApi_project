using System;
using System.Web;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;

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
        public XmlDocument xmlEntryList()
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
                menu.SetAttribute("mode", item["mode"]);
                menu.SetAttribute("option", item["option"]);
                menu.SetAttribute("item", fullName);
                p_menu.AppendChild(menu);
            }
        }

    }
}