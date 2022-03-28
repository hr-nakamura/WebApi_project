using System;
using System.Web;
using System.Xml;
using System.Reflection;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Xml.Linq;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using System.Text.Json;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    partial class _Test_Json : hostProc
    {
        //Dictionary<string, Dictionary<string, string>> funcTab = new Dictionary<string, Dictionary<string, string>>() {
        //    { "ABC",new Dictionary<string, string>(){
        //        { "mode", "xml" },
        //        { "url", "/Project/aaa/abc.asp" },
        //        { "option", "{year:2022,mCnt:1}" }
        //    } },
        //    { "XYZ",new Dictionary<string, string>(){
        //        { "mode", "json" },
        //        { "url", "/Project/aaa/abc.asp" },
        //        { "option", "{year:2021,mCnt:5}" }
        //    } }
        //};
        public XmlDocument projectTest2(String Json)
        {
            MyDebug.Write("projectTest2");

            var Tab = EntryList();



            string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に

            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr,"root");       // Json文字列をXML　objectに

            //XmlDocument xmlDoc = new XmlDocument();
            return (xmlDoc);
        }
        public JObject json_projectTest2(String Json)
        {
            MyDebug.Write("json_projectTest2");
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

            string json = System.Text.Json.JsonSerializer.Serialize(Tab);
            var jobj1 = JObject.Parse(json);

            //var json2 = "{\"key1\":\"value1\",\"key2\":\"value2\",\"array1\":[{\"childkey1\":\"childvalue1\"},{\"childkey2\":\"childvalue2\"}]}";
            //var jobj2 = JObject.Parse(json2);

            //var dictionary = new Dictionary<string, string>();
            //foreach (var item in jobj2)
            //{
            //    MyDebug.Write(item.Key, item.Value.ToString());
            //    if (item.Value.Type == JTokenType.String)
            //    {
            //        dictionary.Add(item.Key, item.Value.ToString());
            //    }
            //}

            // ToDictionary()を使えば1行で書けます
            //var dictionary = jobj2.Properties()
            //                .Where(jp => jp.Value.Type == JTokenType.String)
            //                .ToDictionary(jp => jp.Name, jp => jp.Value.ToString());


            return (jobj1);


        }
    }
}
