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
        public XmlDocument projectTest2(String Json)
        {
            MyDebug.Write("projectTest2");

            //var Tab = json_projectTest2("");

            //string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            //XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr);       // Json文字列をXML　objectに

            XmlDocument xmlDoc = new XmlDocument();
            return (xmlDoc);
        }
        public object json_projectTest2(String Json)
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

            //var Tab1 = readJson2();
            return (Tab);


        }


        Dictionary<string, object> readJson2()
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            XmlDocument doc = new XmlDocument();
            string url = "http://localhost/Asp/Test/test.Json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url);


            //object x = JObject.Parse(JsonStr);                              // 文字列をJson形式に
            object Json = JsonConvert.DeserializeObject(JsonStr);
            JObject elem = (JObject)Json;

            JObject O_Top = new JObject();

            JArray A_elem1 = new JArray { };
            O_Top.Add("element1", A_elem1);
            foreach (var m1 in (JObject)elem)
            {
                JObject O_elem1 = new JObject { { "@name", m1.Key } };
                A_elem1.Add(O_elem1);

                JArray A_elem2 = new JArray { };
                O_elem1.Add("element2", A_elem2);
                foreach (var m2 in (JObject)m1.Value)
                {
                    JObject O_elem2 = new JObject { { "@name", m2.Key } };
                    A_elem2.Add(O_elem2);

                    JArray A_elem3 = new JArray { };
                    O_elem2.Add("element3", A_elem3);

                    foreach (var m3 in (JObject)m2.Value)
                    {
                        JObject O_elem3 = new JObject { { "@name", m3.Key } };
                        A_elem3.Add(O_elem3);

                        JArray A_elem4 = new JArray { };
                        O_elem3.Add("月", A_elem4);
                        for (var c = 0; c < m3.Value.Count(); c++)
                        {
                            JObject O_elem4 = new JObject { { "@m", c }, { "#text", m3.Value[c] } };
                            A_elem4.Add(O_elem4);
                        }
                    }

                }
                    //if (m.Value.Type.ToString() == "Object")
                    //{
                    //    //CreateJson(O_elem, (JObject)m.Value);
                    //}
                    //else
                    //{
                    //    //CreateJson(O_elem, (JArray)m.Value);
                    //}

                }
            JObject Top = new JObject();
            Top.Add("全体", O_Top);

            Tab.Add("root", Top);
            return (Tab);
        }



    }
}
