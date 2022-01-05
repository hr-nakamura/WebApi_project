using System;
using System.Diagnostics;
using System.IO;
using System.IO.Pipes;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;

namespace DebugHost
{
    //public partial class Log : System.Web.UI.Page

    public class Debug 
    {
        // ステータス
        static Boolean debugMode = true;
        // 文字コード指定
        // ステータス
        public const string LOG_OK = "OK";
        public const string LOG_NG = "NG";
        public static Encoding Encode = Encoding.GetEncoding("Shift_JIS");


        public static void WriteErr(params string[] args)
        {
            // hostサイドの強制ログ
            try
            {
                HttpContext context = HttpContext.Current;

                string work = "◆ ";
                string para = "" + string.Join("\t", args) + "";
                StackFrame callerFrame = new StackFrame(1);
                string methodName = callerFrame.GetMethod().Name;
                string name_space = callerFrame.GetMethod().ReflectedType.FullName;
                string className = callerFrame.GetMethod().ReflectedType.Name;
                work += name_space + "::" + methodName + "(...)]\t[]" + para;

                string timeStatusStr = "[" + DateTime.Now.ToString("MM/dd HH:mm:ss.fff") + "]";
                string outStr = timeStatusStr + "\t" + work;
                Debug.Write_LogFile(outStr);
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }
        public static void WriteLog(params string[] args)
        {
            // hostサイドの強制ログ
            try
            {
                HttpContext context = HttpContext.Current;

                string work = "■ ";
                string para = "" + string.Join("\t", args) + "";
                StackFrame callerFrame = new StackFrame(1);
                string methodName = callerFrame.GetMethod().Name;
                string name_space = callerFrame.GetMethod().ReflectedType.FullName;
                string className = callerFrame.GetMethod().ReflectedType.Name;
                work += name_space + "::" + methodName + "(...)]\t[]" + para;

                string timeStatusStr = "[" + DateTime.Now.ToString("MM/dd HH:mm:ss.fff") + "]";
                string outStr = timeStatusStr + "\t" + work;

                Debug.Write_LogFile(outStr);
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        public static void noWrite(params string[] args)
        {
        }

        public static void Write(params string[] args)
        {
            try
            {

                if (debugMode == false) return;
                HttpContext context = HttpContext.Current;

                string work = "" + string.Join("\t", args) + "";

                string timeStatusStr = "[" + DateTime.Now.ToString("MM/dd HH:mm:ss.fff") + "]";
                string outStr = timeStatusStr + "\t" + work;

                Debug.Note(outStr);
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }
        public static void Note(params string[] args)
        {
            string para = "" + string.Join("\t", args) + "";
            Debug.Write_LogFile(para);
        }

        public static void Plain(string str)
        {
            Debug.Write_LogFile(str);
        }
        public static void Json(object Json)
        {
            Debug.Write_LogFile(Json.ToString());
        }
        public static void Write_LogFile(string str)
        {
            if (Debugger.IsAttached)
            {
                Debug.Write_Notepad(str);
            }
            else
            {
                string LogPath = System.Web.Hosting.HostingEnvironment.MapPath("/Log");
                Debug.WriteTextFile(LogPath, str);
            }

        }
        static void WriteTextFile(string LogPath, string str)
        {
            try
            {


                if (Directory.Exists(LogPath))
                {
                    LogPath += @"\debug.txt";
                    // テキストファイルのパス
                    // StreamWriterオブジェクトのインスタンスを生成
                    StreamWriter Writer = new StreamWriter(LogPath, true, Encoding.GetEncoding("Shift_JIS"));
                    // Writeメソッドで文字列データを書き込む
                    Writer.Write(str + "\n");
                    // StreamWriterオブジェクトを閉じる
                    Writer.Close();
                }
            }
            catch (Exception ex)
            {
                string a = ex.Message;
            }
        }
        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        private static extern IntPtr FindWindowEx(IntPtr hWnd, IntPtr hwndChildAfter, String lpszClass, String lpszWindow);
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern bool PostMessage(IntPtr hWnd, Int32 Msg, IntPtr wParam, IntPtr lParam);
        private const int WM_CHAR = 0x102;
        [DllImport("User32.dll")]
        private static extern int SendMessage(IntPtr hWnd, int uMsg, int wParam, string lParam);

        private static void Write_Notepad(string str)
        {

            if (debugMode == false) return;
            //IntPtr wParam;
            const int EM_REPLACESEL = 0x00C2;

            IntPtr lnghWnd = FindWindowEx(IntPtr.Zero, IntPtr.Zero, "Notepad", "*無題 - メモ帳");
            if (lnghWnd == IntPtr.Zero)
            {
                lnghWnd = FindWindowEx(IntPtr.Zero, IntPtr.Zero, "Notepad", "無題 - メモ帳");
                if (lnghWnd == IntPtr.Zero)
                {
                    return;
                }
            }
            IntPtr lnghWndTarget = FindWindowEx(lnghWnd, IntPtr.Zero, "Edit", "");           // '子ウィンドウのEdit

            SendMessage(lnghWndTarget, EM_REPLACESEL, 1, String.Concat(str, "\x0d"));
        }
    }
}
