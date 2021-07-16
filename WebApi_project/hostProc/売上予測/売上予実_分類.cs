using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測
    {
        public object 売上予実_分類_json(String Json)
        {
            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            Tab.Add("mName", mName);
            Tab.Add("className", className);
            Tab.Add("methodName", methodName);
            Tab.Add("DB_Conn", DB_connectString);

            return (Tab);
        }
        public XmlDocument 売上予実_分類(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            //XmlDocument xmlDoc = makeXmlDoc(para);
            XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }
    }
}

