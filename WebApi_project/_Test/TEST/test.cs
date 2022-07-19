using System;
using System.Xml;
using System.Net;
using System.Collections;
using System.Collections.Specialized;



namespace WebApi_project.hostProc
{
    partial class History
    {
        public XmlDocument projectHistoryXX(String Json)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {
                string url = "http://localhost/Project/Test/a.html";
                //string url = @"/WebApi/project/__menu/debug/test.html";
                HttpWebRequest myHttpWebRequest = (HttpWebRequest)WebRequest.Create(url);
                HttpWebResponse myHttpWebResponse = (HttpWebResponse)myHttpWebRequest.GetResponse();
                myHttpWebResponse.Close();

            }
            catch(Exception ex)
            {
                var x = ex.Message;
            }
            return (xmlDoc);

        }

    }
}

