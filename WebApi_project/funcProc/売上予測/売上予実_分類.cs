using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測 : hostProc
    {
        public object json_売上予実_分類(String Json)
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


            string url = "http://kansa.in.eandm.co.jp/Project/売上予測/xml/売上予実_分類_JSON.asp?year=2021";
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url);

            Tab.Add("Info", (object)Info);
            Tab.Add("data", JObject.Parse(jsonStr));

            return (Tab);
        }
        public XmlDocument 売上予実_分類(String Json)
        {

            Dictionary<string, object> root = new Dictionary<string, object>();

            object o_json = json_売上予実_分類(Json);
            root.Add("root", (object)o_json);

            string JsonStr = JsonConvert.SerializeObject(root);

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(JsonStr);

            return (xmlDoc);

        }
    }
}

