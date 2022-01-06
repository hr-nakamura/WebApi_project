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

namespace WebApi_project.History
{
    partial class History : hostProc.hostProc
    {
        public XmlDocument projectTest(String Json)
        {
            Debug.Write("projectTest");

            //var Tab = historyInfo("");




            //string jsonStr = JsonConvert.SerializeObject(Tab);             // Json形式を文字列に
            //XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(jsonStr, "root");       // Json文字列をXML　objectに

            XmlDocument xmlDoc = new XmlDocument();
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

            var Tab1 = historyInfo("");

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
            Tab.Add("Debugger", (System.Diagnostics.Debugger.IsAttached ? "YES":"NO"));

            return (Tab);


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





        object historyInfo(string mailAddr)
        {
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);
            string url0, url1, url2, url3, asp, date, name;
            Dictionary<string, Dictionary<string,object>> Tab = new Dictionary<string, Dictionary<string, object>>();

            try
            {
                Debug.noWrite("DB Open", DB_connectString);
                DB.Open();

                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                sql.Append("    url0 = HIST.URL0,");
                sql.Append("    url1 = HIST.URL1,");
                sql.Append("    url2 = HIST.URL2,");
                sql.Append("    url3 = HIST.URL3,");
                sql.Append("    name = HIST.名前,");
                sql.Append("    asp = HIST.asp,");
                sql.Append("    date = HIST.日付");

                sql.Append(" FROM");
                sql.Append("    ページ参照履歴 HIST");
                sql.Append(" WHERE");
                sql.Append("    HIST.日付 >= @date");
                sql.Append(" ORDER BY");
                sql.Append("    date");

                sql.Replace("@date", hostProc.SqlUtil.Parameter("string", "2022-01-01"));

                SqlDataReader reader = dbRead(DB, sql.ToString());

                while (reader.Read())
                {

                    url0 = (string)reader["url0"].ToString();
                    url1 = (string)reader["url1"].ToString();
                    url2 = (string)reader["url2"].ToString();
                    url3 = (string)reader["url3"].ToString();
                    asp = (string)reader["asp"].ToString();
                    date = (string)reader["date"].ToString();
                    name = (string)reader["name"].ToString();
                    //Debug.Write(url0,url1,url2,url3,date,name);
                    if (!Tab.ContainsKey(url0))
                    {
                        Tab.Add(url0, new Dictionary<string, object>());
                    }
                    if (url1 != "" && !Tab[url0].ContainsKey(url1))
                    {
                        Tab[url0].Add(url1, new Dictionary<string, object>());
                    }
                    //if (url2 != "" && !Tab[url0][url1].ContainsKey(url2))
                    //{
                    //    Tab[url0][url1].Add(url2, new Dictionary<string, object>());
                    //}
                    //if (url3 != "" && !Tab[url0][url1][url2].ContainsKey(url3))
                    //{
                    //    Tab[url0][url1][url2].Add(url3, new Dictionary<string, object>());
                    //}

                }

                Debug.noWrite("reader Close");
                reader.Close();

                Debug.noWrite("DB Close");
                DB.Close();
                Debug.noWrite("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message);
            }
            finally
            {
                Debug.noWrite("DB null");
                DB = null;
            }
            return ("");
        }
        //class s_url
        //{
        //    public Dictionary<s_url,string> url { get; set; }
        //    public s_url()
        //    {
        //        this.url = new Dictionary<string,object>();
        //    }
        //}
    }
}
