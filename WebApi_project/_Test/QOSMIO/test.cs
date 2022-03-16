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
//using System.Diagnostics;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    partial class QOSMIO : hostProc
    {
        public XmlDocument projectTest(String Json)
        {
            Debug.Write("projectTest");

            var Tab = json_projectTest("");

            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に
            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr, "root");       // Json文字列をXML　objectに

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.PrependChild(comment);
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        public object json_projectTest(String Json)
        {
            Debug.Write("json_projectTest");

            //            var Tab1 = readJson("http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp");
            JObject oJson = readJson("http://localhost/Asp/Test/test.json");
            string s_json = Newtonsoft.Json.JsonConvert.SerializeObject(oJson);       // jsonをjson文字列に変換

            ArrayConvert(ref oJson, "月", "m");

            return (oJson);
        }

    public void ArrayConvert(ref JObject oJ, string tagName, string atrName)
        {
            foreach (var x in (JObject)oJ)
            {
                var Key = x.Key;
                var Value = x.Value;
                if( Value.Type.ToString() == "Object")
                {
                    var target_Value = (JObject)oJ[Key];
                    ArrayConvert(ref target_Value, tagName, atrName);
                }
                else if(Value.Type.ToString() == "Array")
                {
                    oJ[Key] = (JObject)JsonArrayConvert(Value, tagName, atrName);
                }
                else
                {
                }
            }
        }
    private JObject JsonArrayConvert(object oJ, string tagName, string atrName)
        {
            List<string> work = new List<string>();
        int i = 0;
        foreach (var value in (JArray) oJ)
        {
            work.Add(" {'@"+ atrName + "':"+ i++.ToString()+",'#text':'"+ value.ToString()+"'}");
        }

        StringBuilder sb = new StringBuilder();
        sb.AppendLine("{");
        sb.AppendLine(" '"+ tagName + "': [");
        sb.AppendLine(String.Join(",",work));
        sb.AppendLine(" ]");
        sb.AppendLine("}");

        JObject Json = (JObject)JsonConvert.DeserializeObject(sb.ToString());
        return (Json);

    }
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




        JObject readJson(string url1)
        {
            //string url = "http://localhost/Asp/Test/test.json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url1);

            string path = @"E:\GitHub\hr-nakamura\WebApi_project\WebApi_project\_Test\QOSMIO\";
            //path = @"D:\GitHub\hr-nakamura\WebApi_project\WebApi_project\_Test\QOSMIO\";
            string url = path + "sales.json";
             //JsonStr = System.IO.File.ReadAllText(url);

            JObject Json = JObject.Parse(JsonStr);                              // 文字列をJson形式に
            //JObject Json = JsonConvert.DeserializeObject(JsonStr);

            return (Json);
        }

    }
}
