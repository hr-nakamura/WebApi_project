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
    public class QOSMIO : hostProc
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

            //Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab.Add("mName", mName);
            //Tab.Add("className", className);
            //Tab.Add("methodName", methodName);
            //Tab.Add("DB_Conn", DB_connectString);

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
            //JObject elem = (JObject)Json;


            JObject O_Top = new JObject();
            //========================================

            CreateJson(O_Top, (JObject)Json);

            //========================================

            JObject Top = new JObject();
            Top.Add("全体", O_Top);

            Tab.Add("root", Top);
            return (Tab);
        }
        void CreateJson(JObject O_Top, JObject elem)
        {
            JArray A_elem = new JArray { };
            O_Top.Add("element", A_elem);
            foreach (var m in (JObject)elem)
            {
                JObject O_elem = new JObject { { "@name", m.Key } };
                A_elem.Add(O_elem);
                if (m.Value.Type.ToString() == "Object")
                {
                    CreateJson(O_elem, (JObject)m.Value);
                }
                else
                {
                    CreateJson(O_elem, (JArray)m.Value);
                }

            }
        }
        void CreateJson(JObject O_Top, JArray elem)
        {
            JArray A_elem = new JArray { };
            O_Top.Add("月", A_elem);
            for (var c = 0; c < elem.Count(); c++)
            {
                JObject O_elem = new JObject { { "@m", c }, { "#text", elem[c] } };
                A_elem.Add(O_elem);
            }
        }

    }
}
