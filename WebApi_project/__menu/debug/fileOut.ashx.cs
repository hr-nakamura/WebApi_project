using System;
using System.Diagnostics;
using System.IO;
using System.IO.Pipes;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Xml;
using System.Text.RegularExpressions;

namespace WebApi_project.__menu.debug
{
    /// <summary>
    /// fileOut1 の概要の説明です
    /// </summary>
    public class fileOut : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            string Str = context.Request.Form["Str"];
            if (Str == null) return;
            StringWriter myWriter = new StringWriter();
            Str = HttpUtility.UrlDecode(Str);
            string name = context.Request.Form["Name"];
            Write_Notepad(name,Str);
        }

        public void Write_Notepad(string fName, string str)
        {

            var x = IsXml(str) ? ".xml" : ".txt";
            Encoding Encode = Encoding.GetEncoding("Shift_JIS");
            string fileName = Path.GetFileNameWithoutExtension(fName);

            using (StreamWriter writer = new StreamWriter(@"D:\test\" + fileName + x, false, Encode))
            {
                writer.WriteLine(str);
            }



        }
        private bool IsXml(string xmlStr)
        {
            try
            {
                XmlDocument myDoc = new XmlDocument();
                myDoc.LoadXml(xmlStr);
            }
            catch (XmlException ex)
            {
                //take care of the exception
                return (false);
            }
            return (true);
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}