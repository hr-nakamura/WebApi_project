using System;
using System.Web;
using System.Collections.Generic;

namespace WebApi_project.Models
{
	public struct para_部門収支
	{
		public string secMode { get; set; }             // 直接・間接
		public string dispCmd { get; set; }             // EMG・統括一覧・部門一覧・課一覧・間接一覧・統括詳細・部門詳細・課詳細・統括配賦・部門配賦
		public string name { get; set; }                // 統括/部門/課
		public int year { get; set; }
		public int mCnt { get; set; }
		public int fixLevel { get; set; }


	}
	public struct cmd_部門収支
	{
		public string secMode { get; set; }
		public string dispMode { get; set; }
		public string listMode { get; set; }
		public bool haifuMode { get; set; }
		public string 統括 { get; set; }
		public string 部 { get; set; }
		public string 課 { get; set; }
		public int year { get; set; }
		public int mCnt { get; set; }
		public int actualCnt{ get; set;}
		public int yosokuCnt{ get; set;}
		public int s_yymm { get; set; }
		public int c_yymm { get; set; }
		public int fixLevel { get; set; }


	}
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
