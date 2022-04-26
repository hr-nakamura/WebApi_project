using System;
using System.Diagnostics;
using System.IO;
using System.IO.Pipes;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
namespace WebApi_project.__menu.debug
{
    public class fileOut  
    {
        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        private static extern IntPtr FindWindowEx(IntPtr hWnd, IntPtr hwndChildAfter, String lpszClass, String lpszWindow);
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern bool PostMessage(IntPtr hWnd, Int32 Msg, IntPtr wParam, IntPtr lParam);
        private const int WM_CHAR = 0x102;
        [DllImport("User32.dll")]
        private static extern int SendMessage(IntPtr hWnd, int uMsg, int wParam, string lParam);

        public void Write_Notepad(string str)
        {
            var debugMode = true;
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
