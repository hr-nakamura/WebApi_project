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
using WebApi_project.Models;
using System.Web.Script.Serialization;
using DebugHost;

namespace WebApi_project.hostProc
{
    partial class projectInfo : hostProc 
    {
        public XmlDocument projectTest(String opt_Json)
        {
            MyDebug.Write("projectTest");

            var para = new JsonOption.projectPara();
            var str_para = JsonConvert.SerializeObject(para);
            var o_para = JObject.Parse(str_para);
            var o_src = JObject.Parse(opt_Json);
            var option = JsonMerge(o_para, o_src);
            string str_Json = JsonConvert.SerializeObject(option);
            
            var oJson = (JObject)json_projectTest(str_Json);

            XmlDocument xmlDoc = JsonToXml(oJson);

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, makeOption(str_Json));
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }

        public JObject json_projectTest(String opt_Json)
        {
            MyDebug.Write("json_projectTest");

            var option = JObject.Parse(opt_Json);

            string xxx = makeOption(option, "?");
            MyDebug.Write(xxx);


            //JObject oJson = readJson("http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" + makeOption(option, "?"), "Shift_JIS");
            JObject oJson = readJson("http://localhost/Asp/Test/test1.json", "utf-8");
            //string s_json = Newtonsoft.Json.JsonConvert.SerializeObject(oJson);       // jsonをjson文字列に変換


            JsonArrayConvert(ref oJson, "月", "m");


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
