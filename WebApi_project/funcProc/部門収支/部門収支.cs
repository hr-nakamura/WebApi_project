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


/*
EMG		dispCmd=EMG														&year=2021		&fix=70		&yosoku=3]
統括	dispCmd=統括一覧												&year=2021		&fix=70		&yosoku=3]
		dispCmd=統括詳細	&secMode=開発	&dispName=ACEL事業推進本部	&year=2021		&fix=70		&yosoku=3]


部門	dispCmd=部門一覧	&secMode=開発	&dispName=					&year=2021		&fix=70		&yosoku=3]
		dispCmd=部門詳細	&secMode=開発	&dispName=ACEL事業推進本部	&year=2021		&fix=70		&yosoku=3]

課		dispCmd=課一覧		&secMode=開発	&dispName=営業本部			&year=2021		&fix=70		&yosoku=3]
		dispCmd=課詳細		&secMode=開発	&dispName=365				&year=2021		&fix=70		&yosoku=3]

*/

namespace WebApi_project.hostProc
{
	public class 部門収支 : hostProc

    {
		public XmlDocument 部門収支_XML(String Json)
		{
			Json = "{dispCmd:'統括一覧',year:'2021', mCnt:'4', fixLevel:'70' ,name:''}";

			List<string> func = new List<string>(){ "結合","計画","予測","実績"};



			Dictionary<string, dynamic> Tab = (Dictionary<string, dynamic>)json_部門収支_XML(Json);
			Dictionary<string, dynamic> dataTab = Tab["data"];

			XmlDocument xmlDoc = makeBaseXML(dataTab);
			string secName;
			string 大項目;
			string 項目;

			foreach (KeyValuePair<string, dynamic> item1 in dataTab)
			{
				secName = item1.Key;
				foreach (string funcName in func)
				{
					foreach (KeyValuePair<string, dynamic> item3 in dataTab[secName][funcName])
					{
						大項目 = item3.Key;
						foreach (KeyValuePair<string, dynamic> item4 in dataTab[secName][funcName][大項目])
						{
							項目 = item4.Key;
							int[] targetTab = item4.Value;
							//Debug.noWrite("target",secName, funcName,大項目, 項目,(targetTab.Length).ToString());
							// ここでxmlノードを探してデータ設定する
							checkNode(xmlDoc, secName, funcName, 大項目, 項目, targetTab);

						}
					}
				}
			}
		return (xmlDoc);
		}
		XmlDocument makeBaseXML(Dictionary<string, dynamic> dataTab)
        {
			string fName = getAbsoluteFileName("/funcProc/部門収支/BASE.xml");
			var xmlDoc = new XmlDocument();
			xmlDoc.Load(fName);
			XmlNode topNode = xmlDoc.SelectSingleNode("//全体");
			XmlElement secNode = (XmlElement)xmlDoc.SelectSingleNode("//グループ");

			for( var i = 1; i < dataTab.Count; i++)
			{
				XmlNode Node = secNode.CloneNode(true);
				topNode.AppendChild(Node);
			}

			// キーの配列に変換
			var keyArray = dataTab.Keys.ToArray();

			// 値の配列に変換
			var valueArray = dataTab.Values.ToArray();

			var NodeList = xmlDoc.SelectNodes("//グループ");
			var No = 0;
			foreach( XmlElement elem in NodeList)
            {
				XmlNode nameNode = elem.SelectSingleNode("名前");
				string name = keyArray[No];
				nameNode.InnerText = name;
				string mode = (valueArray[No]["直間"] == "2" ? "間接" : "開発");
				string kind = (valueArray[No]["種別"] == "間接" ? "間接" : "開発");			// 間接・直接
				elem.SetAttribute("name", name);
				elem.SetAttribute("kind", mode);
				elem.SetAttribute("kind2", valueArray[No]["種別"]);
				No++;
            }
			return (xmlDoc);
		}
		void checkNode(XmlDocument xmlDoc, string secName, string funcName, string 大項目, string 項目, int[] values)
		{
			XmlNode rootNode = xmlDoc.SelectSingleNode("/root");
			XmlNodeList targetsecNodeList = rootNode.SelectNodes("全体/グループ");
			XmlNode SecNode = rootNode.SelectSingleNode("全体/グループ[@name='" + secName + "']");
			XmlNode Node = rootNode.SelectSingleNode("全体/グループ[@name='" + secName + "']/データ[@name='" + funcName + "']/" + 大項目 + "/項目[@name='" + 項目 + "']");
			if (Node == null)
			{
				Debug.Write(string.Concat("対象無し：[",secName, "][", funcName, "][", 大項目, "][", 項目,"]"));
			}
            else
            {
                XmlNodeList targetList = Node.SelectNodes("月");
                for (var i = 0; i < 12; i++)
                {
					targetList[i].InnerText = values[i].ToString();
                }
            }
		}

		int[] checkData(Dictionary<string, dynamic> Tab, string s1, string s2, string s3)
		{
			try
			{
				if (Tab[s1][s2].ContainsKey(s3))
				{
					//Debug.noWrite("ある");
					return (Tab[s1][s2][s3]);
				}
			}
			catch (Exception ex)
			{
				Debug.noWrite(ex.Message);
			}
			int[] x = new int[0];
			return (x);
		}
		public object json_部門収支_XML(String Json)
		{

			Dictionary<string, dynamic> Tab = new Dictionary<string, dynamic>();

			Json = "{dispCmd:'統括一覧',year:'2021', mCnt:'4', fixLevel:'70' ,name:''}";

			//Json = "{dispCmd:統括一覧											,year:'2021', mCnt:4, fixLevel:70 }";
			//Json = "{dispCmd:部門一覧	,secMode:'開発'							,year:'2021', mCnt:4, fixLevel:70 }";
			//Json = "{dispCmd:課一覧		,secMode:'開発'	,dispMode:'営業本部'	,year:'2021', mCnt:4, fixLevel:70 }";
			//var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);
			var cmd = checkCmd(Json);

			//int mCnt = o_json.mCnt;
   //         int year = o_json.year;
   //         int s_yymm = ((year - 1) * 100 + 10);
   //         int e_yymm = yymmAdd(s_yymm, mCnt - 1);
			//o_json.s_yymm = s_yymm;

			Tab.Add("Info", cmd);
			Tab.Add("data", initTab(cmd));


            json_groupPlan(cmd, Tab["data"]);							// 計画・予測データ取得
            json_uriageYosoku(cmd, Tab["data"]);                       // 売上予測データ取得
            json_uriageActual(cmd, Tab["data"]);                       // 売上実績データ取得
            json_accountActual(cmd, Tab["data"]);                          // 費用実績データ取得

            if (cmd.dispMode != "全社")
            {
                json_accountCost(cmd, Tab["data"]);                         // 費用付替
                json_salesCost(cmd, Tab["data"]);                               // 売上付替
                json_groupCost(cmd, Tab["data"]);                           // 部門固定費データ取得
            }
			if( cmd.haifuMode == true)
            {
                本社費配賦(cmd, Tab["data"]);
            }
			//memberPlan(Json, Tab["data"]);
			//memberActual(Json, Tab["data"]);

			// 結合データを作成する
			meke_JoinData(Tab);

			return (Tab);
		}
	void meke_JoinData(Dictionary<string, dynamic> Tab)
        {
			cmd_部門収支 cmd = Tab["Info"];

			Dictionary<string, dynamic> dataTab = Tab["data"];
			string secName,大項目, 項目;
			foreach (KeyValuePair<string, dynamic> item in dataTab)
            {
				secName = item.Key;

				foreach (KeyValuePair<string, dynamic> item3 in dataTab[secName]["実績"])
				{
					大項目 = item3.Key;
					foreach (KeyValuePair<string, dynamic> item4 in dataTab[secName][funcName][大項目])
					{
						項目 = item4.Key;
						int[] targetTab = item4.Value;
						//Debug.noWrite("target",secName, funcName,大項目, 項目,(targetTab.Length).ToString());
						// ここでxmlノードを探してデータ設定する

					}
				}
			}

		}
		//=====================================================================================

		void 本社費配賦(cmd_部門収支 cmd, Dictionary<string, dynamic> dataTab)
		{
			var mCnt = cmd.mCnt;
			var year = cmd.year;

			if (mCnt == 0) return;

			foreach (KeyValuePair<string, dynamic> item in dataTab)
            {
				string S_name = item.Key;
				if (S_name == "本社") calcTargetPlan(cmd,dataTab[S_name]);
			}
			calcHaifu(cmd, dataTab);

		}

		void calcTargetPlan(cmd_部門収支 cmd, Dictionary<string, dynamic> dataTab)
        {

        }
		void calcHaifu(cmd_部門収支 cmd, Dictionary<string, dynamic> dataTab)
		{

		}
/*
		//	本社費の目標値の計算（本社の費用を合計する）
		void calcTargetPlan(string Tab1, string mCnt1);
		{
			int mCnt = 3;
			//	if( !IsObject(xTab["本社"]) ) return
			//	var Tab = xTab["本社"]
			for (var m = 0; m < mCnt; m++)
			{
				// 支出の部
				var itemStr = "売上原価,販管費,営業外費用".split(",");
				for(var iNum in itemStr)
				{
					var item = itemStr[iNum];
					for(var kind in Tab["計画"][item])
					{
						Tab["計画"]["予算"]["予算"][m] += Tab["計画"][item][kind][m];
						Tab["予測"]["予算"]["予算"][m] += Tab["計画"][item][kind][m];
						Tab["実績"]["予算"]["予算"][m] += Tab["計画"][item][kind][m];
					}
				}
// 収入の部
				var itemStr = "営業外収益,費用付替,売上付替".split(",");
				for(var iNum in itemStr)
				{
					var item = itemStr[iNum];
					for(var kind in Tab["計画"][item])
					{
						Tab["計画"]["予算"]["予算"][m] -= Tab["計画"][item][kind][m];
						Tab["予測"]["予算"]["予算"][m] -= Tab["計画"][item][kind][m];
						Tab["実績"]["予算"]["予算"][m] -= Tab["計画"][item][kind][m];
					}
				}
			}
			//	本社計画値から本社売上を引く
			//	表示から売上を引いた数値にするため
			for (var m = 0; m < mCnt; m++)
			{
				Tab["計画"]["予算"]["予算"][m] -= Tab["計画"]["売上高"]["売上"][m];
				Tab["予測"]["予算"]["予算"][m] -= Tab["計画"]["売上高"]["売上"][m];
				Tab["実績"]["予算"]["予算"][m] -= Tab["計画"]["売上高"]["売上"][m];
			}
		}

		void calcHaihu(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
		{

	//[本社の全計画] - [本社の売上計画] - [部門の固定費合計] = [配布対象額]


	//人件費・雑給・原価外注費・固定費の人件費

	//[全部門の合計を分母とする]



	//部門固定費・人件費
	//販管費・人件費
	//販管費・雑給
	//売上原価・"外注費




	//	パートの配賦は2008年度まで1/4  (0.25)
	//				  2009年度から1/100(0.01)

			int year = 2021;
			int mCnt = 3;

			double partUnit = 1;
			double guestUnit = 1;
			if (year <= 2008)
			{                               // - 2008
				partUnit = 0.25;
				guestUnit = 0.25;
			}
			else if (year >= 2009 && year <= 2010)
			{       // 2009 - 2010
				partUnit = 0.01;
				guestUnit = 0.01;
			}
			else if (year >= 2011 && year <= 2015)
			{           // 2011 - 2015
				partUnit = 0.03;
				guestUnit = 0.03;
			}
			else if (year >= 2016)
			{                       // 2016 -
				partUnit = 1.0;
				guestUnit = 0.10;
			}
			else
			{
				partUnit = 1.0;
				guestUnit = 0.10;
			}

			var modeTab = ["計画", "予測", "実績"];
			for (var i = 0; i < modeTab.length; i++)
			{           // 実績・予測・計画
				var mode = modeTab[i];
				for (var m = 0; m < mCnt; m++)
				{
				// 配賦対象額の作成
				xTab["本社"]["配賦"][mode]["本社予算"][m] += xTab["本社"]["計画"]["予算"]["予算"][m];
				xTab["本社"]["配賦"][mode]["売上"][m] += xTab["本社"]["計画"]["売上高"]["売上"][m];

				// 部門の固定費合計
					for(var item in xTab["直接"][mode]["部門固定費"])
					{
						xTab["本社"]["配賦"][mode]["固定費合計"][m] += xTab["直接"][mode]["部門固定費"][item][m];
					}
				// 配賦対象額の算出
				//	ここの本社予算は売上を引いた数値
				//	ここで売上を引かないのが正しい
					xTab["本社"]["配賦"][mode]["配賦対象"][m] += xTab["本社"]["配賦"][mode]["本社予算"][m];
				//			xTab["本社"]["配賦"][mode]["配賦対象"][m] -= xTab["本社"]["配賦"][mode]["売上"][m]
					xTab["本社"]["配賦"][mode]["配賦対象"][m] -= xTab["本社"]["配賦"][mode]["固定費合計"][m];


				// 部門の計算の分母作成
					xTab["本社"]["配賦"][mode]["販管人件費"][m] += xTab["直接"][mode]["販管費"]["人件費"][m];
					xTab["本社"]["配賦"][mode]["販管雑給"][m] += xTab["直接"][mode]["販管費"]["雑給"][m];
					xTab["本社"]["配賦"][mode]["原価外注費"][m] += xTab["直接"][mode]["売上原価"]["外注費"][m];
					xTab["本社"]["配賦"][mode]["固定人件費"][m] += xTab["直接"][mode]["部門固定費"]["人件費"][m];

				// 部門の計算
					for(var secName in xTab)
					{
						if (secName == "本社" || secName == "直接") continue;
						xTab[secName]["配賦"][mode]["販管人件費"][m] += xTab[secName][mode]["販管費"]["人件費"][m];
						xTab[secName]["配賦"][mode]["固定人件費"][m] += xTab[secName][mode]["部門固定費"]["人件費"][m];
						xTab[secName]["配賦"][mode]["原価外注費"][m] += xTab[secName][mode]["売上原価"]["外注費"][m];
						xTab[secName]["配賦"][mode]["販管雑給"][m] += xTab[secName][mode]["販管費"]["雑給"][m];
					}

					for(var secName in xTab)
					{
						if (secName == "直接") continue;
						xTab[secName]["配賦"][mode]["計算額"][m] += xTab[secName]["配賦"][mode]["販管人件費"][m];
						if (year >= 2013)
						{
							xTab[secName]["配賦"][mode]["計算額"][m] += xTab[secName]["配賦"][mode]["固定人件費"][m];
						}
						xTab[secName]["配賦"][mode]["計算額"][m] += (xTab[secName]["配賦"][mode]["販管雑給"][m] * partUnit);
						xTab[secName]["配賦"][mode]["計算額"][m] += (xTab[secName]["配賦"][mode]["原価外注費"][m] * guestUnit);
					}
				// 分配の計算
					for(var secName in xTab)
					{
						if (secName == "本社" || secName == "直接") continue;
						xTab[secName]["配賦"][mode]["分配率"][m] = xTab[secName]["配賦"][mode]["計算額"][m] / xTab["本社"]["配賦"][mode]["計算額"][m];
					}
			// 分配の計算

					for(var secName in xTab)
					{
						if (secName == "本社" || secName == "直接") continue;
						var value = xTab["本社"]["配賦"][mode]["配賦対象"][m] * xTab[secName]["配賦"][mode]["分配率"][m];
						xTab[secName][mode]["本社費配賦"]["本社費"][m] = (isNaN(value) ? 0 : value);
					}


				}
			}
		}
*/
		cmd_部門収支 checkCmd(string Json)
		{
			var o_json = JsonConvert.DeserializeObject<para_部門収支>(Json);
			string[] work = o_json.name.Split('/');

			string 統括 = work[0];
			string 部 = (work.Length > 1 ? work[1] : "");
			string 課 = (work.Length > 2 ? work[2] : "");
			int s_yymm = ((o_json.year - 1) * 100 + 10);

			cmd_部門収支 cmd = new cmd_部門収支()
			{
				year = o_json.year,
				mCnt = o_json.mCnt,
				fixLevel = o_json.fixLevel,
				s_yymm = s_yymm,
				統括 = 統括,
				部 = 部,
				課 = 課
			};

			switch (o_json.dispCmd)
			{
				case "EMG":
					cmd.dispMode = "全社";
					cmd.listMode = "詳細";
					cmd.secMode = "";
					cmd.haifuMode = false;
					break;
				case "統括一覧":
					cmd.dispMode = "統括";
					cmd.listMode = "一覧";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "部門一覧":
					;
					cmd.dispMode = "部門";
					cmd.統括 = 統括;
					cmd.listMode = "一覧";
					cmd.secMode = "開発";
					cmd.haifuMode = (o_json.secMode == "間接" ? false : true);
					break;
				case "課一覧":
					cmd.dispMode = "グループ";
					cmd.統括 = 統括;
					cmd.部 = 部;
					cmd.listMode = "一覧";
					cmd.secMode = "開発";
					cmd.haifuMode = true;        // 課に対しては計算しない
					break;
				case "統括詳細":
					cmd.dispMode = "統括";
					cmd.統括 = 統括;
					cmd.listMode = "詳細";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "部門詳細":
					cmd.dispMode = "部門";
					cmd.統括 = 統括;
					cmd.部 = 部;
					cmd.listMode = "詳細";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "課詳細":
					cmd.dispMode = "グループ";
					cmd.統括 = 統括;
					cmd.部 = 部;
					cmd.課 = 課;
					cmd.listMode = "詳細";
					cmd.secMode = "開発";
					cmd.haifuMode = true;        // 課に対しては計算しない
					break;
				//	配賦
				case "統括配賦":
					cmd.dispMode = "統括";
					cmd.統括 = 統括;
					cmd.listMode = "配賦";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "部門配賦":
					cmd.dispMode = "部門";
					cmd.統括 = 統括;
					cmd.部 = 部;
					cmd.listMode = "配賦";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "間接一覧":
					cmd.dispMode = "グループ";
					cmd.listMode = "間接一覧";
					cmd.secMode = "間接";
					cmd.haifuMode = false;
					break;
				default:
					break;
			}
			return (cmd);
		}
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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);
			string 大項目, 項目, 種別, S_name, secName;
			int yymm, n, amount, 直間;

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

			string SQL = string.Join(" UNION ALL ", SQLTab);

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
				amount = (int)reader["amount"];

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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);

			string S_name, secName, codes, mode;
			int yymm, n, amount, level, 直間;

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

			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");

			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				直間 = (byte)reader["直間"];
				level = (int)reader["level"];
				yymm = (int)reader["yymm"];
				amount = (int)reader["amount"];

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

				checkArray(Tab, secName, "予測", "売上高", "売上");
				checkArray(Tab, secName, "予測", "売上予測", "確度70");
				checkArray(Tab, secName, "予測", "売上予測", "確度50");
				checkArray(Tab, secName, "予測", "売上予測", "確度30");
				checkArray(Tab, secName, "予測", "売上予測", "確度10");

				if (level >= 70) Tab[secName]["予測"]["売上予測"]["確度70"][n] += amount;
				if (level >= 50) Tab[secName]["予測"]["売上予測"]["確度50"][n] += amount;
				if (level >= 30) Tab[secName]["予測"]["売上予測"]["確度30"][n] += amount;
				if (level >= 10) Tab[secName]["予測"]["売上予測"]["確度10"][n] += amount;

				//db_account data = new db_account()
				//{
				//	名前 = (string)reader["S_name"].ToString(),
				//	level = (int)reader["level"],
				//	直間 = (byte)reader["直間"],
				//	yymm = (int)reader["yymm"],
				//	amount = (int)reader["amount"]
				//};
				//dataTab.Add(data);
			}
			foreach (var item in Tab)
			{
				secName = item.Key;
				var Cnt = Tab[secName]["予測"]["売上高"]["売上"].Length;
				for (var m = 0; m < Cnt; m++) Tab[secName]["予測"]["売上高"]["売上"][m] = Tab[secName]["予測"]["売上予測"]["確度" + fixLevel][m];
			}


			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);

			string S_name, secName, codes, mode;
			int yymm, n, 直間;
			decimal amount;
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

			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");

			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				amount = (decimal)reader["amount"];

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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);

			string S_name, secName, codes, mode;
			string 大項目, 分類, 科目, EMG;
			int yymm, n, 直間;
			decimal amount;
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

			string SQL = string.Join(" UNION ALL ", SQLTab);

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
				amount = (decimal)reader["amount"];

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
				if (大項目 != null && 分類 != null && 大項目　!= "")
				{
					checkArray(Tab, secName, "実績", 大項目, 分類);
					n = yymmDiff(s_yymm, yymm);
					if (EMG == "1") amount = -amount;
					Tab[secName]["実績"][大項目][分類][n] += amount;
					}
				else
				{
					var work1 = "[" + yymm + "][" + 科目 + "][" + amount + "]";
					work1 = string.Concat("[",分類,"][",yymm,"][",科目,"][",amount);
					Debug.Write("[会計データ集計での不明科目データ]" + work1);
					}

			}

			Debug.noWrite("reader Close");
			reader.Close();

			Debug.noWrite("DB Close");
			DB.Close();
			Debug.noWrite("DB Dispose");
			DB.Dispose();

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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);

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

			string SQL = string.Join(" UNION ALL ", SQLTab);

			string payMode;
			int cost;
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
				cost = (int)reader["金額"];

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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);

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

			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");
			int 付替;
			int yymm, n, 直間;
			decimal cost;
			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				付替 = (byte)reader["付替"];
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				cost = (decimal)reader["金額"];

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
			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			Debug.noWrite("DB Open", DB_connectString);

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

			string SQL = string.Join(" UNION ALL ", SQLTab);

			SqlDataReader reader = dbRead(DB, SQL);
			Debug.noWrite("reader Start");
			int yymm, n, 直間, amount;
			string 種別,大項目, 項目;
			while (reader.Read())
			{
				S_name = (string)reader["S_name"].ToString();
				大項目 = (string)reader["大項目"].ToString();
				項目 = (string)reader["項目"].ToString();
				種別 = (string)reader["種別"].ToString();
				直間 = (byte)reader["直間"];
				yymm = (int)reader["yymm"];
				amount = (int)reader["amount"];

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

			return (dataTab);
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
			//Debug.noWrite("確認");
			if (大項目 == "")
			{
				Debug.Write("XX");
			}
			try
			{
				if (Tab[部門][種別][大項目].ContainsKey(項目))
				{
					//Debug.noWrite("ある");
					return (Tab);
				}
			}
			catch (Exception ex)
			{
                Debug.noWrite(ex.Message);
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
			//Debug.noWrite("設定");
			Tab[部門][種別][大項目][項目] = new int[12];
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
			Tab.Add("結合", new Dictionary<string, dynamic>());
			Tab.Add("計画", new Dictionary<string, dynamic>());
			Tab.Add("予測", new Dictionary<string, dynamic>());
			Tab.Add("実績", new Dictionary<string, dynamic>());
			Tab.Add("予測データ", new Dictionary<string, dynamic>());

			return (Tab);
		}
		Dictionary<string, dynamic> initTab(cmd_部門収支 o_json)
		{
			Dictionary<string, dynamic> Tab = new Dictionary<string, dynamic>();
			Dictionary<string, object> Info = new Dictionary<string, object>();
			Dictionary<string, object> Data = new Dictionary<string, object>();
			jsonProc jProc = new jsonProc();

            //Json = "{year:'2020',secMode:'開発',dispMode:'グループ'}";
            //var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

            Dictionary<string, group> secTab = jProc.json_部門リスト(o_json);

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
                    //Debug.noWrite(統括, secTab[統括].codes);
                }
            }
            else if (o_json.dispMode == "部門")
            {
                group sec = secTab["開発本部"];

                foreach (string 部門 in sec.list.Keys)
                {
                    var x = sec.list[部門];
                    Tab.Add(部門, costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
                    //Debug.noWrite(部門, sec.list[部門].codes);
                }
            }
            else if (o_json.dispMode == "課")
            {
                group sec = secTab["開発本部"].list["第1開発部"];
                foreach (string 課 in sec.list.Keys)
                {
                    var x = sec.list[課];
                    Tab.Add(課, costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
                    //Debug.noWrite(課, sec.list[課].codes);
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
			public int level { get; set; }
			public int yymm { get; set; }
			public int amount { get; set; }
		}
	}
}

