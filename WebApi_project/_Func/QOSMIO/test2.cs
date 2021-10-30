using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Xml.Linq;
using Newtonsoft.Json.Linq;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    partial class QOSMIO : hostProc
    {


        public object json_projectTest2(String Json)
        {
            Debug.Write("json_projectTest2");
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

            //aaa();
            //var Tab1 = readJson2();
            test();


            return (Tab);
        }

        public XmlDocument projectTest2(String Json)
        {
            Debug.Write("projectTest2");

            var Tab = json_projectTest2("");

            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr);       // Json文字列をXML　objectに

            return (xmlDoc);
        }



        Dictionary<string, object> readJson2()
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            XmlDocument doc = new XmlDocument();
            string url = "http://localhost/Asp/Test/test.Json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url);



            object x = JObject.Parse(JsonStr);                              // 文字列をJson形式に
            object Json = JsonConvert.DeserializeObject(JsonStr);           // 文字列をJson形式に

            Newtonsoft.Json.Linq.JObject elem = (Newtonsoft.Json.Linq.JObject)Newtonsoft.Json.JsonConvert.DeserializeObject(JsonStr);

            Dictionary<string, object> root = new Dictionary<string, object>();


            root.Add("root", Json);


            foreach (var m1 in elem)
            {
                Debug.Write("elem", m1.Key);
                var elem2 = m1.Value;
                foreach (var m2 in (JObject)elem2)
                {
                    if (m2.Key == "名前") continue;
                    Debug.Write("elem2", m2.Key);
                    var elem3 = m2.Value;
                    foreach (var m3 in (JObject)elem3)
                    {
                        Debug.Write("elem3", m3.Key);
                        var elem4 = m3.Value;

                        for (var m = 0; m < elem4.Count(); m++)
                        {
                            //Debug.Write("value", m.ToString(), elem4[m].ToString());
                            var a = 1;
                        }
                    }
                }
            }

            //Tab.Add("root", JObject.Parse(JsonStr));
            string jsonStr2 = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr2);       // Json文字列をXML　objectに
            return (root);
        }

        void test()
        {
            AAA aaa = new AAA();
            aaa.Property1 = 100;
            aaa.Property2 = "xxx";
            string json1 = JsonConvert.SerializeObject(aaa);

            AAA aaa1 = new AAA();
            AAA aaa2 = new AAA();
            aaa1.Property1 = 100;
            aaa1.Property2 = "xxx";
            aaa2.Property1 = 200;
            aaa2.Property2 = "yyy";
            aaa1.Property3 = aaa2;

            List<AAA> lstaaa = new List<AAA>();
            lstaaa.Add(aaa1);
            lstaaa.Add(aaa2);

            string json2 = JsonConvert.SerializeObject(lstaaa);

            element e1 = new element();
            element e2 = new element();
            e2.Name = "element2";
            e1.Name = "element1";
            e1.Property2 = e2;
            List<element> Top = new List<element>();
            Top.Add(e1);
            //Top.Add(e1);

            string JsonStr = JsonConvert.SerializeObject(e1);


            Dictionary<string, object> root = new Dictionary<string, object>();
            object Json = JsonConvert.DeserializeObject(JsonStr);
            root.Add("root", Json);

            string rootStr = JsonConvert.SerializeObject(root);
            XmlDocument xmlDoc1 = JsonConvert.DeserializeXmlNode(rootStr);       // Json文字列をXML　objectに


            var a = 1;

        }
        public class element
        {

            [JsonProperty("element")]
            public string Name { get; set; }

            [JsonProperty("prop2")]
            public element Property2 { get; set; }

        }
        public class AAA
        {
            [JsonProperty("prop1")]
            public int Property1 { get; set; }
            [JsonProperty("prop2")]
            public string Property2 { get; set; }
           [JsonProperty("prop3")]
            public AAA Property3 { get; set; }
        }
        public class Data
        {
            List<string> mData { get; set; }
        }
        public class Sample
        {
            string key1 { get; set; }
            string key2 { get; set; }
        }
        public class Sample2
        {
            Sample key { get; set; }
        }
        public List<Sample> list;

        public class Info1
        {
            public string 役職ID { get; set; }
            public string 役職 { get; set; }
            public string 社員区分 { get; set; }
            public string 社籍 { get; set; }
            public string 休職 { get; set; }
        }
        public class member1
        {
            public string 名前 { get; set; }
            public List<Info1> 月 { get; set; }
        }
        public class section1
        {
            public string 名前 { get; set; }
            public int 直間 { get; set; }
            public Dictionary<string, member1> member { get; set; }
        }
    }
}
