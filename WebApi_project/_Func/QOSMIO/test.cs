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

            //aaa();
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
            string url = "http://localhost/Asp/Test/test_Json.Json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url);


            object x = JObject.Parse(JsonStr);                              // 文字列をJson形式に
            object Json = JsonConvert.DeserializeObject(JsonStr);
            Tab.Add("root", Json);
            return (Tab);
        }

        void aaa()
        {
            string xmlStr = "<root>";
                xmlStr += "<element name='top1'><element1 name='XYZ'><data m='0'>AAA</data><data m='1'>AAA</data><data m='2'>AAA</data></element1><element1 name='XYZ'><data m='0'>AAA</data><data m='1'>AAA</data><data m='2'>AAA</data></element1><element1 name='XYZ'><data m='0'>AAA</data><data m='1'>AAA</data><data m='2'>AAA</data></element1></element>";
                xmlStr += "<element name='top2'><element1 name='XYZ'><data m='0'>AAA</data><data m='1'>AAA</data><data m='2'>AAA</data></element1><element1 name='XYZ'><data m='0'>AAA</data><data m='1'>AAA</data><data m='2'>AAA</data></element1><element1 name='XYZ'><data m='0'>AAA</data><data m='1'>AAA</data><data m='2'>AAA</data></element1></element>";
                xmlStr += "</root>";

            XmlDocument xmlDoc = new XmlDocument();

            xmlDoc.LoadXml(xmlStr);

            /*
            {
                "element":{
                    "@nme":"ABC",
	　　            "element":[
                              {
                              "@name":"XYZ",
			　                "data":[
                                { "@m":"0","#text":"AAA"},
				                { "@m":"1","#text":"AAA"},
				                { "@m":"2","#text":"AAA"}
                                ]
			                },
			                {
                            "@name":"XYZ",
			　               "data":[
                                { "@m":"0","#text":"AAA"},
				                { "@m":"1","#text":"AAA"},
				                { "@m":"2","#text":"AAA"}
                                ]
			                },
			                {
                            "@name":"XYZ",
			　               "data":[
                                { "@m":"0","#text":"AAA"},
				                { "@m":"1","#text":"AAA"},
				                { "@m":"2","#text":"AAA"}
                                ]
		            	    }
		　　　         ]
	                }
            }
*/

            string JsonStr1 = JsonConvert.SerializeXmlNode(xmlDoc);                  // xmlDoc => Json文字列  {"element":{"@id":"123","#text":"aaa"}}

            string JsonStr = "";
            JsonStr += "{'root':{element:";
            JsonStr += "[";
            JsonStr += "{'@name':'top1','elem1':[]},";
            JsonStr += "{'@name':'top2','elem1':[]}";
            JsonStr += "]";
            JsonStr += "}}";

            XmlDocument xmlDoc1 = JsonConvert.DeserializeXmlNode(JsonStr);          // Json文字列 => xmlDoc



        }

        Dictionary<string, object> zzz9()
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            XmlDocument doc = new XmlDocument();
            string url = "http://localhost/Project/費用予測/xml/EMG費用状況_JSON.asp?year=2021";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url);

            object Json = JsonConvert.DeserializeObject(JsonStr);           // 文字列をJson形式に

            Dictionary<string, object> root = new Dictionary<string, object>();


            root.Add("root", Json);

            return (root);
        }

        Dictionary<string, object> zzz()
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            XmlDocument doc = new XmlDocument();
            string url = "http://localhost/Project/費用予測/xml/EMG費用状況_JSON.asp?year=2021";
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

                        for (var m = 0; m < m3.Value.Count(); m++)
                        {
                            Debug.Write("value", m.ToString(), m3.Value[m].ToString());
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
        void xxx()
        {
            Dictionary<string, section> xxxTab = new Dictionary<string, section>();
            //List<Info> Info2 = new List<Info>(12);

            Info Info = new Info();
            member men = new member();
            men.月 = new List<Info>() { Info,Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, };


            section sec = new section();
            sec.名前 = "開発";
            sec.member = new Dictionary<string, member>();
            sec.member.Add("451862", men);
            sec.member["451862"].名前 = "中村";
            sec.member["451862"].月[0].休職 = "222";

            sec.member.Add("123456", men);
            sec.member["123456"].名前 = "山田";
            sec.member["123456"].月[0].休職 = "999";




            xxxTab.Add("グループコード", sec);

            //xxxTab[グループコード]["123456"].月[0].休職;
            var a = 1;


        }
        public class Info
        {
            public string 役職ID { get; set; }
            public string 役職 { get; set; }
            public string 社員区分 { get; set; }
            public string 社籍 { get; set; }
            public string 休職 { get; set; }
        }
        public class member
        {
            public string 名前 { get; set; }
            public List<Info> 月 { get; set; }
        }
        public class section
        {
            public string 名前 { get; set; }
            public int 直間 { get; set; }
            public Dictionary<string, member> member { get; set; }
        }
    }
}
