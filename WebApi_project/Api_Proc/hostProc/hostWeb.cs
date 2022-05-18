using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Net;
using System.Net.Http; // ←追加

using DebugHost;

namespace WebApi_project.hostProc
{
    public class hostWeb : System.Web.UI.Page
    {
        private static Encoding Encode = Encoding.GetEncoding("Shift_JIS");
        private const string SHIFT_JIS = "Shift_JIS";

        // リクエストタイムアウト秒数(630秒)
        private const int REQUEST_TIME_OUT = 90 * 1000;

        // サーバー通信エラー
        private static int NetErrorCount = 0;
        private const int MAX_SHOW_ERROR = 3;

        private static HttpClient client = new HttpClient();
        HttpContext context = HttpContext.Current;
        // コンストラクタ

        public hostWeb()
        {
		}


        public string GetRequest(string url)
        {
            return (GetRequest(url, "utf-8"));          // 指定がないときは「utf-8」
        }
        public string GetRequest(string url, string encode)
        {
            HttpWebRequest request = null;
            HttpWebResponse response = null;
            StreamReader streamReader = null;
            string returnBuff = null;
            Encoding Encode = Encoding.GetEncoding("Shift_JIS");
            if (encode != null)
            {
                Encode = System.Text.Encoding.GetEncoding(encode);
            }
            // Stopwatchクラス生成
            var sw = new System.Diagnostics.Stopwatch();

            try
            {
                // 計測開始
                sw.Start();
                
                // WebRequest作成
                request = (HttpWebRequest)WebRequest.Create(url);

                // タイムアウト設定
                request.Timeout = REQUEST_TIME_OUT;

                // メソッドにGETを指定
                request.Method = "GET";

                // サーバーからの応答を受信するためのWebResponseを取得
                response = (HttpWebResponse)request.GetResponse();
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    // 応答データを受信するためのStreamを取得
                    Stream responseStream = response.GetResponseStream();

                    // 応答データ受信用StreamReaderを取得
                    streamReader = new StreamReader(responseStream, Encode);

                    // 応答データ取得
                    returnBuff = streamReader.ReadToEnd();
                }
                else
                {
                    returnBuff = null;
                }
                if (NetErrorCount > MAX_SHOW_ERROR)
                {
                    MyDebug.Write(MyDebug.LOG_OK, "[ErrCount = " + NetErrorCount + "] ネットワーク回復 GetRequest(" + url + ")");
                }
                NetErrorCount = 0;
            }
            catch (OutOfMemoryException ex)
            {
                returnBuff = null;
                MyDebug.Write(MyDebug.LOG_NG, "[" + ex.Message + "] GetRequest(" + url + ")");
            }
            catch (Exception ex)
            {
                returnBuff = null;
                if (NetErrorCount++ < MAX_SHOW_ERROR)
                {
                    MyDebug.Write(MyDebug.LOG_NG, "[" + ex.Message + "] GetRequest(" + url + ")");
                    //returnBuff = "{"+ex.Message+"}";
                }
            }
            finally
            {
                if (streamReader != null)
                {
                    streamReader.Close();
                    streamReader = null;
                }
                if (response != null)
                {
                    response.Close();
                    response = null;
                }
                if (request != null)
                {
                    request.Abort();
                    request = null;
                }
            }
            // 計測停止
            sw.Stop();
            //結果出力
            MyDebug.Write($"処理時間 [" + sw.Elapsed + "] GetRequest(" + url + ")");

            return returnBuff;
        }


        // HTTPリクエスト(POST):XMLデータ
        public string PostRequest(string url, XmlDocument postDataXML)
        {
            HttpWebRequest request = null;
            HttpWebResponse response = null;
            Stream reqStream = null;
            StreamReader streamReader = null;
            string returnBuff = null;
            try
            {
                // POST用データをバイト型配列に変換
                byte[] postDataBytes = Encode.GetBytes(postDataXML.InnerXml);

                // WebRequest作成
                request = (HttpWebRequest)WebRequest.Create(url);

                // メソッドにPOSTを指定
                request.Method = "POST";

                // タイムアウト設定
                request.Timeout = REQUEST_TIME_OUT;

                // ContentTypeを"application/x-www-form-urlencoded"にする
                request.ContentType = "application/x-www-form-urlencoded";

                // POST送信するデータの長さを指定
                request.ContentLength = postDataBytes.Length;

                // データをPOST送信するためのStreamを取得
                reqStream = request.GetRequestStream();

                // 送信するデータを書き込む
                reqStream.Write(postDataBytes, 0, postDataBytes.Length);
                reqStream.Close();
                reqStream = null;

                // サーバーからの応答を受信するためのWebResponseを取得
                response = (HttpWebResponse)request.GetResponse();
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    // 応答データを受信するためのStreamを取得
                    Stream responseStream = response.GetResponseStream();

                    // 応答データ受信用StreamReaderを取得
                    streamReader = new StreamReader(responseStream, MyDebug.Encode);

                    // 応答データ取得
                    returnBuff = streamReader.ReadToEnd();
                }
                else
                {
                    returnBuff = null;
                }
            }
            catch (OutOfMemoryException ex)
            {
                returnBuff = null;
                MyDebug.Write(MyDebug.LOG_NG, "PostRequest(" + url + ", postDataXML)[" + ex.Message + "]");
            }
            catch (Exception ex)
            {
                MyDebug.Write(ex.Message);
                returnBuff = null;
            }
            finally
            {
                if (streamReader != null)
                {
                    streamReader.Close();
                    streamReader = null;
                }
                if (response != null)
                {
                    response.Close();
                    response = null;
                }
                if (reqStream != null)
                {
                    reqStream.Close();
                    reqStream = null;
                }
                if (request != null)
                {
                    request.Abort();
                    request = null;
                }
            }
            return returnBuff;
        }
        /// <summary>
        /// クライアントで作成されたxmlDocumentをxmlDocumentにロードしなおして戻す。
        /// </summary>
        ///
        private XmlDocument SeparateDoc(XmlDocument paraDoc)
        {
            XmlDocument xmlDocNew = new XmlDocument();
            if (paraDoc.SelectSingleNode("//document") != null)
            {
                XmlCDataSection cDataNode = (XmlCDataSection)(paraDoc.SelectSingleNode("//document").FirstChild);
                if (cDataNode != null)
                {
                    string cDataString = HttpUtility.UrlDecode(cDataNode.Data);                  // 文字コードを戻す
                    //string cDataString = Regex.Replace(work, "╋", "+");              // 「+」を誤変換するので「╋」にしたので戻す
                    xmlDocNew.LoadXml(cDataString);
                }
            }
            else
            {
                xmlDocNew = paraDoc;
            }

            return (xmlDocNew);
        }        //private async Task<string> sendRequest(string url, string json)
        //        private XmlDocument test(XmlDocument paraDoc)
        //        {
        //            Host host = new Host();
        //            XmlElement root = (XmlElement)paraDoc.SelectSingleNode("root");
        //            XmlElement optionNode = (XmlElement)root.SelectSingleNode("option");
        //            String url = optionNode.GetAttribute("url");


        //            string work = GetRequest(url);


        //            //string work = PostRequest(url,paraDoc);
        //            XmlDocument xmlDoc = new XmlDocument();
        //            //            xmlDoc = SeparateDoc(paraDoc);
        //            XmlElement rootNode = xmlDoc.CreateElement("root");
        //            XmlElement Node = xmlDoc.CreateElement("data");
        //            rootNode.AppendChild(Node);

        //            XmlCDataSection cData = xmlDoc.CreateCDataSection(work);
        ////            XmlText Text = xmlDoc.CreateTextNode(work);
        //            Node.AppendChild(cData);
        //            rootNode.AppendChild(Node);
        //            xmlDoc.AppendChild(rootNode);

        //            return (xmlDoc);
    }
}
