using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Web;
using System.Web.SessionState;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Runtime.InteropServices;

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
                if (debugMode != true) return;
                HttpContext context = HttpContext.Current;

                string work = "◆ ";
                string para = "" + string.Join("\t", args) + "";
                StackFrame callerFrame = new StackFrame(1);
                string methodName = callerFrame.GetMethod().Name;
                string name_space = callerFrame.GetMethod().ReflectedType.FullName;
                string className = callerFrame.GetMethod().ReflectedType.Name;
                work += name_space + "::" + methodName + "(...)]\t[]" + para;
                Debug.Write_Notepad(work);
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
                if (debugMode != true) return;
                HttpContext context = HttpContext.Current;

                string work = "■ ";
                string para = "" + string.Join("\t", args) + "";
                StackFrame callerFrame = new StackFrame(1);
                string methodName = callerFrame.GetMethod().Name;
                string name_space = callerFrame.GetMethod().ReflectedType.FullName;
                string className = callerFrame.GetMethod().ReflectedType.Name;
                work += name_space + "::" + methodName + "(...)]\t[]" + para;
                Debug.Write_Notepad(work);
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        public static void Write(params string[] args)
        {
            try
            {

                if (debugMode != true) return;
                HttpContext context = HttpContext.Current;

                string work = "〓 ";
                string para = "" + string.Join("\t", args) + "";
                StackFrame callerFrame = new StackFrame(1);
                string methodName = callerFrame.GetMethod().Name;
                string name_space = callerFrame.GetMethod().ReflectedType.FullName;
                string className = callerFrame.GetMethod().ReflectedType.Name;
                work += name_space + "::" + methodName + "(...)]\t[]" + para;
                Debug.Note(work);
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }
        public static void Note(params string[] args)

        {
            string para = "" + string.Join("\t", args) + "";
            Debug.Write_Notepad(para);
        }

        public static void Plain(string str)
        {
            Debug.Write_Notepad(str);
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
            if (debugMode != true) return;
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
        private static void Write_Notepad_OLD(string str)
        {
            IntPtr wParam;

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

            byte[] b1 = Encoding.GetEncoding("utf-16").GetBytes(str);
            int iChar;
            for (int i = 0; i < b1.Length; i += 2)
            {
                iChar = BitConverter.ToInt16(b1, i);
                wParam = (IntPtr)iChar;
                PostMessage(lnghWndTarget, WM_CHAR, wParam, IntPtr.Zero);

            }
            wParam = (IntPtr)0x0d;
            PostMessage(lnghWndTarget, WM_CHAR, wParam, IntPtr.Zero);

        }
    }
}
