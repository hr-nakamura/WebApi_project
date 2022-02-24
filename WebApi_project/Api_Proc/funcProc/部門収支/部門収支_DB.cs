using System;
using System.Web;
using System.Xml;
using System.Text;
using System.Reflection;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;

using WebApi_project.Models;

using DebugHost;


namespace WebApi_project.hostProc
{
	partial class 部門収支
	{
		public object json_groupPlan(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";
			string dispMode = cmd.dispMode;

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			string 大項目, 項目, 種別, S_name, secName;
			int yymm, n, 直間;
			double amount;
			StringBuilder sql = new StringBuilder("");
			List<string> SQLTab = new List<string>();
			foreach (var item in Tab)
			{
				S_name = item.Key;
				string codes = Tab[S_name]["部署コード"];
				string mode = Tab[S_name]["直間"];

				sql.Clear();
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

			if(SQLTab.Count > 0)
            {
				string SQL = string.Join(" UNION ALL ", SQLTab);

				SqlConnection DB = new SqlConnection(DB_connectString);
				DB.Open();
				Debug.noWrite("DB Open", DB_connectString);
				SqlDataReader reader = dbRead(DB, SQL);
				Debug.noWrite("reader Start");

				while (reader.Read())
				{
					S_name = (string)reader["S_name"].ToString();
					大項目 = (string)reader["大項目"].ToString();
					項目 = (string)reader["項目"].ToString();
					種別 = (string)reader["種別"].ToString();
					直間 = (byte)reader["直間"];
					yymm = (int)reader["yymm"];
					amount = Convert.ToDouble(reader["amount"]);

					n = yymmDiff(s_yymm, yymm);

					if (S_name == null)
					{
						secName = "不明";
					}
					else if (dispMode == "全社")
					{
						secName = "全社";
					}
					else if (dispMode == "本社")
					{
						secName = (直間 == 2 ? "本社" : "直接");
					}
					else
					{
						secName = S_name;
					}

					checkArray(Tab, secName, 種別, 大項目, 項目);

					if (大項目 == "売上付替" && 項目 == "支出") amount = -amount;
					if (大項目 == "費用付替" && 項目 == "支出") amount = -amount;
					if (大項目 == "売上原価" && 項目 == "期末棚卸") amount = -amount;

					// 売上予測は別のところで集計
					if (!(種別 == "予測" && 項目 == "売上"))
					{
						if (大項目 == "要員数")
						{
							Tab[secName][種別][大項目][項目][n] += amount;
						}
						else if (大項目 == "売上原価" && 種別 == "予測" && (項目 == "期末棚卸" || 項目 == "期首棚卸"))
						{
							Tab[secName]["予測"][大項目][項目][n] += amount * 1000;
							Tab[secName]["実績"][大項目][項目][n] += amount * 1000;
						}
						else
						{
							Tab[secName][種別][大項目][項目][n] += amount * 1000;
						}
					}


					//db_account data = new db_account()
					//{
					//	名前 = (string)reader["S_name"].ToString(),
					//	大項目 = (string)reader["大項目"].ToString(),
					//	項目 = (string)reader["項目"].ToString(),
					//	種別 = (string)reader["種別"].ToString(),
					//	直間 = (byte)reader["直間"],
					//	yymm = (int)reader["yymm"],
					//	amount = (int)reader["amount"]
					//};
					//dataTab.Add(data);
				}
				Debug.noWrite("reader Close");
				reader.Close();

				Debug.noWrite("DB Close");
				DB.Close();
				Debug.noWrite("DB Dispose");
				DB.Dispose();
			}
			return (dataTab);
		}

		public object json_uriageYosoku(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";

			var fixLevel = cmd.fixLevel;

			string dispMode = cmd.dispMode;

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);

			string S_name, secName, codes, mode;
			int yymm, n, level, 直間;
			double amount;
			StringBuilder sql = new StringBuilder("");
			List<string> SQLTab = new List<string>();
			foreach (var item in Tab)
			{
				S_name = item.Key;
				codes = Tab[S_name]["部署コード"];
				mode = Tab[S_name]["直間"];

				sql.Clear();
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

			if (SQLTab.Count > 0)
			{
				string SQL = string.Join(" UNION ALL ", SQLTab);

				SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");

			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				直間 = (byte)reader["直間"];
				level = (int)reader["level"];
				yymm = (int)reader["yymm"];
				amount = Convert.ToDouble(reader["amount"]);

				n = yymmDiff(s_yymm, yymm);

				if (S_name == null)
				{
					secName = "不明";
				}
				else if (dispMode == "全社")
				{
					secName = "全社";
				}
				else if (dispMode == "本社")
				{
					secName = (直間 == 2 ? "本社" : "直接");
				}
				else
				{
					secName = S_name;
				}

				//checkArray(Tab, secName, "予測データ", "売上予測", "確度70");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度50");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度30");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度10");

				if (level >= 70) Tab[secName]["予測データ"]["売上予測"]["確度70"][n] += amount;
				if (level >= 50) Tab[secName]["予測データ"]["売上予測"]["確度50"][n] += amount;
				if (level >= 30) Tab[secName]["予測データ"]["売上予測"]["確度30"][n] += amount;
				if (level >= 10) Tab[secName]["予測データ"]["売上予測"]["確度10"][n] += amount;

			}
			foreach (var item in Tab)
			{
				secName = item.Key;
				//checkArray(Tab, secName, "予測", "売上高", "売上");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度70");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度50");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度30");
				//checkArray(Tab, secName, "予測データ", "売上予測", "確度10");
				var Cnt = Tab[secName]["予測"]["売上高"]["売上"].Length;
				for (var m = 0; m < Cnt; m++) Tab[secName]["予測"]["売上高"]["売上"][m] = Tab[secName]["予測データ"]["売上予測"]["確度" + fixLevel][m];
			}


			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

			}
			return (dataTab);
		}

		public object json_uriageActual(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";

			var fixLevel = cmd.fixLevel;

			string dispMode = cmd.dispMode;

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);

			string S_name, secName, codes, mode;
			int yymm, n, 直間;
			double amount;
			StringBuilder sql = new StringBuilder("");
			List<string> SQLTab = new List<string>();
			foreach (var item in Tab)
			{
				S_name = item.Key;
				codes = Tab[S_name]["部署コード"];
				mode = Tab[S_name]["直間"];

				sql.Clear();
				sql.Append(" SELECT");
				sql.Append("      S_name = @S_name,");
				sql.Append("      直間   = MAST.直間,");
				sql.Append("	  yymm   = DATA.yymm,");
				sql.Append("	  amount = sum(DATA.金額)");
				sql.Append(" FROM");
				sql.Append("	  営業売上データ DATA ");
				sql.Append("                     LEFT JOIN 業務部署データ BUSYO");
				sql.Append("                          ON DATA.pNum    = BUSYO.pNum");
				sql.Append("                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) )  MAST");
				sql.Append("                          ON MAST.部署コード = BUSYO.部署ID");
				sql.Append(" WHERE");
				sql.Append("      (DATA.yymm BETWEEN @s_yymm and @e_yymm )");
				sql.Append("      AND");
				sql.Append("	  (DATA.yymm Between BUSYO.開始 And BUSYO.終了)");
				sql.Append("	  AND");
				sql.Append("	  DATA.付替 = 0");
				sql.Append("	  AND");
				sql.Append("	  DATA.Flag = 0");

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
				sql.Append("	  DATA.yymm");

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

			if (SQLTab.Count > 0)
			{
			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");

			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				amount = Convert.ToDouble(reader["amount"]);

				n = yymmDiff(s_yymm, yymm);

				if (S_name == null)
				{
					secName = "不明";
				}
				else if (dispMode == "全社")
				{
					secName = "全社";
				}
				else if (dispMode == "本社")
				{
					secName = (直間 == 2 ? "本社" : "直接");
				}
				else
				{
					secName = S_name;
				}

				checkArray(Tab, secName, "実績", "売上高", "売上");
				Tab[secName]["実績"]["売上高"]["売上"][n] += amount;
			}

			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

			}
			return (dataTab);
		}

		public object json_accountActual(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";

			var fixLevel = cmd.fixLevel;

			string dispMode = cmd.dispMode;

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);

			string S_name, secName, codes, mode;
			string 大項目, 分類, 科目, EMG;
			int yymm, n, 直間;
			double amount;
			List<string> SQLTab = new List<string>();
			StringBuilder sql = new StringBuilder("");
			foreach (var item in Tab)
			{
				S_name = item.Key;
				codes = Tab[S_name]["部署コード"];
				mode = Tab[S_name]["直間"];

				sql.Clear();
				sql.Append(" SELECT");
				sql.Append("      S_name  = @S_name,");
				sql.Append("      直間    = MAST.直間,");
				sql.Append("      大項目  = ITEM.大項目,");
				sql.Append("      分類    = ITEM.分類,");
				sql.Append("      科目    = DATA.科目,");
				sql.Append("      yymm    = DATA.yymm,");
				sql.Append("      EMG     = DATA.Flag,");
				sql.Append("      amount  = Sum(DATA.金額)");
				sql.Append(" FROM");
				sql.Append("    会計月データ DATA ");
				sql.Append("                 LEFT JOIN 会計項目マスタ ITEM");
				sql.Append("                      ON DATA.科目 = ITEM.KmkCode AND DATA.Flag = ITEM.Flag");
				sql.Append("                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) ) MAST");
				sql.Append("                      ON DATA.部門 = MAST.ACCコード");
				sql.Append(" WHERE");
				sql.Append("    DATA.yymm BETWEEN @s_yymm AND @e_yymm");
				sql.Append("    AND");
				sql.Append("    MAST.ACCコード >= 0");
				sql.Append("    AND");
				sql.Append("    NOT (DATA.科目 BETWEEN 211 AND 260)");              // 大項目 = 固定資産
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
				sql.Append("    MAST.直間,");
				sql.Append("    ITEM.大項目,");
				sql.Append("    ITEM.分類,");
				sql.Append("    DATA.科目,");
				sql.Append("    DATA.yymm,");
				sql.Append("    DATA.Flag");

				sql.Replace("@S_name", SqlUtil.Parameter("string", S_name));
				sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
				sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
				sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
				sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
				sql.Replace("@codes", SqlUtil.Parameter("number", codes));
				sql.Replace("@mode", SqlUtil.Parameter("number", mode));
				work = sql.ToString();
				SQLTab.Add(work);

				sql.Clear();
				sql.Append(" SELECT");
				sql.Append("      S_name  = @S_name,");
				sql.Append("      直間    = MAST.直間,");

				sql.Append("      大項目  = '固定資産',");
				sql.Append("      分類    = '機器・ソフト',");
				sql.Append("      科目    = DATA.科目,");
				sql.Append("      yymm    = DATA.yymm,");
				sql.Append("      EMG     = DATA.Flag,");
				sql.Append("      amount  = Sum(DATA.金額)");
				sql.Append(" FROM");
				sql.Append("    会計月データ DATA ");
				sql.Append("                 LEFT JOIN 会計項目マスタ ITEM");
				sql.Append("                      ON DATA.科目 = ITEM.KmkCode AND DATA.Flag = ITEM.Flag");
				sql.Append("                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) ) MAST");
				sql.Append("                      ON DATA.部門 = MAST.ACCコード");
				sql.Append(" WHERE");
				sql.Append("    DATA.yymm BETWEEN @s_yymm AND @e_yymm");
				sql.Append("    AND");
				sql.Append("    MAST.ACCコード >= 0");
				sql.Append("    AND");
				sql.Append("    DATA.科目 BETWEEN 211 AND 260");                // 大項目 = 固定資産
				if (codes.Length > 0)
				{
					sql.Append("    AND");
					sql.Append("    MAST.部署コード IN(@codes)");
				}
				sql.Append(" GROUP BY");
				sql.Append("    MAST.直間,");
				sql.Append("    ITEM.大項目,");
				sql.Append("    ITEM.分類,");
				sql.Append("    DATA.科目,");
				sql.Append("    DATA.yymm,");
				sql.Append("    DATA.Flag");

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

			if (SQLTab.Count > 0)
			{
				string SQL = string.Join(" UNION ALL ", SQLTab);
				SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");
			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				大項目 = (string)reader["大項目"].ToString();
				分類 = (string)reader["分類"].ToString();
				科目 = (string)reader["科目"].ToString();
				EMG = (string)reader["EMG"].ToString();
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				amount = Convert.ToDouble(reader["amount"]);

				n = yymmDiff(s_yymm, yymm);

				if (S_name == null)
				{
					secName = "不明";
				}
				else if (dispMode == "全社")
				{
					secName = "全社";
				}
				else if (dispMode == "本社")
				{
					secName = (直間 == 2 ? "本社" : "直接");
				}
				else
				{
					secName = S_name;
				}
				if (大項目 != null && 分類 != null && 大項目 != "")
				{
					checkArray(Tab, secName, "実績", 大項目, 分類);
					n = yymmDiff(s_yymm, yymm);
					if (EMG == "1") amount = -amount;
					Tab[secName]["実績"][大項目][分類][n] += amount;
				}
				else
				{
					var work1 = "[" + yymm + "][" + 科目 + "][" + amount + "]";
					work1 = string.Concat("[", 分類, "][", yymm, "][", 科目, "][", amount);
                    Debug.WriteLog("[会計データ集計での不明科目データ]" + work1);
                }

			}

			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

			}

			return (dataTab);
		}


		public object json_accountCost(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";

			var fixLevel = cmd.fixLevel;

			string dispMode = cmd.dispMode;

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);

			string S_name, secName, codes, mode;
			int yymm, n, 直間;
			List<string> SQLTab = new List<string>();
			StringBuilder sql = new StringBuilder("");
			foreach (var item in Tab)
			{
				S_name = item.Key;
				codes = Tab[S_name]["部署コード"];
				mode = Tab[S_name]["直間"];

				sql.Clear();
				sql.Append(" SELECT");
				sql.Append("      S_name  = @S_name,");
				sql.Append("      直間    = MAST.直間,");
				sql.Append("      payMode = '支払',");

				sql.Append("      部署    = COST.支払部署,");
				sql.Append("      yymm    = COST.yymm,");
				sql.Append("      金額    = COST.付替金額");
				sql.Append(" FROM");
				sql.Append("      付替データ COST ");
				sql.Append("                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) ) MAST");
				sql.Append("                      ON COST.支払部署 = MAST.部署コード");

				sql.Append(" WHERE");
				sql.Append("      COST.mode = 1");
				sql.Append("      AND");
				sql.Append("      COST.yymm BETWEEN @s_yymm and @e_yymm");
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

				sql.Replace("@S_name", SqlUtil.Parameter("string", S_name));
				sql.Replace("@s_yymm", SqlUtil.Parameter("number", s_yymm));
				sql.Replace("@e_yymm", SqlUtil.Parameter("number", e_yymm));
				sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
				sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
				sql.Replace("@codes", SqlUtil.Parameter("number", codes));
				sql.Replace("@mode", SqlUtil.Parameter("number", mode));
				work = sql.ToString();
				SQLTab.Add(work);

				sql.Clear();
				sql.Append(" SELECT");
				sql.Append("      S_name  = @S_name,");
				sql.Append("      直間    = MAST.直間,");
				sql.Append("      payMode = '受取',");

				sql.Append("      部署     = COST.受取部署,");
				sql.Append("      yymm     = COST.yymm,");
				sql.Append("      金額     = COST.付替金額");
				sql.Append(" FROM");
				sql.Append("      付替データ COST ");
				sql.Append("                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate ) ) MAST");
				sql.Append("                      ON COST.受取部署 = MAST.部署コード");

				sql.Append(" WHERE");
				sql.Append("      COST.mode = 1");
				sql.Append("      AND");
				sql.Append("      COST.yymm BETWEEN @s_yymm and @e_yymm");
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

			if (SQLTab.Count > 0)
			{
				string SQL = string.Join(" UNION ALL ", SQLTab);
				string payMode;
			double cost;
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");
			while (reader.Read())
			{
				sql.Append("      S_name  = @S_name,");
				sql.Append("      直間    = MAST.直間,");
				sql.Append("      payMode = '受取',");

				sql.Append("      部署     = COST.受取部署,");
				sql.Append("      yymm     = COST.yymm,");
				sql.Append("      金額     = COST.付替金額");

				S_name = (string)reader["S_name"].ToString();
				payMode = (string)reader["payMode"].ToString();
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				cost = Convert.ToDouble(reader["金額"]);

				n = yymmDiff(s_yymm, yymm);

				if (S_name == null)
				{
					secName = "不明";
				}
				else if (dispMode == "全社")
				{
					secName = "全社";
				}
				else if (dispMode == "本社")
				{
					secName = (直間 == 2 ? "本社" : "直接");
				}
				else
				{
					secName = S_name;
				}
				checkArray(Tab, secName, "実績", "費用付替", "支出");
				checkArray(Tab, secName, "実績", "費用付替", "収入");

				if (payMode == "支払") Tab[secName]["実績"]["費用付替"]["支出"][n] -= cost;
				if (payMode == "受取") Tab[secName]["実績"]["費用付替"]["収入"][n] += cost;

			}

			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

			}
			return (dataTab);
		}

		public object json_salesCost(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";

			var fixLevel = cmd.fixLevel;

			string dispMode = cmd.dispMode;

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);

			string S_name, secName, codes, mode;
			StringBuilder sql = new StringBuilder("");
			List<string> SQLTab = new List<string>();
			foreach (var item in Tab)
			{
				S_name = item.Key;
				codes = Tab[S_name]["部署コード"];
				mode = Tab[S_name]["直間"];

				sql.Clear();

				sql.Append(" SELECT");
				sql.Append("      S_name = @S_name,");
				sql.Append("      直間   = MAST.直間,");

				sql.Append("      pNum   = DATA.pNum,");
				sql.Append("      yymm   = DATA.yymm,");
				sql.Append("      付替   = DATA.付替,");
				sql.Append("      金額   = sum(DATA.金額)");
				sql.Append(" FROM");
				sql.Append("      営業売上データ DATA");
				sql.Append("                     LEFT JOIN 業務部署データ BUSYO");
				sql.Append("                          ON DATA.pNum    = BUSYO.pNum");
				sql.Append("                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate) ) MAST");
				sql.Append("                          ON BUSYO.部署ID = MAST.部署コード");
				sql.Append(" WHERE");
				sql.Append("       DATA.付替 IN(1,2)");
				sql.Append("       AND");
				sql.Append("       DATA.yymm Between BUSYO.開始 And BUSYO.終了");
				sql.Append("       AND");
				sql.Append("       DATA.yymm BETWEEN @s_yymm and @e_yymm");
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
				sql.Append("      DATA.pNum,");
				sql.Append("      DATA.yymm,");
				sql.Append("      DATA.付替");

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

			if (SQLTab.Count > 0)
			{
				string SQL = string.Join(" UNION ALL ", SQLTab);

				SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");
			int 付替;
			int yymm, n, 直間;
			double cost;
			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				付替 = (byte)reader["付替"];
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				cost = Convert.ToDouble(reader["金額"]);
				n = yymmDiff(s_yymm, yymm);

				if (S_name == null)
				{
					secName = "不明";
				}
				else if (dispMode == "全社")
				{
					secName = "全社";
				}
				else if (dispMode == "本社")
				{
					secName = (直間 == 2 ? "本社" : "直接");
				}
				else
				{
					secName = S_name;
				}

				checkArray(Tab, secName, "実績", "売上付替", "支出");
				checkArray(Tab, secName, "実績", "売上付替", "収入");
				if (付替 == 1) Tab[secName]["実績"]["売上付替"]["支出"][n] += cost;
				if (付替 == 2) Tab[secName]["実績"]["売上付替"]["収入"][n] += cost;

			}

			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

			}
			return (dataTab);
		}

		public object json_groupCost(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{
			List<db_account> dataTab = new List<db_account>();

			//Json = "{year:'2020',secMode:'開発',dispMode:'統括'}";

			var fixLevel = cmd.fixLevel;

			string dispMode = "cmd.dispMode";

			int mCnt = 12;                  // 予測・計画は12ヶ月分取得
			int year = cmd.year;
			int s_yymm = ((year - 1) * 100 + 10);
			int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			string s_sDate = String.Concat((s_yymm / 100), "/", (s_yymm % 100), "/01");

			DateTime sDate = DateTime.Parse(s_sDate);
			DateTime eDate = sDate.AddMonths(mCnt).AddDays(-1);

			string work = "";
			//Dictionary<string, dynamic> Tab = initTab(Json);

			string S_name, secName, codes, mode;
			StringBuilder sql = new StringBuilder("");
			List<string> SQLTab = new List<string>();
			foreach (var item in Tab)
			{
				S_name = item.Key;
				codes = Tab[S_name]["部署コード"];
				mode = Tab[S_name]["直間"];

				sql.Clear();

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
				sql.Append("                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate ) ) MAST");
				sql.Append("                          ON DATA.部署ID = MAST.部署コード");
				sql.Append("                     LEFT JOIN 収支項目マスタ ITEM");
				sql.Append("                          ON DATA.項目ID = ITEM.ID");
				sql.Append(" WHERE");
				sql.Append("      ITEM.大項目 = '部門固定費'");
				sql.Append("      AND");
				sql.Append("      DATA.種別 IN(0,1)");              // 計画・予測
				sql.Append("      AND");
				sql.Append("      MAST.ACCコード >= 0");
				sql.Append("      AND");
				sql.Append("      DATA.yymm BETWEEN @s_yymm AND @e_yymm");
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

				//	実績データ
				sql.Clear();
				sql.Append(" SELECT");
				sql.Append("      S_name = @S_name,");
				sql.Append("      直間   = MAST.直間,");

				sql.Append("      大項目 = ITEM.大項目,");
				sql.Append("      項目   = ITEM.項目,");
				sql.Append("      種別   = '実績',");
				sql.Append("      yymm   = DATA.yymm,");
				sql.Append("      amount = Sum(DATA.費用)");
				sql.Append(" FROM");
				sql.Append("      部門固定費実績データ DATA ");
				sql.Append("                           LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > @eDate or 終了 < @sDate ) ) MAST");
				sql.Append("                                ON DATA.部署ID = MAST.部署コード");
				sql.Append("                           LEFT JOIN 収支項目マスタ ITEM");
				sql.Append("                                ON DATA.項目ID = ITEM.ID");

				sql.Append(" WHERE");
				sql.Append("      ITEM.大項目 = '部門固定費'");
				sql.Append("      AND");
				sql.Append("      MAST.ACCコード >= 0");
				sql.Append("      AND");
				sql.Append("      DATA.yymm BETWEEN @s_yymm AND @e_yymm");
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
				sql.Append("    MAST.直間,");
				sql.Append("    ITEM.大項目,");
				sql.Append("    ITEM.項目,");
				sql.Append("    DATA.yymm");
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

			if (SQLTab.Count > 0)
			{
				string SQL = string.Join(" UNION ALL ", SQLTab);
				SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");
			int yymm, n, 直間;
			double amount;
			string 種別, 大項目, 項目;
			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				大項目 = (string)reader["大項目"].ToString();
				項目 = (string)reader["項目"].ToString();
				種別 = (string)reader["種別"].ToString();
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				amount = Convert.ToDouble(reader["amount"]);

				n = yymmDiff(s_yymm, yymm);

				if (S_name == null)
				{
					secName = "不明";
				}
				else if (dispMode == "全社")
				{
					secName = "全社";
				}
				else if (dispMode == "本社")
				{
					secName = (直間 == 2 ? "本社" : "直接");
				}
				else
				{
					secName = S_name;
				}

				checkArray(Tab, secName, 種別, 大項目, 項目);
				Tab[secName][種別][大項目][項目][n] += amount * (種別 == "実績" ? 1 : 1000)
;
			}

			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

            }
			return (dataTab);
		}
	}
}

