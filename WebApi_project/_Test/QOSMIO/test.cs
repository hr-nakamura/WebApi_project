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

            //JObject O_Top = Jsonl_Info(Tab);            // hostProc

            //JObject O_Inf = getStat();

            //JObject Top = new JObject();
            //Top.Add("Info", O_Inf);
            //Top.Add("Data", O_Top);


            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に
            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr, "root");       // Json文字列をXML　objectに

            ////XmlDocument xmlDoc = new XmlDocument();
            ////var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            ////XmlElement root = xmlDoc.CreateElement("root");

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.PrependChild(comment);
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
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
            Tab.Add("LogPath", LogPath);
            Tab.Add("Debugger", (System.Diagnostics.Debugger.IsAttached ? "YES" : "NO"));

            //            var Tab1 = readJson("http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp");
            object Tab1 = readJson("http://localhost/Asp/Test/test.json");



            string js = LoadJsonText(Tab1);
            string s_json = Newtonsoft.Json.JsonConvert.SerializeObject(js);       // jsonをjson文字列に変換

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(js, "root");       // Json文字列をXML　objectに
            XmlDocument doc = Newtonsoft.Json.JsonConvert.DeserializeXmlNode(js, "root");     // json文字列をxmlへ変換

            object jj = JsonConvert.DeserializeObject(js);


            return (jj);


        }

    private string LoadJsonText(object oJ)
    {
    foreach(var xx1 in (JObject)oJ)
            {
                foreach (var xx2 in xx1.Key)
                {
                    var aa = 1;
                }
            }

        StringBuilder sb = new StringBuilder();
        sb.AppendLine("{");
        sb.AppendLine(" 'yymm': [");
        for( var i = 0; i < 12; i++)
        {
            sb.AppendLine(" {'@yymm':111,'#text':'123456'},");
            sb.AppendLine(" {'@yymm':222,'#text':'123456'},");
            sb.AppendLine(" {'@yymm':333,'#text':'123456'}");
        }
        sb.AppendLine(" ]");
        sb.AppendLine("}");

        return sb.ToString();

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




        object readJson(string url1)
        {
            //string url = "http://localhost/Asp/Test/test.json";
            hostWeb h = new hostWeb();
            string JsonStr = h.GetRequest(url1);

            //object x = JObject.Parse(JsonStr);                              // 文字列をJson形式に
            object Json = JsonConvert.DeserializeObject(JsonStr);

            return (Json);
        }

    }
}
