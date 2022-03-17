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
using System.Text.RegularExpressions;

using WebApi_project.hostProc;

using DebugHost;

namespace WebApi_project.hostProc
{
    partial class projectInfo : hostProc 
    {
        public XmlDocument projectTest(String Json)
        {
            Debug.Write("projectTest");

            var Tab = json_projectTest("");

            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            jsonStr = Regex.Replace(jsonStr, "・", "·");

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

            //JObject oJson = readJson("http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp", "Shift_JIS");
            JObject oJson = readJson("http://localhost/Asp/Test/test.json", "utf-8");
            //string s_json = Newtonsoft.Json.JsonConvert.SerializeObject(oJson);       // jsonをjson文字列に変換

            ArrayConvert(ref oJson, "月", "m");

            return (oJson);
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




        JObject readJson(string url1, string encode)
        {
            //string url = "http://localhost/Asp/Test/test.json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url1,encode);

            JObject Json = JObject.Parse(JsonStr);                              // 文字列をJson形式に

            //JObject Json = JsonConvert.DeserializeObject(JsonStr);

            return (Json);
        }

    }
}
