using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

using WebApi_project.hostProc;
using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測 : hostProc
    {
        public JObject json_売上予実_部門(String opt_Json)
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

            var option = JObject.Parse(opt_Json);
            
            string url = "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" + makeOption(option,"?");
            hostWeb h = new hostWeb();
            string jsonStr = h.GetRequest(url, "Shift_JIS");
            JObject oJson = JObject.Parse(jsonStr);
            ArrayConvert(ref oJson, "月", "m");

            return (oJson);
        }
        public XmlDocument 売上予実_部門(String opt_Json)
        {
            var para = new JsonOption.projectPara();
            para.actual = 5;
            var str_para = JsonConvert.SerializeObject(para);
            var o_para = JObject.Parse(str_para);
            var o_src = JObject.Parse(opt_Json);
            var option = JsonMarge(o_para, o_src);
            
            string str_Json = JsonConvert.SerializeObject(option);

            var oJson = (JObject)json_売上予実_部門(str_Json);

            XmlDocument xmlDoc = JsonToXml(oJson);

            XmlDeclaration declaration = xmlDoc.CreateXmlDeclaration("1.0", "Shift_JIS", null);
            AddComment(xmlDoc, str_Json);
            xmlDoc.PrependChild(declaration);

            return (xmlDoc);
        }
    }
}

