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
		object initTab(String Json)
        {
			Dictionary<string, costList> Tab = new Dictionary<string, costList>();
			Dictionary<string, object> Info = new Dictionary<string, object>();
			Dictionary<string, object> Data = new Dictionary<string, object>();
			jsonProc jProc = new jsonProc();

			Json = "{year:'2020',secMode:'開発',dispMode:'グループ'}";
			var o_json = JsonConvert.DeserializeObject<para_部門指定>(Json);

			Dictionary<string, group> secTab = jProc.json_部門リスト(Json);

			if (o_json.dispMode == "全社")
			{
				Tab.Add("全社", new costList(直間: "0,1,2", 統括: "", 部門: "", 課: "", 部署コード: ""));
			}
			else if (o_json.dispMode == "統括")
			{
				foreach (string 統括 in secTab.Keys)
				{
					group sec = secTab[統括];
					Tab.Add(統括, new costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					Debug.Write(統括, secTab[統括].codes);
				}
			}
			else if (o_json.dispMode == "部門")
			{
                group sec = secTab["開発本部"];

                foreach (string 部門 in sec.list.Keys)
                {
                    var x = sec.list[部門];
					Tab.Add(部門, new costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(部門, sec.list[部門].codes);
                }
            }
			else if (o_json.dispMode == "グループ")
			{
                group sec = secTab["開発本部"].list["第1開発部"];
                foreach (string 課 in sec.list.Keys)
                {
                    var x = sec.list[課];
					Tab.Add(課, new costList(直間: sec.直間, 統括: sec.統括, 部門: sec.部門, 課: sec.課, 部署コード: sec.codes));
					//Debug.Write(課, sec.list[課].codes);
                }
            }
			return (Tab);
		}
		public object json_部門収支_XML(String Json)
        {

			var Tab = initTab(Json);

			List<string> x = new List<string>();
			x.Add("ABC");
			x.Add("XYZ");
			x.Add("123");
			var z = string.Join(":", x);

			StringBuilder sql = new StringBuilder("");
			/*
			sql.Append(" SELECT");
			sql.Append("      S_name = @S_name");
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
			if (Tab[S_name]["部署コード"].length > 0)
			{
				sql.Append("    AND");
				sql.Append("    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")");
			}
			if (Tab[S_name]["直間"] != "")
			{
				sql.Append("    AND");
				sql.Append("    MAST.直間 IN(" + Tab[S_name]["直間"] + ")");
			}
			sql.Append(" GROUP BY");
			sql.Append("      MAST.直間,");
			sql.Append("      ITEM.大項目,");
			sql.Append("      ITEM.項目,");
			sql.Append("      DATA.種別,");
			sql.Append("      DATA.yymm");
*/
			return (Tab);
        }
        public XmlDocument 部門収支_XML(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            object json_data = json_部門収支_XML(Json);
            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }
		/*
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "      大項目 = ITEM.大項目,"
		SQL += "      項目   = ITEM.項目,"
		SQL += "      種別   = (CASE WHEN DATA.種別 = 0 THEN '計画' ELSE '予測' END),"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.数値)"
		SQL += " FROM"
		SQL += "      収支計画データ DATA "
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                          ON DATA.部署ID = MAST.部署コード"
		SQL += "                     LEFT JOIN 収支項目マスタ ITEM"
		SQL += "                          ON DATA.項目ID = ITEM.ID"
		SQL += " WHERE"
		SQL += "      ITEM.大項目 NOT IN('部門固定費','要員数')"
		SQL += "      AND"
		SQL += "      DATA.種別 IN(0,1)"				// 計画・予測
		SQL += "      AND"
		SQL += "      MAST.ACCコード >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "      ITEM.大項目,"
		SQL += "      ITEM.項目,"
		SQL += "      DATA.種別,"
		SQL += "      DATA.yymm"
		SQLTab.push(SQL)
		}
	SQL = SQLTab.join(" UNION ALL ")



         */

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
		class SampleData
        {
            public string a { get; set; }
            public string b { get; set; }
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
