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
        int yymmAdd(int yymm, int mCnt)
        {
            int yy = yymm / 100;
            int mm = yymm % 100;

            int ym = (yy * 12) + mm;
            ym += mCnt;
            yy = ym / 12;
            mm = ym % 12;
            if (mm == 0) { yy--; mm = 12; }
            return ((yy * 100) + mm);
        }
        int yymmDiff(int base_yymm, int yymm)
        {
            int b_yy = base_yymm / 100;
            int b_mm = base_yymm % 100;
            int yy = yymm / 100;
            int mm = yymm % 100;

            mm += (yy - b_yy) * 12;
            int n = (mm - b_mm);
            return (n);
        }



        public object json_projectTest(String Json)
        {
            Debug.Write("json_projectTest");
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

            xxx();
            var Tab1 = readJson();

            return (Tab1);
        }

        public XmlDocument projectTest(String Json)
        {
            Debug.Write("projectTest");

            var Tab = json_projectTest("");

            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr);       // Json文字列をXML　objectに

            return (xmlDoc);
        }

        Dictionary<string, object> readJson()
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            XmlDocument doc = new XmlDocument();
            string url = "http://localhost/Asp/Test/test.Json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url);


            //object x = JObject.Parse(JsonStr);                              // 文字列をJson形式に
            object Json = JsonConvert.DeserializeObject(JsonStr);
            JObject elem1 = (JObject)Json;
            //========================================

            JObject O_Top = new JObject();

            JArray A_elem1 = new JArray { };
            O_Top.Add("element1", A_elem1);

            foreach (var m1 in elem1)
            {
                JObject O_elem1 = new JObject { { "@name", m1.Key } };
                A_elem1.Add(O_elem1);

                JArray A_elem2 = new JArray { };
                O_elem1.Add("elemnt2", A_elem2);

                foreach (var m2 in (JObject)m1.Value)
                {
                    JObject O_elem2 = new JObject { { "@name", m2.Key } };
                    A_elem2.Add(O_elem2);

                    JArray A_elem3 = new JArray { };
                    O_elem2.Add("elemnt3", A_elem3);

                    foreach (var m3 in (JObject)m2.Value)
                    {
                        JObject O_elem3 = new JObject { { "@name", m3.Key } };
                        A_elem3.Add(O_elem3);

                        JArray A_elem4 = new JArray { };
                        O_elem3.Add("月", A_elem4);

                        for (var c4 = 0; c4 < m3.Value.Count(); c4++)
                        {
                            JObject O_elem4 = new JObject { { "@m", c4 }, { "#text", m3.Value[c4] } };
                            A_elem4.Add(O_elem4);
                            var z1 = m2.Value.Type.ToString();
                            var z2 = m3.Value.Type.ToString();
                        }

                    }

                }
            }



            JObject Top = new JObject();
            Top.Add("全体", O_Top);

            Tab.Add("root", Top);
            return (Tab);
        }

    }
}
