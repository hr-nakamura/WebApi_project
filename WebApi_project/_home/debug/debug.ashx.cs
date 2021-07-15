using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

namespace WebApi_project._home.debug
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
            LogData = Regex.Replace(LogData, "&lt;", "<");
            LogData = Regex.Replace(LogData, "&gt;", ">");
            string name= context.Request.Form["Name"];
            if( name == "debug")
            {
                DebugHost.Debug.Write(LogData);
            }
            else if( name == "log")
            {
                DebugHost.Debug.WriteLog(LogData);
            }
            else
            {
                DebugHost.Debug.WriteErr(LogData);
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