using System;
using System.Web;
using System.Xml;
using System.Text;
using System.Reflection;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Diagnostics;

using System.Xml.Serialization;
using System.IO;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using WebApi_project.Models;
using CodingSquareCS;
using System.Runtime.Serialization.Json;
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

	partial class 部門収支 : hostProc
    {
		private XmlDocument 部門収支_XML(String Json)
		{
			if (Json == "{}")
			{
				Json = "{dispCmd:'EMG',year:'2021', yosoku:'3', fix:'70' }";
				//Json = "{dispCmd:'統括一覧',year:'2021', yosoku:'3', fix:'70' }";
				//Json = "{dispCmd:'詳細',統括:'営業本部',year:'2021', yosoku:'3', fix:'70' }";
			}
            Json = @"{dispCmd:'EMG',year:'2022', yosoku:'4', fix:'70' }";
            //Json = @"{'dispCmd': '統括一覧','secMode':'開発','year':'2022','yosoku':'3','fix':'70'}";
            //Json = @"{'dispCmd': '部門一覧','secMode':'開発','year':'2022','yosoku':'3','fix':'70'}";

            Dictionary<string, dynamic> Tab = (Dictionary<string, dynamic>)json_部門収支_XML(Json);
			Dictionary<string, dynamic> dataTab = Tab["data"];

            // dataTabの「表示」以外の要素を削除
            var removeList = dataTab.Where(item => item.Value["名前"] == "").ToList();
            foreach (var elem in removeList) dataTab.Remove(elem.Key);

			cmd_部門収支 cmd = Tab["Info"];
			List<string> func;
			if ( cmd.listMode == "一覧")
            {
				func = new List<string>() { "結合" };
			}
			else
            {
				func = new List<string>() { "結合", "計画", "予測", "実績", "予測データ" };
			}
			XmlDocument xmlDoc = makeBaseXML(Tab);
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
							double[] targetTab = item4.Value;
							DebugHost.Debug.noWrite("target", secName, funcName, 大項目, 項目, (targetTab.Length).ToString());
                            // ここでxmlノードを探してデータ設定する(全てJson→XML)
                            checkNode(xmlDoc, secName, funcName, 大項目, 項目, targetTab);

						}
					}
				}
			}
			// 日付設定
            XmlNode dNode = xmlDoc.SelectSingleNode("//実績日付");
            dNode.InnerText = cmd.guide;
			// タイトル設定
            if (!String.IsNullOrEmpty(cmd.title)) xmlDoc.SelectSingleNode("//グループ/名前").InnerText = cmd.title;
			var NodeList = xmlDoc.SelectNodes("//グループ");
			foreach (XmlElement elem in NodeList) elem.RemoveAttribute("target");


			Apppend_Para(xmlDoc, Json);

			return (xmlDoc);
		}

		XmlDocument makeBaseXML(Dictionary<string, dynamic> Tab)
        {
			cmd_部門収支 cmd = Tab["Info"];

			Dictionary<string, dynamic> dataTab = Tab["data"];

			string fName = getAbsoluteFileName("/Api_Proc/funcProc/部門収支/BASE.xml");
			var xmlDoc = new XmlDocument();
			xmlDoc.Load(fName);
			XmlNode topNode = xmlDoc.SelectSingleNode("//全体");
			XmlElement secNode = (XmlElement)xmlDoc.SelectSingleNode("//グループ");

			// 実績・予測・計画の設定
			XmlNodeList NodeListM = xmlDoc.SelectNodes("//データ[@name='結合']/月情報/月");
			for( var m = 0; m < 12; m++)
            {
				NodeListM[m].InnerText = cmd.funcList[m];
            }

			XmlNodeList nodeList;
            if (cmd.listMode == "詳細" && cmd.secMode != "開発")
            {
				DebugHost.Debug.noWrite("AAA",cmd.listMode, cmd.secMode);
                nodeList = secNode.SelectNodes("データ/本社費配賦|データ/売上付替|データ/費用付替|データ/部門固定費");
                foreach (XmlNode node in nodeList)
                {
                    node.ParentNode.RemoveChild(node);
                }
            }

            if ( cmd.listMode == "一覧")
            {
				DebugHost.Debug.noWrite("BBB", cmd.listMode, cmd.secMode);
				nodeList = secNode.SelectNodes("データ[@name!='結合']");
				foreach (XmlNode node in nodeList)
				{
					node.ParentNode.RemoveChild(node);
				}
			}

			for ( var i = 1; i < dataTab.Count; i++)
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
				XmlNode nameNode1 = elem.SelectSingleNode("統括");
				XmlNode nameNode2 = elem.SelectSingleNode("部門");
				XmlNode nameNode3 = elem.SelectSingleNode("課");
				XmlNode nameNode4 = elem.SelectSingleNode("部署コード");
				string name = keyArray[No];
				string mode = (valueArray[No]["直間"] == "2" ? "間接" : "開発");
				string kind = (valueArray[No]["種別"] == "間接" ? "間接" : "開発");         // 間接・直接
                elem.SetAttribute("target", name);
                elem.SetAttribute("kind", mode);
				elem.SetAttribute("統括", valueArray[No]["部署名"].統括);
				elem.SetAttribute("部", valueArray[No]["部署名"].部門);
				elem.SetAttribute("課", valueArray[No]["部署名"].課);

				nameNode.InnerText = valueArray[No]["名前"];
				nameNode1.InnerText = valueArray[No]["部署名"].統括;
				nameNode2.InnerText = valueArray[No]["部署名"].部門;
				nameNode3.InnerText = valueArray[No]["部署名"].課;
				nameNode4.InnerText = valueArray[No]["部署コード"];
				var nodeListStr = "";
				if (mode == "開発")
				{
					nodeListStr = "データ/予算";
				}
				else
				{
					nodeListStr = "データ/部門固定費|データ/本社費配賦";
				}
				var nodeList1 = elem.SelectNodes(nodeListStr);
				foreach (XmlNode node in nodeList1)
				{
					node.ParentNode.RemoveChild(node);
				}
				No++;
            }
			return (xmlDoc);
		}
		private object json_部門収支_XML(String Json)
		{

			Dictionary<string, dynamic> Tab = new Dictionary<string, dynamic>();
			if( Json == "{}")
            {
				Json = "{dispCmd:'EMG',secMode:'',dispName:'',year:'2021',yosoku:'3', fix:'70'}";
			}
			var sw = new StopWatch();
            sw.Start("計測開始"); // 計測開始

            var cmd = InitCmd(Json);

			Tab.Add("Info", cmd);
			Tab.Add("data", initTab(cmd));


            // ラップタイム計測
            sw.Lap("json_groupPlan");
            json_groupPlan(cmd, Tab["data"]);                           // 計画・予測データ取得

            sw.Lap("json_uriageYosoku");
            json_uriageYosoku(cmd, Tab["data"]);                       // 売上予測データ取得

            sw.Lap("json_uriageActual");
            json_uriageActual(cmd, Tab["data"]);                       // 売上実績データ取得

            sw.Lap("json_accountActual");
            json_accountActual(cmd, Tab["data"]);                          // 費用実績データ取得

            if (cmd.dispMode != "全社")
            {
				sw.Lap("json_accountCost");
				json_accountCost(cmd, Tab["data"]);                         // 費用付替

				sw.Lap("json_salesCost");
				json_salesCost(cmd, Tab["data"]);                               // 売上付替

				sw.Lap("json_groupCost");
				json_groupCost(cmd, Tab["data"]);                           // 部門固定費データ取得
            }
			if( cmd.haifuMode == true)
            {
				sw.Lap("本社費配賦");
				本社費配賦(cmd, Tab["data"]);
            }
			if(cmd.secMode == "間接")
            {
				foreach(KeyValuePair<string,dynamic> elem in Tab["data"])
                {
					checkArray(Tab["data"], elem.Key, "計画", "売上高", "売上");
					checkArray(Tab["data"], elem.Key, "計画", "予算", "予算");
                    checkArray(Tab["data"], elem.Key, "予測", "予算", "予算");
					checkArray(Tab["data"], elem.Key, "実績", "予算", "予算");
					calcTargetPlan(cmd, Tab["data"][elem.Key]);
                }
			}
			//memberPlan(Json, Tab["data"]);
			//memberActual(Json, Tab["data"]);

			sw.Lap("結合データを作成");
			// 結合データを作成する
			meke_JoinData(Tab);




            // 時間計測終了
            sw.Stop(); // 計測終了

            return (Tab);
		}
		cmd_部門収支 InitCmd(string Json)
		{
			var o_json = JsonConvert.DeserializeObject<para_部門収支>(Json);
			if (String.IsNullOrEmpty(o_json.dispName)) o_json.dispName = "";
			string[] work = o_json.dispName.Split('/');

			string 統括 = (work.Length > 0 ? work[0] : "");
			string 部   = (work.Length > 1 ? work[1] : "");
			string 課   = (work.Length > 2 ? work[2] : "");
			string secMode = o_json.secMode;
			int fixLevel = o_json.fix;
			int year = o_json.year;
			確定日情報 Buff = 確定日(year, DateTime.Today, o_json.yosoku);
			int s_yymm = Buff.s_yymm;
			int c_yymm = Buff.c_yymm;
			int actualCnt = Buff.actualCnt;
			int yosokuCnt = Buff.yosokuCnt;

			List<string> funcList = new List<string>() { "計画", "計画", "計画", "計画", "計画", "計画", "計画", "計画", "計画", "計画", "計画", "計画" };
			var ii = 0;
			for (var i = 0; i < actualCnt; i++, ii++)
			{
				funcList[ii] = "実績";
			}
			for (var j = 0; j < yosokuCnt; j++, ii++)
			{
				funcList[ii] = "予測";
			}
			cmd_部門収支 cmd = new cmd_部門収支()
			{
				year = year,
				fixLevel = fixLevel,
				secMode = secMode,
				s_yymm = s_yymm,
				c_yymm = c_yymm,
				actualCnt = actualCnt,
				yosokuCnt = yosokuCnt,
				統括 = 統括,
				部 = 部,
				課 = 課,
				guide = Buff.guide,
				funcList = funcList
			};

			switch (o_json.secMode+o_json.dispCmd)
			{
				case "EMG":
					cmd.title = "EMG";
					cmd.dispMode = "全社";
					cmd.統括 = "EMG";
					cmd.listMode = "詳細";
					cmd.secMode = "";
					cmd.haifuMode = false;
					break;
				case "開発統括一覧":
					cmd.dispMode = "統括";
					cmd.listMode = "一覧";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "開発部門一覧":
					;
					cmd.dispMode = "部門";
					cmd.listMode = "一覧";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					cmd.統括 = 統括;
					break;
				case "開発課一覧":
					cmd.dispMode = "グループ";
					cmd.listMode = "一覧";
					cmd.secMode = "開発";
					cmd.haifuMode = true;        // 課に対しては計算しない
					cmd.統括 = 統括;
					cmd.部 = 部;
					break;
				case "開発統括詳細":
					cmd.dispMode = "統括";
					cmd.統括 = 統括;
					cmd.listMode = "詳細";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					break;
				case "開発部門詳細":
					cmd.dispMode = "部門";
					cmd.listMode = "詳細";
					cmd.secMode = "開発";
					cmd.haifuMode = true;
					cmd.統括 = 統括;
					cmd.部 = 部;
					break;
				case "開発課詳細":
					cmd.dispMode = "グループ";
					cmd.listMode = "詳細";
					cmd.secMode = "開発";
					cmd.haifuMode = true;        // 課に対しては計算しない
					cmd.統括 = 統括;
					cmd.部 = 部;
					cmd.課 = 課;
					break;
				case "間接部門一覧":
					cmd.dispMode = "部門";
					cmd.listMode = "一覧";
					cmd.secMode = "間接";
					cmd.haifuMode = false;
					break;
				case "間接課一覧":
					cmd.dispMode = "グループ";
					cmd.listMode = "一覧";
					cmd.secMode = "間接";
					cmd.haifuMode = false;
					cmd.統括 = 統括;
					cmd.部 = 部;
					break;
				case "間接部門詳細":
					cmd.dispMode = "部門";
					cmd.listMode = "詳細";
					cmd.secMode = "間接";
					cmd.haifuMode = false;
					cmd.統括 = 統括;
					cmd.部 = 部;
					break;
				case "間接課詳細":
					cmd.dispMode = "グループ";
					cmd.listMode = "詳細";
					cmd.secMode = "間接";
					cmd.haifuMode = false;
					cmd.統括 = 統括;
					cmd.部 = 部;
					cmd.課 = 課;
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
				default:
					break;
			}
			return (cmd);
		}
		void meke_JoinData(Dictionary<string, dynamic> Tab)
		{
			Dictionary<string, dynamic> dataTab = Tab["data"];
            cmd_部門収支 cmd = Tab["Info"];
			List<string> func = new List<string>() { "実績", "予測", "計画" };
			string secName, funcName, 大項目, 項目;
			foreach (KeyValuePair<string, dynamic> item in dataTab)
            {
				secName = item.Key;
				foreach (KeyValuePair<string, dynamic> item1 in dataTab[secName])
                {
					funcName = item1.Key;
					if ( !func.Contains(funcName) ) continue;
					foreach (KeyValuePair<string, dynamic> item2 in dataTab[secName][funcName])
                    {
						大項目 = item2.Key;
						foreach (KeyValuePair<string, dynamic> item3 in dataTab[secName][funcName][大項目])
                        {
							項目 = item3.Key;
							checkArray(dataTab, secName, "結合", 大項目, 項目);
							for (var i = 0; i < 12; i++)
							{
                                if (funcName == cmd.funcList[i])
                                {
									dataTab[secName]["結合"][大項目][項目][i] = dataTab[secName][funcName][大項目][項目][i];
								}
							}
						}
					}
				}
			}
		}
		//=====================================================================================

		void 本社費配賦(cmd_部門収支 cmd, Dictionary<string, dynamic> dataTab)
		{
			var actualCnt = cmd.actualCnt;
			var year = cmd.year;

            if (actualCnt == 0) return;
            foreach (KeyValuePair<string, dynamic> item in dataTab)
            {
				string S_name = item.Key;
				if (S_name == "本社")
				{
					checkArray(dataTab, S_name, "計画", "予算", "予算");
                    checkArray(dataTab, S_name, "予測", "予算", "予算");
                    checkArray(dataTab, S_name, "実績", "予算", "予算");
                    calcTargetPlan(cmd, dataTab[S_name]);
				}
			}
            calcHaifu(cmd, dataTab);

        }

		void calcTargetPlan(cmd_部門収支 cmd, Dictionary<string, dynamic> Tab)
        {
			// 支出の部
			string[] itemStr_O = "売上原価,販管費,営業外費用".Split(',');
			for(int iNum = 0; iNum< itemStr_O.Length; iNum++)
			{
				string item = itemStr_O[iNum];
				if (!Tab["計画"].ContainsKey(item)) continue;
				foreach (var itemx in Tab["計画"][item])
				{
					string kind = itemx.Key;
					copyArray(Tab["計画"]["予算"]["予算"], Tab["計画"][item][kind], "+",12);
					copyArray(Tab["予測"]["予算"]["予算"], Tab["計画"][item][kind], "+",12);
					copyArray(Tab["実績"]["予算"]["予算"], Tab["計画"][item][kind], "+",12);
				}
			}
			// 収入の部
			var itemStr_I = "営業外収益,費用付替,売上付替".Split(',');
            for (int iNum = 0; iNum < itemStr_I.Length; iNum++)
            {
                string item = itemStr_I[iNum];
				if (!Tab["計画"].ContainsKey(item)) continue;
				foreach (var itemx in Tab["計画"][item])
                {
                    string kind = itemx.Key;
					copyArray(Tab["計画"]["予算"]["予算"], Tab["計画"][item][kind], "-",12);
					copyArray(Tab["予測"]["予算"]["予算"], Tab["計画"][item][kind], "-",12);
					copyArray(Tab["実績"]["予算"]["予算"], Tab["計画"][item][kind], "-",12);
				}
			}
			//	本社計画値から本社売上を引く
			//	表示から売上を引いた数値にするため
			copyArray(Tab["計画"]["予算"]["予算"], Tab["計画"]["売上高"]["売上"], "-",12);
			copyArray(Tab["予測"]["予算"]["予算"], Tab["計画"]["売上高"]["売上"], "-",12);
			copyArray(Tab["実績"]["予算"]["予算"], Tab["計画"]["売上高"]["売上"], "-",12);
		}
		void calcHaifu(cmd_部門収支 cmd, Dictionary<string, dynamic> dataTab)
		{

			double partUnit = 1;
			double guestUnit = 1;
			if (cmd.year <= 2008)
			{                               // - 2008
				partUnit = 0.25;
				guestUnit = 0.25;
			}
			else if (cmd.year >= 2009 && cmd.year <= 2010)
			{       // 2009 - 2010
				partUnit = 0.01;
				guestUnit = 0.01;
			}
			else if (cmd.year >= 2011 && cmd.year <= 2015)
			{           // 2011 - 2015
				partUnit = 0.03;
				guestUnit = 0.03;
			}
			else if (cmd.year >= 2016)
			{                       // 2016 -
				partUnit = 1.0;
				guestUnit = 0.10;
			}
			else
			{
				partUnit = 1.0;
				guestUnit = 0.10;
			}
			List<string> funcList = new List<string>() { "計画", "予測", "実績" };
			foreach(string func in funcList)
            {
				// 配賦対象額の作成
				checkArray(dataTab, "本社", "配賦", func, "本社予算");
				checkArray(dataTab, "本社", "配賦", func, "売上");
				checkArray(dataTab, "本社", "配賦", func, "固定費合計");
				checkArray(dataTab, "本社", "配賦", func, "配賦対象");
				checkArray(dataTab, "本社", "配賦", func, "販管人件費");
				checkArray(dataTab, "本社", "配賦", func, "販管雑給");
				checkArray(dataTab, "本社", "配賦", func, "原価外注費");
				checkArray(dataTab, "本社", "配賦", func, "固定人件費");
				
				copyArray(dataTab["本社"]["配賦"][func]["本社予算"], dataTab["本社"]["計画"]["予算"]["予算"], "+", 12);
                copyArray(dataTab["本社"]["配賦"][func]["売上"], dataTab["本社"]["計画"]["売上高"]["売上"], "+", 12);

				// 部門の固定費合計
				foreach (var x in dataTab["直接"][func]["部門固定費"])
				{
					string item = x.Key;
					copyArray(dataTab["本社"]["配賦"][func]["固定費合計"], dataTab["直接"][func]["部門固定費"][item], "+", 12);
				}
				// 配賦対象額の算出
				copyArray(dataTab["本社"]["配賦"][func]["配賦対象"], dataTab["本社"]["配賦"][func]["本社予算"], "+", 12);
				copyArray(dataTab["本社"]["配賦"][func]["配賦対象"], dataTab["本社"]["配賦"][func]["固定費合計"], "-", 12);

				// 部門の計算の分母作成
				copyArray(dataTab["本社"]["配賦"][func]["販管人件費"], dataTab["直接"][func]["販管費"]["人件費"], "+", 12);
				copyArray(dataTab["本社"]["配賦"][func]["販管雑給"], dataTab["直接"][func]["販管費"]["雑給"], "+", 12);
				copyArray(dataTab["本社"]["配賦"][func]["原価外注費"], dataTab["直接"][func]["売上原価"]["外注費"], "+", 12);
				copyArray(dataTab["本社"]["配賦"][func]["固定人件費"], dataTab["直接"][func]["部門固定費"]["人件費"], "+", 12);

						// 部門の計算
				foreach(var x in dataTab)
				{
					string secName = x.Key;
					if (secName == "本社" || secName == "直接") continue;
					checkArray(dataTab, secName, "配賦", func, "販管人件費");
					checkArray(dataTab, secName, "配賦", func, "販管雑給");
					checkArray(dataTab, secName, "配賦", func, "原価外注費");
					checkArray(dataTab, secName, "配賦", func, "固定人件費");

					checkArray(dataTab, secName, func, "販管費", "人件費");
					checkArray(dataTab, secName, func, "販管費", "雑給");
					checkArray(dataTab, secName, func, "部門固定費", "人件費");
					checkArray(dataTab, secName, func, "売上原価", "外注費");

					copyArray(dataTab[secName]["配賦"][func]["販管人件費"], dataTab[secName][func]["販管費"]["人件費"], "+", 12);
					copyArray(dataTab[secName]["配賦"][func]["販管雑給"], dataTab[secName][func]["販管費"]["雑給"], "+", 12);
					copyArray(dataTab[secName]["配賦"][func]["固定人件費"], dataTab[secName][func]["部門固定費"]["人件費"], "+", 12);
					copyArray(dataTab[secName]["配賦"][func]["原価外注費"], dataTab[secName][func]["売上原価"]["外注費"], "+", 12);
				}
				foreach(var x in dataTab)
				{
					string secName = x.Key;
					if (secName == "直接") continue;
					checkArray(dataTab, secName, "配賦", func, "計算額");
					copyArray(dataTab[secName]["配賦"][func]["計算額"], dataTab[secName]["配賦"][func]["販管人件費"], "+", 12);
					if (cmd.year >= 2013)
					{
						copyArray(dataTab[secName]["配賦"][func]["計算額"], dataTab[secName]["配賦"][func]["固定人件費"], "+", 12);
					}
					for( int m = 0; m < 12; m++)
                    {
						dataTab[secName]["配賦"][func]["計算額"][m] += (dataTab[secName]["配賦"][func]["販管雑給"][m] * partUnit);
						dataTab[secName]["配賦"][func]["計算額"][m] += (dataTab[secName]["配賦"][func]["原価外注費"][m] * guestUnit);
					}
				}
						// 分配の計算
				foreach(var x in dataTab)
				{
					string secName = x.Key;
					if (secName == "本社" || secName == "直接") continue;
					checkArray(dataTab, secName, "配賦", func, "分配率");
					for (int m = 0; m < 12; m++)
                    {
						dataTab[secName]["配賦"][func]["分配率"][m] = dataTab[secName]["配賦"][func]["計算額"][m] / dataTab["本社"]["配賦"][func]["計算額"][m];
					}
				}
					// 分配の計算

				foreach(var x in dataTab)
				{
					string secName = x.Key;
					if (secName == "本社" || secName == "直接") continue;
					checkArray(dataTab, secName, func, "本社費配賦", "本社費");
					for (int m = 0; m < 12; m++)
                    {
						double value = dataTab["本社"]["配賦"][func]["配賦対象"][m] * dataTab[secName]["配賦"][func]["分配率"][m];
						dataTab[secName][func]["本社費配賦"]["本社費"][m] = value;
					}
				}
			}
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



		Dictionary<string, dynamic> initTab(cmd_部門収支 o_json)
		{
			Dictionary<string, dynamic> Tab = new Dictionary<string, dynamic>();
			Dictionary<string, object> Info = new Dictionary<string, object>();
			Dictionary<string, object> Data = new Dictionary<string, object>();
			projectInfo jProc = new projectInfo();

            //string Json = "{year:'2020',secMode:'開発',dispMode:'グループ'}";
            //var o_json = JsonConvert.DeserializeObject<cmd_部門収支>(Json);

            try
		{
			Dictionary<string, group> secTab = jProc.json_部門リスト_sub(o_json);
			string dispName = "";
            if (o_json.dispMode == "全社")
            {
                Tab.Add("全社", costList(名前: "EMG", 直間: "0,1,2", 統括: "", 部門: "", 課: "", 部署コード: ""));
            }
			else if (o_json.secMode == "開発" && o_json.listMode == "一覧" && o_json.dispMode == "統括")
			{
				foreach (string secName in secTab.Keys)
				{
					group sec = secTab[secName];
					dispName = sec.統括;
					Tab.Add(secName, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					DebugHost.Debug.noWrite("統括", secName);
				}
				Tab.Add("本社", costList(名前: "本社", 直間: "2", 統括: "", 部門: "", 課: "", 部署コード: ""));
				Tab.Add("直接", costList(名前: "", 直間: "0,1", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.secMode == "開発" && o_json.listMode == "詳細" && o_json.dispMode == "統括")
			{
				foreach (string secName in secTab.Keys)
				{
					group sec = secTab[secName];
					dispName = (sec.統括 == o_json.統括 ? sec.統括 : "");
					Tab.Add(secName, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					DebugHost.Debug.noWrite("統括", secName);
				}
				Tab.Add("本社", costList(名前: "", 直間: "2", 統括: "", 部門: "", 課: "", 部署コード: ""));
				Tab.Add("直接", costList(名前: "", 直間: "0,1", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.secMode == "開発" && o_json.listMode == "一覧" && o_json.dispMode == "部門")
			{
				foreach (string secName in secTab.Keys)
				{
					group secList = secTab[secName];
					var sec = secList;
					dispName = string.Concat(sec.統括, sec.部門);
					Tab.Add(secName, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.code));
					DebugHost.Debug.noWrite("部門", secName);
					foreach (string 部門 in secList.list.Keys)
					{
						sec = secList.list[部門];
						dispName = string.Concat(sec.統括, sec.部門);
						Tab.Add(部門, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
						DebugHost.Debug.noWrite("部門", 部門);
					}
				}

				Tab.Add("本社", costList(名前: "", 直間: "2", 統括: "", 部門: "", 課: "", 部署コード: ""));
				Tab.Add("直接", costList(名前: "", 直間: "0,1", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.secMode == "開発" && o_json.listMode == "詳細" && o_json.dispMode == "部門")
			{
				foreach (string secName in secTab.Keys)
				{
					group secList = secTab[secName];
					var sec = secList;
					dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 ? string.Concat(sec.統括, sec.部門) : "");
					Tab.Add(secName, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.code));
					DebugHost.Debug.noWrite("部門", secName);
					foreach (string 部門 in secList.list.Keys)
					{
						sec = secList.list[部門];
						dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 ? string.Concat(sec.統括, sec.部門) : "");
						Tab.Add(部門, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
						DebugHost.Debug.noWrite("部門", 部門);
					}
				}

				Tab.Add("本社", costList(名前: "", 直間: "2", 統括: "", 部門: "", 課: "", 部署コード: ""));
				Tab.Add("直接", costList(名前: "", 直間: "0,1", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.secMode == "開発" && o_json.listMode == "一覧" && o_json.dispMode == "グループ")
			{
				group secList = secTab[o_json.統括].list[o_json.部];
				var sec = secList;
				string secName = o_json.部;
				DebugHost.Debug.noWrite("課", secName);
				dispName = string.Concat(sec.統括, sec.部門, sec.課);
				Tab.Add(o_json.部, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.code));
				foreach (string 課 in secList.list.Keys)
				{
					sec = secList.list[課];
					dispName = string.Concat(sec.統括, sec.部門, sec.課);
					Tab.Add(課, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					DebugHost.Debug.noWrite("課", 課);
				}
				Tab.Add("本社", costList(名前: "", 直間: "2", 統括: "", 部門: "", 課: "", 部署コード: ""));
				Tab.Add("直接", costList(名前: "", 直間: "0,1", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.secMode == "開発" && o_json.listMode == "詳細" && o_json.dispMode == "グループ")
			{
				group secList = secTab[o_json.統括].list[o_json.部];
				var sec = secList;
				string secName = o_json.部;
				dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 && sec.課 == o_json.課 ? string.Concat(sec.統括, sec.部門, sec.課) : "");
				DebugHost.Debug.noWrite("課", secName);
				Tab.Add(o_json.部, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.code));
				foreach (string 課 in secList.list.Keys)
				{
					sec = secList.list[課];
					dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 && sec.課 == o_json.課 ? string.Concat(sec.統括, sec.部門, sec.課) : "");
					Tab.Add(課, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					DebugHost.Debug.noWrite("課", 課);
				}
				Tab.Add("本社", costList(名前: "", 直間: "2", 統括: "", 部門: "", 課: "", 部署コード: ""));
				Tab.Add("直接", costList(名前: "", 直間: "0,1", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}

			else if (o_json.secMode == "間接" && o_json.listMode == "一覧" && o_json.dispMode == "部門")
			{
				foreach (string secName in secTab.Keys)
				{
					group secList = secTab[secName];

					foreach (string 部門 in secList.list.Keys)
					{
						var sec = secList.list[部門];
						dispName = string.Concat(sec.統括, sec.部門);
						Tab.Add(部門, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
						DebugHost.Debug.noWrite("部門", 部門);
					}
				}
			}
			else if (o_json.secMode == "間接" && o_json.listMode == "詳細" && o_json.dispMode == "部門")
			{
				foreach (string secName in secTab.Keys)
				{
					group secList = secTab[secName];

					foreach (string 部門 in secList.list.Keys)
					{
						var sec = secList.list[部門];
						dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 ? string.Concat(sec.統括, sec.部門) : "");
						Tab.Add(部門, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
						DebugHost.Debug.noWrite("部門", 部門);
					}
				}
			}
			else if (o_json.secMode == "間接" && o_json.listMode == "一覧" && o_json.dispMode == "グループ")
			{
				group secList = secTab[o_json.統括].list[o_json.部];
				var sec = secList;
				string secName = o_json.部;
				DebugHost.Debug.noWrite("課", secName);
				dispName = string.Concat(sec.統括, sec.部門);
				Tab.Add(o_json.部, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.code));
				foreach (string 課 in secList.list.Keys)
				{
					sec = secList.list[課];
					dispName = string.Concat(sec.統括, sec.部門);
					Tab.Add(課, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					DebugHost.Debug.noWrite("課", 課);
				}
			}
			else if (o_json.secMode == "間接" && o_json.listMode == "詳細" && o_json.dispMode == "グループ")
			{
				group secList = secTab[o_json.統括].list[o_json.部];
				var sec = secList;
				string secName = o_json.部;
				DebugHost.Debug.noWrite("課", secName);
				dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 && sec.課 == o_json.課 ? string.Concat(sec.統括, sec.部門, sec.課) : "");
				Tab.Add(o_json.部, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.code));
				foreach (string 課 in secList.list.Keys)
				{
					sec = secList.list[課];
					dispName = (sec.統括 == o_json.統括 && sec.部門 == o_json.部 && sec.課 == o_json.課 ? string.Concat(sec.統括, sec.部門, sec.課) : "");
					Tab.Add(課, costList(名前: dispName, 直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					DebugHost.Debug.noWrite("課", 課);
				}
			}
			foreach (var item in Tab)
			{
				string secName = item.Key;
				checkArray(Tab, secName, "予測", "売上高", "売上");
				checkArray(Tab, secName, "予測データ", "売上予測", "確度70");
				checkArray(Tab, secName, "予測データ", "売上予測", "確度50");
				checkArray(Tab, secName, "予測データ", "売上予測", "確度30");
				checkArray(Tab, secName, "予測データ", "売上予測", "確度10");
			}
			}catch(Exception ex)
            {
				DebugHost.Debug.Write(ex.Message);
            }
			return (Tab);
		}
		public Dictionary<string, object> costList(string 名前, string 直間, string 統括, string 部門, string 課, string 部署コード)
		{

			Dictionary<string, object> Tab = new Dictionary<string, object>();
			string 種別 = (直間 == "2" ? "間接" : "直接");
			Tab.Add("名前", 名前);
			Tab.Add("種別", 種別);
			Tab.Add("直間", 直間);
			Tab.Add("部署名", new secInfo(統括, 部門, 課));
			Tab.Add("部署コード", 部署コード);
			Tab.Add("結合", new Dictionary<string, dynamic>());
			Tab.Add("計画", new Dictionary<string, dynamic>());
			Tab.Add("予測", new Dictionary<string, dynamic>());
			Tab.Add("実績", new Dictionary<string, dynamic>());
			Tab.Add("予測データ", new Dictionary<string, dynamic>());
            Tab.Add("配賦", new Dictionary<string, dynamic>());

            return (Tab);
		}
		void checkNode(XmlDocument xmlDoc, string secName, string funcName, string 大項目, string 項目, double[] values)
		{

			XmlNode rootNode = xmlDoc.SelectSingleNode("/root");
			XmlNodeList targetsecNodeList = rootNode.SelectNodes("全体/グループ");
			XmlNode SecNode = rootNode.SelectSingleNode("全体/グループ[@target='" + secName + "']");
			XmlNode Node;
			if (funcName == "予測データ")
			{
				Node = rootNode.SelectSingleNode("全体/グループ[@target='" + secName + "']/予測データ/" + 大項目 + "/項目[@name='" + 項目 + "']");

			}
			else
			{
				Node = rootNode.SelectSingleNode("全体/グループ[@target='" + secName + "']/データ[@name='" + funcName + "']/" + 大項目 + "/項目[@name='" + 項目 + "']");

			}
			if (Node == null)
			{
				DebugHost.Debug.Write(string.Concat("対象無し：[", secName, "][", funcName, "][", 大項目, "][", 項目, "]"));
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
		void copyArray(double[] destArray, double[] srcArray, string mode, int mCnt)
		{
			for (var m = 0; m < mCnt; m++)
			{
				if (mode == "-") destArray[m] -= srcArray[m];
				else if (mode == "+") destArray[m] += srcArray[m];
				else destArray[m] = srcArray[m];
			}
		}

		Dictionary<string, dynamic> checkArray_X(Dictionary<string, dynamic> Tab, string 部門, string 種別, string 大項目, string 項目)
		{
			//DebugHost.Debug.noWrite("確認");
			if (大項目 == "")
			{
				DebugHost.Debug.noWrite("XX");
			}
			try
			{
				if (Tab[部門][種別][大項目].ContainsKey(項目))
				{
					return (Tab);
				}
			}
			catch (Exception ex)
			{
				DebugHost.Debug.noWrite(ex.Message);
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
					Tab[部門][種別][大項目].Add(項目, new Dictionary<string, double[]>());
				}
			}
			Tab[部門][種別][大項目][項目] = new double[12];
			return (Tab);
		}
		Dictionary<string, dynamic> checkArray(Dictionary<string, dynamic> Tab, string 部門, string 種別, string 大項目, string 項目)
		{
			//DebugHost.Debug.noWrite("確認");
			if (大項目 == "")
			{
				DebugHost.Debug.noWrite("XX");
			}
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
				Tab[部門][種別][大項目].Add(項目, new Dictionary<string, double[]>());
				Tab[部門][種別][大項目][項目] = new double[12];
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
		int dayChkX(int yymm, int adjustDayCnt)
		{

			int yy = yymm / 100;
			int mm = yymm % 100;
			Dictionary<DateTime, bool> dBuff = new Dictionary<DateTime, bool>();
			DateTime sDate = new DateTime(yy, mm, 1);
			DateTime eDate = sDate.AddMonths(1).AddDays(-1);
			DateTime curDate = sDate;
			do
			{
				dBuff.Add(curDate, "0,6".Contains(curDate.DayOfWeek.ToString("d")));            // "0":日 ,"6":土
				curDate = curDate.AddDays(1);
			} while (curDate <= eDate);


			string SQL = "";
			StringBuilder sql = new StringBuilder("");

			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			sql.Append(" SELECT *");
			sql.Append(" FROM EMG.dbo.勤務出勤日");
			sql.Append(" WHERE 日付 BETWEEN @sDate AND @eDate");
			sql.Append(" AND memberID = 0");

			sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
			sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
			SQL = sql.ToString();
			DateTime targetDay;
			bool offDay;
			SqlDataReader reader = dbRead(DB, SQL);
			while (reader.Read())
			{
				targetDay = (DateTime)reader["日付"];
				offDay = (bool)reader["offDay"];
				if (dBuff.ContainsKey(targetDay)) dBuff[targetDay] = offDay;
			}
			reader.Close();
			DB.Close();
			DB.Dispose();

			int Cnt = 0;
			DateTime target = new DateTime();
			foreach (DateTime n in dBuff.Keys)
			{
				target = n;
				if (dBuff[n] == false) Cnt++;           // 出勤日を数える
				if (Cnt > adjustDayCnt) break;
			}
			return (target.Day);
		}

		確定日情報 確定日(int year, DateTime d, int? yosokuCnt)
		{
			//			int adjustDayCnt = 7;

			projectInfo pInfo = new projectInfo();
//			DateTime d = DateTime.Today;
			int yymm = (d.Year * 100) + d.Month;
			int OKday = pInfo.dayChk(yymm);
			yymm = (d.Day < OKday ? yymmAdd(yymm, -1) : yymmAdd(yymm, 0));      // データ有効月の計算(12日以前は前々月)

			int b_yymm = ((year - 1) * 100) + 10;

			int actualCnt = yymmDiff(b_yymm, yymm);

			if (actualCnt >= 12) actualCnt = 12;
			if (actualCnt < 0  ) actualCnt = 0;

			if (!yosokuCnt.HasValue)        // nullの時
			{
				yosokuCnt = 12 - actualCnt;
			}
			else
			{
				if (yosokuCnt == 0)
				{
					//	すべて計画
					actualCnt = 0;
					yosokuCnt = 0;
				}
				else if (yosokuCnt < 0)
				{
					// 残り全て予測
					yosokuCnt = 12 - actualCnt;
				}
                else
                {
					yosokuCnt = 12 - actualCnt;
				}
			}

			string Buff = "";
			var dispCnt = 12;
			var s_yymm = ((year - 1) * 100) + 10;


			// 次回の確定日のお知らせ
			int c_yymm=0, c_yy, c_mm, n_yymm, n_yy=0, n_mm, n_dd=0;
			if (actualCnt > 0 && actualCnt < dispCnt)
			{
				c_yymm = yymmAdd(s_yymm, actualCnt);
				c_yy = c_yymm / 100;
				c_mm = c_yymm % 100;
				n_yymm = yymmAdd(c_yymm, 1);
				n_yy = n_yymm / 100;
				n_mm = n_yymm % 100;
				n_dd = pInfo.dayChk(n_yymm);

				Buff = String.Concat(c_yy, "年", c_mm, "月の実績表示は", n_yy, "年", n_mm, "月", n_dd, "日以降です");
			}
			else if (actualCnt == dispCnt)
			{
				Buff = "(すべて実績データです)";
			}
			else
			{
				Buff = "実績データはありません";
			}
			確定日情報 work = new 確定日情報();
			work.year = n_yy;
			work.day = n_dd;
			work.s_yymm = s_yymm;
			work.c_yymm = c_yymm;
			work.guide = Buff;
			work.actualCnt = actualCnt;
			work.yosokuCnt = (int)yosokuCnt;

			return (work);
		}
		class 確定日情報
        {
			public int year { get; set; }
			public int day { get; set; }
			public int s_yymm { get; set; }
			public int c_yymm { get; set; }
			public int actualCnt { get; set; }
			public int yosokuCnt { get; set; }
			public string guide { get; set; }

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

