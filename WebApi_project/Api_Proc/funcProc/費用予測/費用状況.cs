using System;
using System.Web;
using System.Xml;
using System.Reflection;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

using System.IO;
using System.Text.Json;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 費用予測 : hostProc
    {
        public object json_費用状況(String Json)
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Dictionary<string, object> Info = new Dictionary<string, object>();

            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            //Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Info.Add("mName", mName);
            Info.Add("className", className);
            Info.Add("methodName", methodName);
            Info.Add("DB_Conn", DB_connectString);


            string url = "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp?year=2021";

            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url);

            return (JObject.Parse(jsonStr));
        }
        public XmlDocument 費用状況(String Json)
        {
            var o_json = json_費用状況(Json);
            JObject O_Top = Jsonl_Info(o_json);
            //XmlDocument doc = JsonSerializer.Serialize(o_json, new JsonSerializerOptions { WriteIndented = true });
            JObject O_Inf = getStat();

            JObject Top = new JObject();
            Top.Add("Info", O_Inf);
            Top.Add("Data", O_Top);

            string jsonStr = JsonConvert.SerializeObject(Top);             // Json形式を文字列に
            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr, "root");       // Json文字列をXML　objectに

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            var comment = xmlDoc.CreateComment("json data");
            xmlDoc.PrependChild(comment);
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
        class SampleData
        {
            public string a { get; set; }
            public string b { get; set; }
        }
    }
}