using System;
using System.Diagnostics;
using System.IO;
using System.IO.Pipes;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Xml;

namespace WebApi_project.__menu.debug
{
    public class fileOutX  
    {
        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        private static extern IntPtr FindWindowEx(IntPtr hWnd, IntPtr hwndChildAfter, String lpszClass, String lpszWindow);
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern bool PostMessage(IntPtr hWnd, Int32 Msg, IntPtr wParam, IntPtr lParam);
        private const int WM_CHAR = 0x102;
        [DllImport("User32.dll")]
        private static extern int SendMessage(IntPtr hWnd, int uMsg, int wParam, string lParam);

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
    }
}
