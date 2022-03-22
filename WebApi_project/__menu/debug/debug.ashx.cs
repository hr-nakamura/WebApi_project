using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

namespace WebApi_project.__menu.debug
{
    /// <summary>
    /// debug の概要の説明です
    /// </summary>
    public class Debug : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            string LogData = context.Request.Form["LogData"];
            if (LogData == null) return;
            LogData = Regex.Replace(LogData, "&lt;", "<");
            LogData = Regex.Replace(LogData, "&gt;", ">");
            string name= context.Request.Form["Name"];
            if( name == "debug")
            {
                DebugHost.MyDebug.Write(LogData);
            }
            else if (name == "note")
            {
                DebugHost.MyDebug.Note(LogData);
            }
            else if (name == "log")
            {
                DebugHost.MyDebug.WriteLog(LogData);
            }
            else
            {
                DebugHost.MyDebug.WriteErr(LogData);
            }
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