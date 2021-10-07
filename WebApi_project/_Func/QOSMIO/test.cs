using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Linq;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class QOSMIO : hostProc
    {
        int yymmAdd(int yymm, int mCnt)
        {
            int yy = yymm / 100;
            int mm = yymm % 100;

            int ym = (yy * 12) + mm;
            ym += mCnt;
            yy = ym / 12;
            mm = ym % 12;
            if (mm == 0) { yy--; mm = 12; }
            return ((yy * 100) + mm);
        }
        int yymmDiff(int base_yymm, int yymm)
        {
            int b_yy = base_yymm / 100;
            int b_mm = base_yymm % 100;
            int yy = yymm / 100;
            int mm = yymm % 100;

            mm += (yy - b_yy) * 12;
            int n = (mm - b_mm);
            return (n);
        }



        public object json_projectTest(String Json)
        {
            Debug.Write("json_projectTest");
            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            //Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            Tab.Add("mName", mName);
            Tab.Add("className", className);
            Tab.Add("methodName", methodName);
            Tab.Add("DB_Conn", DB_connectString);

            xxx();

            return (Tab);
        }

        public XmlDocument projectTest(String Json)
        {
            Debug.Write("projectTest");


            XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }
        void xxx()
        {
            Dictionary<string, section> xxxTab = new Dictionary<string, section>();
            //List<Info> Info2 = new List<Info>(12);

            Info Info = new Info();
            member men = new member();
            men.月 = new List<Info>() { Info,Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, Info, };


            section sec = new section();
            sec.名前 = "開発";
            sec.member = new Dictionary<string, member>();
            sec.member.Add("451862", men);
            sec.member["451862"].名前 = "中村";
            sec.member["451862"].月[0].休職 = "222";

            sec.member.Add("123456", men);
            sec.member["123456"].名前 = "山田";
            sec.member["123456"].月[0].休職 = "999";




            xxxTab.Add("グループコード", sec);

            //xxxTab[グループコード]["123456"].月[0].休職;
            var a = 1;


        }
        public class Info
        {
            public string 役職ID { get; set; }
            public string 役職 { get; set; }
            public string 社員区分 { get; set; }
            public string 社籍 { get; set; }
            public string 休職 { get; set; }
        }
        public class member
        {
            public string 名前 { get; set; }
            public List<Info> 月 { get; set; }
        }
        public class section
        {
            public string 名前 { get; set; }
            public int 直間 { get; set; }
            public Dictionary<string, member> member { get; set; }
        }
    }
}
