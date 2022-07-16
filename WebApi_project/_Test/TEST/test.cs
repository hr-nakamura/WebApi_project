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
            //{
                WebClient client = new WebClient();
                NameValueCollection collection = new NameValueCollection();
                NameValueCollection myCol = new NameValueCollection();
                collection.Add("red", "rojo");
                //collection.Add( "green", "verde" );
                string url = "http://localhost/WebApi/project/__menu/debug/test.html";
                byte[] resBytes = client.UploadValues(url, collection);
                client.Dispose();

            }catch(Exception ex)
            {
                var x = ex.Message;
            }
            return (xmlDoc);

        }

    }
}

