using System;
using System.Web;
using System.Xml;
using System.Reflection;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Xml.Linq;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using System.Text.Json;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class _Test_Json : hostProc
    {

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
        private Dictionary<string, EntryInfo> GetEntryTab()
        {

            var EntryTab = new Dictionary<string, EntryInfo>();

            Type type = typeof(WebApi_project.hostProc.hostProc);
            FieldInfo[] fields = type.GetFields(BindingFlags.Public | BindingFlags.Instance);
            foreach (FieldInfo f in fields)
            {
                if( f.FieldType.Name == "Dictionary`2" && f.ToString().Contains("EntryInfo"))
                {
                    MyDebug.Write(f.MemberType.ToString(), f.FieldType.Name.ToString(), f.Name, f.FieldType.ToString());
                    FieldInfo field = type.GetField(f.Name);
                    var obj = Activator.CreateInstance(type);
                    var oDic = field.GetValue(obj);
                    EntryTab = Marge(EntryTab, (Dictionary<string, EntryInfo>)oDic);
                }
            }
            return (EntryTab);
        }
        void xxx2()
        {
            Type t = typeof(WebApi_project.hostProc._Test_Json);
            MemberInfo[] members = t.GetMembers(BindingFlags.Public | BindingFlags.Instance);
            foreach (MemberInfo m in members)
            {
                MyDebug.Write(m.MemberType.ToString(), m.Name);
            }

        }

        public XmlDocument projectTest2(String Json)
        {
            MyDebug.Write("projectTest2");
            var EntryTab = GetEntryTab();

            string entryName = "projectCostProc/projectInfo_XML_Detail";
            MyDebug.Write(EntryTab[entryName].type);
            MyDebug.Write(EntryTab[entryName].data);
            MyDebug.Write(EntryTab[entryName].option);


            //            var xmlDoc = EntryList();

            //XmlDocument xmlDoc = new XmlDocument();
            //xmlDoc.LoadXml("<root><menu name='ABC'/><menu mode='method' name='ABC'/></root>");

            //string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            //XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr,"root");       // Json文字列をXML　objectに

            XmlDocument xmlDoc = new XmlDocument();
            return (xmlDoc);
        }
        public JObject json_projectTest2(String Json)
        {
            MyDebug.Write("json_projectTest2");
            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            //Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            Tab.Add("mName", mName);
            Tab.Add("className", className);
            Tab.Add("methodName", methodName);
            Tab.Add("DB_Conn", DB_connectString);

            string json = System.Text.Json.JsonSerializer.Serialize(Tab);
            var jobj1 = JObject.Parse(json);

            //var json2 = "{\"key1\":\"value1\",\"key2\":\"value2\",\"array1\":[{\"childkey1\":\"childvalue1\"},{\"childkey2\":\"childvalue2\"}]}";
            //var jobj2 = JObject.Parse(json2);

            //var dictionary = new Dictionary<string, string>();
            //foreach (var item in jobj2)
            //{
            //    MyDebug.Write(item.Key, item.Value.ToString());
            //    if (item.Value.Type == JTokenType.String)
            //    {
            //        dictionary.Add(item.Key, item.Value.ToString());
            //    }
            //}

            // ToDictionary()を使えば1行で書けます
            //var dictionary = jobj2.Properties()
            //                .Where(jp => jp.Value.Type == JTokenType.String)
            //                .ToDictionary(jp => jp.Name, jp => jp.Value.ToString());


            return (jobj1);


        }
    }
}
