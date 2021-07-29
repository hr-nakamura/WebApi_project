using System;
using System.Web;
using System.Collections.Generic;

namespace WebApi_project.Models
{
    public class group
    {
        public string 直間 { get; set; }
        public string 名前 { get; set; }
        public string code { get; set; }
        public string codes { get; set; }
        public string 統括 { get; set; }
        public string 部門 { get; set; }
        public string 課 { get; set; }
        public Dictionary<string, group> list { get; set; }
        public group()
        {
            this.list = new Dictionary<string, group>();
        }
    }
}
