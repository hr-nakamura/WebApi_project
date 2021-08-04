using System;
using System.Web;
using System.Xml;
using System.Text;
using System.Reflection;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;

using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class 部門収支 : hostProc
    {
	public Dictionary <string,object> costList2(string 直間, string 統括, string 部門, string 課, string 部署コード)
        {

			Dictionary<string, object> Tab = new Dictionary<string, object>();
            string 種別 = (直間 == "2" ? "間接" : "直接");
			Tab.Add("種別", 種別);
			Tab.Add("直間", 直間);
			Tab.Add("部署名", new secInfo( 統括,  部門,  課));
			Tab.Add("部署コード", 部署コード);
			Tab.Add("合計", new accountInfo());
			Tab.Add("計画", new accountInfo());
			Tab.Add("予測", new accountInfo());
			Tab.Add("実績", new accountInfo());
			Tab.Add("配賦", new accountInfo());

			return (Tab);
        }
		Dictionary<string, object> initTab(String Json)
        {
			Dictionary<string, object> Tab = new Dictionary<string, object>();
			Dictionary<string, object> Info = new Dictionary<string, object>();
			Dictionary<string, object> Data = new Dictionary<string, object>();
			jsonProc jProc = new jsonProc();

			//Json = "{year:'2020',secMode:'開発',dispMode:'グループ'}";
			var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

			Dictionary<string, group> secTab = jProc.json_部門リスト(Json);

			if (o_json.dispMode == "全社")
			{
				Tab.Add("全社", costList2(直間: "0,1,2", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.dispMode == "統括")
			{
				foreach (string 統括 in secTab.Keys)
				{
					group sec = secTab[統括];
					Tab.Add(統括, costList2(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(統括, secTab[統括].codes);
				}
			}
			else if (o_json.dispMode == "部門")
			{
                group sec = secTab["開発本部"];

                foreach (string 部門 in sec.list.Keys)
                {
                    var x = sec.list[部門];
					Tab.Add(部門,  costList2(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(部門, sec.list[部門].codes);
                }
            }
			else if (o_json.dispMode == "グループ")
			{
                group sec = secTab["開発本部"].list["第1開発部"];
                foreach (string 課 in sec.list.Keys)
                {
                    var x = sec.list[課];
					Tab.Add(課,  costList2(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(課, sec.list[課].codes);
                }
            }
			return (Tab);
		}
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
		public object json_部門収支_XML(String Json)
		{


			Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";
			int s_yymm = 201810;
			Dictionary<string, object> Tab = (Dictionary<string, object>) initTab(Json);
			List<db_account> groupPlan = (List<db_account>)json_groupPlan(Tab);
			foreach(db_account item in groupPlan)
            {

				int n = yymmDiff(s_yymm, item.yymm);
				//Dictionary<string, Dictionary<string, Dictionary<string, Dictionary<string, int[]>>>> Tab = new Dictionary<string, Dictionary<string, Dictionary<string, Dictionary<string, int[]>>>>() ;
                //Tab[item.名前][item.種別][item.大項目][item.項目][n] = item.amount;

                //var x = 1;
            }
			groupPlan.ForEach(item =>
			{
				//Tab[item.名前]["計画"];
                //var x = 1;
			});
			return (Tab);
		}
		public object json_groupPlan(Dictionary<string, object> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";
			//var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

			string str_year = "2020";
			List<string> SQLTab = new List<string>();
			int mCnt = 3;
			int year = int.Parse(str_year);
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt-1);
			string s_sDate = String.Concat( (s_yymm / 100) , "/" , (s_yymm % 100) , "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, costList> Tab = initTab(Json);
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.Write("DB Open", DB_connectString);

			foreach (string S_name in Tab.Keys)
			{
				StringBuilder sql = new StringBuilder("");
//				Tab[S_name].部署コード;
				sql.Append(" SELECT");
				sql.Append("      S_name = @S_name,");
				sql.Append("      直間   = MAST.直間,");
				sql.Append("      大項目 = ITEM.大項目,");
				sql.Append("      項目   = ITEM.項目,");
				sql.Append("      種別   = (CASE WHEN DATA.種別 = 0 THEN '計画' ELSE '予測' END),");
				sql.Append("      yymm   = DATA.yymm,");
				sql.Append("      amount = Sum(DATA.数値)");
				sql.Append(" FROM");
				sql.Append("      収支計画データ DATA ");
				sql.Append("                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) ) MAST");
				sql.Append("                          ON DATA.部署ID = MAST.部署コード");
				sql.Append("                     LEFT JOIN 収支項目マスタ ITEM");
				sql.Append("                          ON DATA.項目ID = ITEM.ID");
				sql.Append(" WHERE");
				sql.Append("      ITEM.大項目 NOT IN('部門固定費','要員数')");
				sql.Append("      AND");
				sql.Append("      DATA.種別 IN(0,1)");              // 計画・予測
				sql.Append("      AND");
				sql.Append("      MAST.ACCコード >= 0");
				sql.Append("      AND");
				sql.Append("      DATA.yymm BETWEEN @s_yymm  AND @e_yymm");
                if (Tab[S_name].部署コード.Length > 0)
                {
                    sql.Append("    AND");
                    sql.Append("    MAST.部署コード IN(@codes)");
                }
                if (Tab[S_name].直間 != "")
                {
                    sql.Append("    AND");
                    sql.Append("    MAST.直間 IN(@mode)");
                }
                sql.Append(" GROUP BY");
				sql.Append("      MAST.直間,");
				sql.Append("      ITEM.大項目,");
				sql.Append("      ITEM.項目,");
				sql.Append("      DATA.種別,");
				sql.Append("      DATA.yymm");
				sql.Replace("@S_name", SqlUtil.Parameter("string", S_name));
				sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
				sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
				sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
				sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
				sql.Replace("@codes", SqlUtil.Parameter("number", Tab[S_name].部署コード));
				sql.Replace("@mode", SqlUtil.Parameter("number", Tab[S_name].直間));

				work = sql.ToString();
				SQLTab.Add(work);
			}

			string SQL = string.Join(" UNION ALL ", SQLTab);

            SqlDataReader reader = dbRead(DB, SQL);
            Debug.Write("reader Start");


			int Cnt = 0;
            while (reader.Read())
            {
				db_account data = new db_account()
				{
					名前 = (string)reader["S_name"].ToString(),
					大項目 = (string)reader["大項目"].ToString(),
					項目 = (string)reader["項目"].ToString(),
                    種別 = (string)reader["種別"].ToString(),
                    直間 = (byte)reader["直間"],
                    yymm = (int)reader["yymm"],
                    amount = (int)reader["amount"]
                };
				dataTab.Add(data);
			}
			Debug.Write(Cnt.ToString());
			Debug.Write("reader Close");
			reader.Close();

			Debug.Write("DB Close");
			DB.Close();
			Debug.Write("DB Dispose");
			DB.Dispose();

			return (dataTab);
        }
        public XmlDocument 部門収支_XML(String Json)
        {
			//var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

			List<db_account> json_data = (List<db_account>)json_部門収支_XML(Json);

            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }

		/*
            groupPlan(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)						// 計画・予測データ取得
            uriageYosoku(DB, Tab, yymm, mCnt, dispMode, dispName, listMode, fixLevel)			// 売上予測データ取得

            uriageActual(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)					// 売上実績データ取得

            accountActual(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)					// 費用実績データ取得

            accountCost(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)					// 費用付替

            salesCost(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)						// 売上付替

            if(dispMode != "全社" ){
                groupCost(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)					// 部門固定費データ取得

                }
            memberPlan(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)

            memberActual(DB, Tab, yymm, mCnt, dispMode, dispName, listMode)


            間接部門予算(Tab, mCnt)
        */
		class db_account
        {
            public string 名前 { get; set; }
			public int 直間 { get; set; }
			public string 大項目 { get; set; }
			public string 項目 { get; set; }
			public string 種別 { get; set; }
			public int yymm { get; set; }
			public int amount { get; set; }
		}
	}
}

//Debug.Write("=======");
//foreach (string 統括 in Tab.Keys)
//{
//    var x = Tab[統括];
//    costList cost = new costList(直間: x.直間, 統括: x.統括, 部門: x.部門, 課: x.課, 部署コード: x.codes);
//    Debug.Write(統括, Tab[統括].codes);
//}
//Debug.Write("=======");
//group Tab1 = Tab["開発本部"];

//foreach (string 部門 in Tab1.list.Keys)
//{
//    var x = Tab1.list[部門];
//    costList cost = new costList(直間: x.直間, 統括: x.統括, 部門: x.部門, 課: x.課, 部署コード: x.codes);
//    Debug.Write(部門, Tab1.list[部門].codes);
//}
//Debug.Write("=======");
//group Tab2 = Tab["開発本部"].list["第1開発部"];
//foreach (string 課 in Tab2.list.Keys)
//{
//    var x = Tab2.list[課];
//    costList cost = new costList(直間: x.直間, 統括: x.統括, 部門: x.部門, 課: x.課, 部署コード: x.codes);
//    Debug.Write(課, Tab2.list[課].codes);
//}
