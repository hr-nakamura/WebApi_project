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
using System.Collections;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    partial class History : hostProc
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

            return (Tab1);


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
            string url_0, url_1, url_2, url_3, asp, date, name;
            s_url Tab = new s_url();
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

                sql.Replace("@date", SqlUtil.Parameter("string", "2015-07-30"));

                SqlDataReader reader = dbRead(DB, sql.ToString());

                while (reader.Read())
                {
                    var myarray = new ArrayList() { };

                    url_0 = (string)reader["url0"].ToString();
                    url_1 = (string)reader["url1"].ToString();
                    url_2 = (string)reader["url2"].ToString();
                    url_3 = (string)reader["url3"].ToString();
                    asp = (string)reader["asp"].ToString();
                    date = (string)reader["date"].ToString();
                    name = (string)reader["name"].ToString();
                    //Debug.Write(url_0, url_1, url_2, url_3, asp,date, name);
                    if (!Tab.Url.ContainsKey(url_0))
                    {
                        Tab.Url.Add(url_0, new s_url());
                        Tab.Cnt += 1;

                    }
                    else
                    {
                        myarray.Add(asp);
                    }
                    if (url_1 != "" && !Tab.Url[url_0].Url.ContainsKey(url_1))
                    {
                        Tab.Url[url_0].Url.Add(url_1, new s_url());
                        Tab.Url[url_0].Cnt += 1;

                    }
                    else
                    {
                        myarray.Add(asp);
                    }
                    if (url_2 != "" && !Tab.Url[url_0].Url[url_1].Url.ContainsKey(url_2))
                    {
                        Tab.Url[url_0].Url[url_1].Url.Add(url_2, new s_url());
                        Tab.Url[url_0].Url[url_1].Cnt += 1;

                    }
                    else
                    {
                        myarray.Add(asp);

                    }
                    if (url_3 != "" && !Tab.Url[url_0].Url[url_1].Url[url_2].Url.ContainsKey(url_3))
                    {
                        Tab.Url[url_0].Url[url_1].Url[url_2].Url.Add(url_3, new s_url());
                        Tab.Url[url_0].Url[url_1].Url[url_2].Cnt += 1;
                    }
                    else
                    {
                        myarray.Add(asp);
                    }

                    //Debug.Write(url_0, url_1, url_2, url_3, asp);

                    //Tab.Url[url_0].Url[url_1].Url[url_2].Url[url_3].Cnt++;


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
            return (Tab);
        }

    }

    class s_url
    {
        public int Cnt { get; set; }
        // 許可情報
        public Dictionary<string ,s_url> Url { get; set; }
        public s_url()
        {
            this.Url = new Dictionary<string,s_url>();
        }
    }
    class s_asp
    {
        public int Cnt { get; set; }
        public List<string> Asp { get; set; }
    }
}

