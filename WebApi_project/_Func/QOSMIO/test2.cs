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

        public object json_projectTest2(String Json)
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

            var Tab1 = readJson2();
            return (Tab1);


        }

        public XmlDocument projectTest2(String Json)
        {
            Debug.Write("projectTest2");

            var Tab = json_projectTest2("");

            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr);       // Json文字列をXML　objectに

            return (xmlDoc);
        }



    }
}
