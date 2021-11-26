using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Text;

using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class projectCostProc : hostProc
    {
        public object json_projectInfoList(String Json)
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Dictionary<string, object> Info = new Dictionary<string, object>();

            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Info.Add("mName", mName);
            Info.Add("className", className);
            Info.Add("methodName", methodName);
            Info.Add("DB_Conn", DB_connectString);

            string url = "";
            //url = "http://kansa.in.eandm.co.jp/Project/projectCostProc/json/projectInfoList_JSON.asp?pNum=20212329";
            url = "http://kansa.in.eandm.co.jp/Project/projectCostProc/json/projectInfoDetail_JSON.asp?pNum=20212329";
            //url = "http://localhost/Asp/projectCostProc/projectInfoList.json";
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url);

            return (JObject.Parse(jsonStr));
        }
        public XmlDocument projectInfoList(String Json)
        {
            object o_json = json_projectInfoList(Json);

            JObject O_Top = Jsonl_Info(o_json);
            JObject O_Inf = getStat();

            JObject Top = new JObject();
            Top.Add("Info", O_Inf);
            Top.Add("Data", O_Top);

            string JsonStr = JsonConvert.SerializeObject(Top);
            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(JsonStr, "root");

            return (xmlDoc);
        }
        public XmlDocument projectInfoList_xml(String Json)
        {
            XmlDocument xmlDoc = new XmlDocument();

            var url = "http://localhost/Asp/projectCostProc/projectInfoList.xml";
            url = "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp?pNum=20212329";
            xmlDoc.Load(url);
            return (xmlDoc);
        }
    }
}
