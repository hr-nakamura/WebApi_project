using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi_project.__menu.debug
{
    /// <summary>
    /// fileOut1 の概要の説明です
    /// </summary>
    public class fileOut1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
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