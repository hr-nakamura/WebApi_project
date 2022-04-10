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
    public class _Test_Json2 : hostProc
    {

        public Dictionary<string, EntryInfo> 要員情報XX = new Dictionary<string, EntryInfo>(){
            { "要員情報/要員一覧", new EntryInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<TKey, TValue> Marge<TKey, TValue>(Dictionary<TKey, TValue> a,
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
        public Dictionary<string, object> mList()
        {
            //object o_obj = new object();
            String nameSpace = "WebApi_project.hostProc";

            Dictionary<string, List<string>> xTab = new Dictionary<string, List<string>>();
            Dictionary<string, List<string>> Tab_xml = new Dictionary<string, List<string>>();
            Dictionary<string, List<string>> Tab_json = new Dictionary<string, List<string>>();
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Tab.Add("xml", Tab_xml);
            Tab.Add("json", Tab_json);
            Assembly assm = Assembly.GetExecutingAssembly();

            List<string> className_X = new List<string>()
                {
                "hostWeb"
                };
            List<string> methdName_X = new List<string>()
                {
                "Entry","Json2Xml","JsonToXml","methodList"
                };

            // 指定した名前空間のクラスをすべて取得
            var types = assm.GetTypes()
                .Where(p => p.Namespace == nameSpace)
                .OrderBy(o => o.Name)
                .Select(s => s);

            foreach (Type t in types)
            {
                //Debug.Write("====",t.Name);
                string className = t.Name;
                var mList = t.GetMethods();

                foreach (var m in mList)
                {
                    string methodName = m.Name;
                    if (className == "_Test_Json2")
                    {
                        MyDebug.Write(className, methodName, m.ReturnType.ToString());
                    }

                        //MyDebug.Write(className, methodName, m.ReturnType.ToString());
                    if (!className_X.Contains(className) && !methdName_X.Contains(methodName))
                    {
                        if (m.ReturnType == typeof(IDictionary<string,EntryInfo>))
                        {
                            MyDebug.Write("############",className, methodName, m.ReturnType.ToString());
                        }

                        //Debug.Write(className, methodName, m.ReturnType.ToString());
                        if (m.ReturnType == typeof(IDictionary<string, EntryInfo>))
                        {
                            if (!Tab_xml.ContainsKey(className))
                            {
                                var methodTab = new List<string>();
                                Tab_xml.Add(className, methodTab);
                            }
                            //Type classType = Type.GetType(nameSpace + "." + className);
                            //var obj = Activator.CreateInstance(classType);

                            Tab_xml[className].Add(methodName);
                            //Debug.Write(className, methodName, m.ReturnType.ToString());
                        }
                        else if (m.ReturnType == typeof(Object))
                        {
                            if (!Tab_json.ContainsKey(className))
                            {
                                var methodTab = new List<string>();
                                Tab_json.Add(className, methodTab);
                            }
                            //Type classType = Type.GetType(nameSpace + "." + className);
                            //var obj = Activator.CreateInstance(classType);

                            Tab_json[className].Add(methodName);
                            //MyDebug.Write(className, methodName, m.ReturnType.ToString());
                        }
                    }
                    else
                    {
                        //MyDebug.Write("###",className, methodName, m.ReturnType.ToString());
                    }
                }
            }
            return (Tab);
        }

        public XmlDocument projectTest2(String Json)
        {
            MyDebug.Write("projectTest2");

            var x = mList();

            var EntryTab = new Dictionary<string,EntryInfo>();
            EntryTab = Marge(EntryTab, projectInfo);
            EntryTab = Marge(EntryTab, projectCostProc);

            string entryName = "projectCostProc/xml/projectInfo_XML_Detail";
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
