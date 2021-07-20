using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class 部門収支 : hostProc
    {
        public object 部門収支_XML_json(String Json)
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Dictionary<string, object> Info = new Dictionary<string, object>();
            Dictionary<string, object> Data = new Dictionary<string, object>();

            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Info.Add("mName", mName);
            Info.Add("className", className);
            Info.Add("methodName", methodName);
            Info.Add("DB_Conn", DB_connectString);

            Tab.Add("Info", (object)Info);
            Tab.Add("Data", (object)Data);

            return (Tab);
        }
        public XmlDocument 部門収支_XML(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            object json_data = 部門収支_XML_json(Json);
            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            return (xmlDoc);
        }
        /*
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
