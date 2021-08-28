using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DebugHost;

namespace Project
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

            DebugHost.Debug.Note(LogData);
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