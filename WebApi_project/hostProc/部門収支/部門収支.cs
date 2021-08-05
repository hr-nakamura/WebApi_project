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
		public object json_部門収支_XML(String Json)
		{

			Dictionary<string, dynamic> Tab = new Dictionary<string, dynamic>();


			Json = "{year:'2021', mCnt:4, secMode:'開発',dispMode:'統括'}";
            var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

            int mCnt = o_json.mCnt;
            int year = o_json.year;
            int s_yymm = ((year - 1) * 100 + 10);
            int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			o_json.s_yymm = s_yymm;

			Tab.Add("Info", o_json);
			Tab.Add("data", initTab(Json));


			List<db_account> groupPlan = (List<db_account>)json_groupPlan(Json,Tab["data"]);

            return (Tab);
		}
		public object json_groupPlan(string Json, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";
			var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

			List<string> SQLTab = new List<string>();
			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = o_json.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.Write("DB Open", DB_connectString);


			foreach (var item in Tab)
			{
				string S_name = item.Key;
				Dictionary<string, object> Tab2 = (Dictionary<string, object>)Tab[S_name];
				string codes = (string)Tab2["部署コード"];
				string mode = (string)Tab2["直間"];


				StringBuilder sql = new StringBuilder("");

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
				if (codes.Length > 0)
				{
					sql.Append("    AND");
					sql.Append("    MAST.部署コード IN(@codes)");
				}
				if (mode != "")
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
				sql.Replace("@codes", SqlUtil.Parameter("number", codes));
				sql.Replace("@mode", SqlUtil.Parameter("number", mode));

				work = sql.ToString();
				SQLTab.Add(work);
			}

			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlDataReader reader = dbRead(DB, SQL);
			Debug.Write("reader Start");
			string 名前, 大項目, 項目, 種別;
			int yymm, n, amount;

			int Cnt = 0;
			while (reader.Read())
			{
				名前 = (string)reader["S_name"].ToString();
				大項目 = (string)reader["大項目"].ToString();
				項目 = (string)reader["項目"].ToString();
				種別 = (string)reader["種別"].ToString();
				yymm = (int)reader["yymm"];
				amount = (int)reader["amount"];


				n = yymmDiff(s_yymm, yymm);

				checkArray(Tab, 名前, 種別, 大項目, 項目);
				Tab[名前][種別][大項目][項目][n] += amount;

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

		public object json_uriageYosoku(string Json, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";
			var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

			List<string> SQLTab = new List<string>();
			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = o_json.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.Write("DB Open", DB_connectString);


			foreach (var item in Tab)
			{
				string S_name = item.Key;
				Dictionary<string, object> Tab2 = (Dictionary<string, object>)Tab[S_name];
				string codes = (string)Tab2["部署コード"];
				string mode = (string)Tab2["直間"];


				StringBuilder sql = new StringBuilder("");

				sql.Append(" SELECT");

				sql.Append("      S_name = @S_name,");
				sql.Append("      直間   = MAST.直間,");

				sql.Append("	  level  = PNUM.fix_level,");
				sql.Append("	  yymm   = DATA.yymm,");
				sql.Append("	  amount = sum(DATA.sales) * 1000");
				sql.Append(" FROM");
				sql.Append("	  営業予測データ DATA ");
				sql.Append("                     LEFT JOIN 業務部署データ BUSYO");
				sql.Append("                          ON DATA.pNum       = BUSYO.pNum");
				sql.Append("	                 LEFT JOIN projectNum     PNUM");
				sql.Append("                          ON DATA.pNum       = PNUM.pNum");
				sql.Append("                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) )  MAST");
				sql.Append("                          ON MAST.部署コード = BUSYO.部署ID");

				sql.Append(" WHERE");
				sql.Append("	  PNUM.stat IN(0,1,4,5)");
				sql.Append("      and");
				sql.Append("      PNUM.fix_level >= 10");
				sql.Append("	  AND");
				sql.Append("	  (DATA.yymm Between BUSYO.開始 And BUSYO.終了)");
				sql.Append("	  AND");
				sql.Append("      (DATA.yymm BETWEEN @s_yymm and @e_yymm)");

				if (codes.Length > 0)
				{
					sql.Append("    AND");
					sql.Append("    BUSYO.部署ID IN(@codes)");
				}
				if (mode != "")
				{
					sql.Append("    AND");
					sql.Append("    MAST.直間 IN(@mode)");
				}

				sql.Append(" GROUP BY");
				sql.Append("      MAST.直間,");
				sql.Append("      PNUM.fix_level,");
				sql.Append("      DATA.yymm");

				sql.Replace("@S_name", SqlUtil.Parameter("string", S_name));
				sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
				sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
				sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
				sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
				sql.Replace("@codes", SqlUtil.Parameter("number", codes));
				sql.Replace("@mode", SqlUtil.Parameter("number", mode));

				work = sql.ToString();
				SQLTab.Add(work);
			}

			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlDataReader reader = dbRead(DB, SQL);
			Debug.Write("reader Start");
			string 名前, 大項目, 項目, 種別;
			int yymm, n, amount;

			int Cnt = 0;
			while (reader.Read())
			{
				名前 = (string)reader["S_name"].ToString();
				大項目 = (string)reader["大項目"].ToString();
				項目 = (string)reader["項目"].ToString();
				種別 = (string)reader["種別"].ToString();
				yymm = (int)reader["yymm"];
				amount = (int)reader["amount"];


				n = yymmDiff(s_yymm, yymm);

				checkArray(Tab, 名前, 種別, 大項目, 項目);
				Tab[名前][種別][大項目][項目][n] += amount;

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

		/*
		// 売上予測データ取得
function uriageYosoku(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)
	{
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;


	var RS = Server.CreateObject("ADODB.Recordset")


//	予測データ
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "	  level  = PNUM.fix_level,"
		SQL += "	  yymm   = DATA.yymm,"
		SQL += "	  amount = sum(DATA.sales) * 1000"
		SQL += " FROM"
		SQL += "	  営業予測データ DATA "
		SQL += "                     LEFT JOIN 業務部署データ BUSYO"
		SQL += "                          ON DATA.pNum       = BUSYO.pNum"
		SQL += "	                 LEFT JOIN projectNum     PNUM"
		SQL += "                          ON DATA.pNum       = PNUM.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate + "') )  MAST"
		SQL += "                          ON MAST.部署コード = BUSYO.部署ID"

		SQL += " WHERE"
		SQL += "	  PNUM.stat IN(0,1,4,5)"
		SQL += "      and"
		SQL += "      PNUM.fix_level >= 10"
		SQL += "	  AND"
		SQL += "	  (DATA.yymm Between BUSYO.開始 And BUSYO.終了)"
		SQL += "	  AND"
		SQL += "      (DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm + ")"

		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    BUSYO.部署ID IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "      PNUM.fix_level,"
		SQL += "      DATA.yymm"

		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,Grp,c_yymm,mode
	var secName
	while(!RS.EOF){
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		level   = parseInt(RS.Fields('level').Value)
		c_yymm  = RS.Fields('yymm').Value
		amount  = RS.Fields('amount').Value

		if( S_name == null ){
			errorMsg("uriageYosoku")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		if( level >= 70 ) Tab[secName]["予測"]["売上予測"]["確度70"][n] += amount
		if( level >= 50 ) Tab[secName]["予測"]["売上予測"]["確度50"][n] += amount
		if( level >= 30 ) Tab[secName]["予測"]["売上予測"]["確度30"][n] += amount
		if( level >= 10 ) Tab[secName]["予測"]["売上予測"]["確度10"][n] += amount
		RS.MoveNext()
		}
	RS.Close()

	for( var secName in Tab ){
		for( var m = 0; m < mCnt; m++ ){
			Tab[secName]["予測"]["売上高"]["売上"][m] = Tab[secName]["予測"]["売上予測"]["確度" + fixLevel][m]
			}
		}
	}


		
		*/
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
		Dictionary<string, dynamic> checkArray(Dictionary<string, dynamic> Tab, string 部門, string 種別, string 大項目, string 項目)
		{
			Debug.Write("確認");
			try
			{
				if (Tab[部門][種別][大項目].ContainsKey(項目))
				{
					//Debug.Write("ある");
					return (Tab);
				}
			}
			catch (Exception ex)
			{
				//Debug.Write(ex.Message);
				if (!Tab.ContainsKey(部門))
				{
					Tab.Add(部門, new Dictionary<string, dynamic>());
				}
				if (!Tab[部門].ContainsKey(種別))
				{
					Tab[部門].Add(種別, new Dictionary<string, dynamic>());
				}
				if (!Tab[部門][種別].ContainsKey(大項目))
				{
					Tab[部門][種別].Add(大項目, new Dictionary<string, dynamic>());
				}
				if (!Tab[部門][種別][大項目].ContainsKey(項目))
				{
					Tab[部門][種別][大項目].Add(項目, new Dictionary<string, int[]>());
				}
			}
			//Debug.Write("設定");
			Tab[部門][種別][大項目][項目] = new int[12];
			var x = 1;
			return (Tab);
		}
		public Dictionary<string, object> costList(string 直間, string 統括, string 部門, string 課, string 部署コード)
		{

			Dictionary<string, object> Tab = new Dictionary<string, object>();
			string 種別 = (直間 == "2" ? "間接" : "直接");
			Tab.Add("種別", 種別);
			Tab.Add("直間", 直間);
			Tab.Add("部署名", new secInfo(統括, 部門, 課));
			Tab.Add("部署コード", 部署コード);
			Tab.Add("合計", new Dictionary<string, dynamic>());
			Tab.Add("計画", new Dictionary<string, dynamic>());
			Tab.Add("予測", new Dictionary<string, dynamic>());
			Tab.Add("実績", new Dictionary<string, dynamic>());
			Tab.Add("配賦", new Dictionary<string, dynamic>());

			return (Tab);
		}
		Dictionary<string, dynamic> initTab(String Json)
		{
			Dictionary<string, dynamic> Tab = new Dictionary<string, dynamic>();
			Dictionary<string, object> Info = new Dictionary<string, object>();
			Dictionary<string, object> Data = new Dictionary<string, object>();
			jsonProc jProc = new jsonProc();

			//Json = "{year:'2020',secMode:'開発',dispMode:'グループ'}";
			var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

			Dictionary<string, group> secTab = jProc.json_部門リスト(Json);

			if (o_json.dispMode == "全社")
			{
				Tab.Add("全社", costList(直間: "0,1,2", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.dispMode == "統括")
			{
				foreach (string 統括 in secTab.Keys)
				{
					group sec = secTab[統括];
					Tab.Add(統括, costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(統括, secTab[統括].codes);
				}
			}
			else if (o_json.dispMode == "部門")
			{
				group sec = secTab["開発本部"];

				foreach (string 部門 in sec.list.Keys)
				{
					var x = sec.list[部門];
					Tab.Add(部門, costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(部門, sec.list[部門].codes);
				}
			}
			else if (o_json.dispMode == "グループ")
			{
				group sec = secTab["開発本部"].list["第1開発部"];
				foreach (string 課 in sec.list.Keys)
				{
					var x = sec.list[課];
					Tab.Add(課, costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
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

