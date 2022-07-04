<%@ LANGUAGE="JavaScript" %>
<!--#include FILE="cmn.inc"-->
<%var public_description = new srvConst();RSDispatch();%>
<!--#INCLUDE VIRTUAL="/_ScriptLibrary/RS.ASP"-->

<SCRIPT RUNAT=SERVER LANGUAGE="JavaScript">
function srvConst()
   {
//EMGLog.Write("bbs.txt","==== bbsDB ====" + Session("memberName1") + Session("memberName2") )
// プロジェクト編集用
   this.bbsAddList     = bbsAddList;
   this.bbsEditList    = bbsEditList;

   this.bbsJoinAdd     = bbsJoinAdd;
   this.bbsJoinParent  = bbsJoinParent;
   this.bbsJoinRename  = bbsJoinRename;
   
// グループ編集用
   this.regGrpEdit     = regGrpEdit;
   this.regGrpAdd      = regGrpAdd;
   this.regGrpDel      = regGrpDel;

// 情報表示用
   this.getGroupList   = getGroupList;
   this.getProjectInfo = getProjectInfo;
   this.getHistoryInfo = getGroupHistoryInfo;
   this.getSalesInfo   = getSalesHistoryInfo;

   this.getCorpList    = getCorpList;
   this.getKindList    = getKindList;

   this.getMemberList  = getMemberList;


   }
</Script>

<%
function getMemberList(targetStr,memberName)
   {
try{
	var DB = Server.CreateObject("ADODB.Connection")
	var RS = Server.CreateObject("ADODB.Recordset")
	
	DB.Open( Session("ODBC") )
	DB.DefaultDatabase = "EMG"

	var mTab = new Object
	var zoku = 0
	var zName = ""

//=== 社員名簿(指定グループ) =======
//	指定グループを先頭に持ってくる
	SQL  = " SELECT"
	SQL += "    Name1    = MAST.姓,"
	SQL += "    Name2    = MAST.名,"
	SQL += "    Name1Y   = MAST.姓よみ,"
	SQL += "    Name2Y   = MAST.名よみ,"
	SQL += "    memberID = MAST.社員ＩＤ,"
	SQL += "    Corp     = MAST.社籍,"
	SQL += "    Part     = MAST.外注,"
	SQL += "    ZOKU     = ZOKU.部署ID,"
	SQL += "    YAKU     = YAKU.役職ID,"
	SQL += "    ZNAME    = ZMAST.部署名,"
	SQL += "    YNAME    = YMAST.役職呼び名"
	SQL += " FROM"
	SQL += "    社員基礎データ MAST LEFT JOIN 社員役職データ YAKU  ON MAST.社員ID = YAKU.社員ID"
	SQL += "                        LEFT JOIN 社員部署データ ZOKU  ON MAST.社員ID = ZOKU.社員ID"
	SQL += "                        LEFT JOIN 部署マスタ    ZMAST  ON ZOKU.部署ID = ZMAST.部署コード"
	SQL += "                        LEFT JOIN 役職マスタ    YMAST  ON YAKU.役職ID = YMAST.役職コード"

	SQL += " WHERE"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN MAST.入社年月日 AND MAST.退職年月日 OR MAST.退職年月日 IS NULL)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.開始 AND YAKU.終了 AND YAKU.兼務 = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.開始 AND YAKU.終了)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.開始 AND ZOKU.終了 AND ZOKU.兼務 = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.開始 AND ZOKU.終了)"
	SQL += "    AND"
	SQL += "    (ZMAST.ACCコード >= -1 OR ZMAST.部署コード=1)"
	SQL += "    AND"
	SQL += "    ZMAST.部署名 LIKE '%" + targetStr + "%'"
	SQL += " ORDER BY"
	SQL += "   ZMAST.直間,"
	SQL += "   ZMAST.部署名,"
	SQL += "   YAKU.役職ID,"
	SQL += "   MAST.姓よみ,MAST.名よみ"
	RS = DB.Execute(SQL)
	while( !RS.EOF ){
		memberID = RS.Fields("memberID").Value
		name    = RS.Fields("Name1").Value  + "　" + RS.Fields("Name2").Value
		yomi    = RS.Fields("Name1Y").Value  + "　" + RS.Fields("Name2Y").Value
		part    = RS.Fields("Part").Value
		yaku    = RS.Fields("YAKU").Value
		zoku    = RS.Fields("ZOKU").Value
		yName   = RS.Fields("YNAME").Value
		zName   = RS.Fields("ZNAME").Value
		if( !IsObject(mTab[zoku]) ) mTab[zoku] = {名前:zName,data:new Object}
		mTab[zoku].data[memberID] = {mode:0,名前:name,役職:yName}
		RS.MoveNext()
		}
	RS.Close()

//=== 社員名簿 =======
	SQL  = " SELECT"
	SQL += "    Name1    = MAST.姓,"
	SQL += "    Name2    = MAST.名,"
	SQL += "    Name1Y   = MAST.姓よみ,"
	SQL += "    Name2Y   = MAST.名よみ,"
	SQL += "    memberID = MAST.社員ＩＤ,"
	SQL += "    Corp     = MAST.社籍,"
	SQL += "    Part     = MAST.外注,"
	SQL += "    ZOKU     = ZOKU.部署ID,"
	SQL += "    YAKU     = YAKU.役職ID,"
	SQL += "    ZNAME    = ZMAST.部署名,"
	SQL += "    YNAME    = YMAST.役職呼び名"
	SQL += " FROM"
	SQL += "    社員基礎データ MAST LEFT JOIN 社員役職データ YAKU  ON MAST.社員ID = YAKU.社員ID"
	SQL += "                        LEFT JOIN 社員部署データ ZOKU  ON MAST.社員ID = ZOKU.社員ID"
	SQL += "                        LEFT JOIN 部署マスタ    ZMAST  ON ZOKU.部署ID = ZMAST.部署コード"
	SQL += "                        LEFT JOIN 役職マスタ    YMAST  ON YAKU.役職ID = YMAST.役職コード"

	SQL += " WHERE"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN MAST.入社年月日 AND MAST.退職年月日 OR MAST.退職年月日 IS NULL)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.開始 AND YAKU.終了 AND YAKU.兼務 = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.開始 AND YAKU.終了)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.開始 AND ZOKU.終了 AND ZOKU.兼務 = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.開始 AND ZOKU.終了)"
	SQL += "    AND"
	SQL += "    (ZMAST.ACCコード >= -1 OR ZMAST.部署コード=1)"
	SQL += "    AND"
	SQL += "    YAKU.役職ID < 85"
	SQL += "    AND"
	SQL += "    ZMAST.部署名 NOT LIKE '%" + targetStr + "%'"
	SQL += " ORDER BY"
	SQL += "   ZMAST.直間,"
	SQL += "   ZMAST.部署名,"
	SQL += "   YAKU.役職ID,"
	SQL += "   MAST.姓よみ,MAST.名よみ"
	RS = DB.Execute(SQL)
	while( !RS.EOF ){
		memberID = RS.Fields("memberID").Value
		name    = RS.Fields("Name1").Value  + "　" + RS.Fields("Name2").Value
		yomi    = RS.Fields("Name1Y").Value  + "　" + RS.Fields("Name2Y").Value
		part    = RS.Fields("Part").Value
		yaku    = RS.Fields("YAKU").Value
		zoku    = RS.Fields("ZOKU").Value
		yName   = RS.Fields("YNAME").Value
		zName   = RS.Fields("ZNAME").Value
		if( !IsObject(mTab[zoku]) ) mTab[zoku] = {名前:zName,data:new Object}
		mTab[zoku].data[memberID] = {mode:0,名前:name,役職:yName}
		RS.MoveNext()
		}
	RS.Close()


//=== 社員名簿(退職した社員) =======
	if( memberName != "" ){
		SQL  = " SELECT"
		SQL += "    Name1    = MAST.姓,"
		SQL += "    Name2    = MAST.名,"
		SQL += "    Name1Y   = MAST.姓よみ,"
		SQL += "    Name2Y   = MAST.名よみ,"
		SQL += "    memberID = MAST.社員ＩＤ,"
		SQL += "    Corp     = MAST.社籍,"
		SQL += "    Part     = MAST.外注,"
		SQL += "    ZOKU     = ZOKU.部署ID,"
		SQL += "    YAKU     = YAKU.役職ID,"
		SQL += "    ZNAME    = ZMAST.部署名,"
		SQL += "    YNAME    = YMAST.役職呼び名"
		SQL += " FROM"
		SQL += "    社員基礎データ MAST LEFT JOIN 社員役職データ YAKU  ON MAST.社員ID = YAKU.社員ID"
		SQL += "                        LEFT JOIN 社員部署データ ZOKU  ON MAST.社員ID = ZOKU.社員ID"
		SQL += "                        LEFT JOIN 部署マスタ    ZMAST  ON ZOKU.部署ID = ZMAST.部署コード"
		SQL += "                        LEFT JOIN 役職マスタ    YMAST  ON YAKU.役職ID = YMAST.役職コード"

		SQL += " WHERE"
		SQL += "   MAST.退職 = 1"
		SQL += "   AND"
		SQL += "   (MAST.姓 + MAST.名) = '" + memberName + "'"
		SQL += " ORDER BY"
		SQL += "   ZMAST.直間,"
		SQL += "   ZMAST.部署名,"
		SQL += "   YAKU.役職ID,"
		SQL += "   MAST.姓よみ,MAST.名よみ"

		RS = DB.Execute(SQL)
		if( !RS.EOF ){
			memberID = RS.Fields("memberID").Value
			name    = RS.Fields("Name1").Value  + "　" + RS.Fields("Name2").Value
			yomi    = RS.Fields("Name1Y").Value  + "　" + RS.Fields("Name2Y").Value
			part    = RS.Fields("Part").Value
			yaku    = RS.Fields("YAKU").Value
			zoku    = RS.Fields("ZOKU").Value
			yName   = RS.Fields("YNAME").Value
			zName   = "在籍社員以外"							// RS.Fields("ZNAME").Value	
			if( !IsObject(mTab[zoku]) ) mTab[zoku] = {名前:zName,data:new Object}
			mTab[zoku].data[memberID] = {mode:0,名前:name,役職:""}
			}
		RS.Close()

		}
	
	DB.Close()

	return(mTab)
}catch(e){return(e.message)}
	}

function getCorpList(groupID)
   {
   var SQL
   var DB = Server.CreateObject("ADODB.Connection");
   var RS = Server.CreateObject("ADODB.Recordset");

   DB.Open( Session("ODBC") );
   DB.DefaultDatabase = "kansaDB"

	var toDay = getDateTimeString()

   SQL  = " SELECT"
   SQL += "    部署コード"
   SQL += " FROM"
   SQL += "    EMG.dbo.部署マスタ"
	SQL += " WHERE"
    SQL += "(GETDATE() BETWEEN 開始 AND 終了) OR (DATEADD(year, -1, GETDATE()) BETWEEN 開始 AND 終了)"
//   SQL += "    '" + toDay + "' BETWEEN 開始 AND 終了"
   SQL += " GROUP BY"
   SQL += "    部署コード"
   SQL += " ORDER BY"
   SQL += "    部署コード"
   RS = DB.Execute(SQL)
	var grpTab = new Array()
	while( !RS.EOF ){
	   grpTab[grpTab.length] = RS.Fields("部署コード").Value
		RS.MoveNext()
		}
   RS.Close()


   SQL  = " SELECT"
   SQL += "    corpName"
   SQL += " FROM"
   SQL += "    projectNum"
   SQL += " WHERE"
   SQL += "    corpName IS NOT NULL"
	SQL += "    AND"
	if( groupID > 0 ){
		SQL += "    部署ID = '" + groupID + "'"
		}
	else{
		SQL += "    部署ID IN(" + grpTab.join(",") + ")"
		}
   SQL += " GROUP BY"
   SQL += "    corpName"
   SQL += " ORDER BY"
   SQL += "    corpName"
   RS = DB.Execute(SQL)
	var Tab = new Array()
	while( !RS.EOF ){
	   Tab[Tab.length] = RS.Fields("corpName").Value
		RS.MoveNext()
		}
   RS.Close()
	DB.Close()
	return(Tab)
	}
function getKindList(kindName)
   {
   var SQL
	switch(kindName){
		case "カテゴリー名1" :
			SQL  = " SELECT"
			SQL += "    分類名 = カテゴリー名1"
			SQL += " FROM"
			SQL += "    projectNum"
			SQL += " WHERE"
			SQL += "    カテゴリー名1 IS NOT NULL"
			SQL += " GROUP BY"
			SQL += "    カテゴリー名1"
			SQL += " ORDER BY"
			SQL += "    カテゴリー名1"
			break;
		case "カテゴリー名2" :
			SQL  = " SELECT"
			SQL += "    分類名 = カテゴリー名2"
			SQL += " FROM"
			SQL += "    projectNum"
			SQL += " WHERE"
			SQL += "    カテゴリー名2 IS NOT NULL"
			SQL += " GROUP BY"
			SQL += "    カテゴリー名2"
			SQL += " ORDER BY"
			SQL += "    カテゴリー名2"
			break;
		case "新規名" :
			SQL  = " SELECT"
			SQL += "    分類名 = 分類名"
			SQL += " FROM"
			SQL += "    業務分類リスト"
			SQL += " WHERE"
			SQL += "    mode = 2"
			SQL += " ORDER BY"
			SQL += "    表示順"
			break;
		case "分類名" :
			SQL  = " SELECT"
			SQL += "    分類名 = 分類名"
			SQL += " FROM"
			SQL += "    業務分類リスト"
			SQL += " WHERE"
			SQL += "    mode = 1"
			SQL += " ORDER BY"
			SQL += "    表示順"
			break;
		case "確度" :
			var Tab = ["100","90","80","70","50","30","10"]
			return(Tab)
			break;
		default:
			SQL = ""
			break;
			}			

   var DB = Server.CreateObject("ADODB.Connection");
   var RS = Server.CreateObject("ADODB.Recordset");

   DB.Open( Session("ODBC") );
   DB.DefaultDatabase = "kansaDB"

   RS = DB.Execute(SQL)
	var Tab = []
	Tab.push("")
	while( !RS.EOF ){
		Tab.push(RS.Fields("分類名").Value)
		
		RS.MoveNext()
		}
   RS.Close()
	DB.Close()
	return(Tab)
	}

//=====================================
//	集計用のプロジェクト親を設定
//=====================================
function bbsJoinParent(pNum,Parent)
	{

//EMGLog.Write("bbs.txt","bbsJoinParent")
	try{
	var Year,yymm
	var pNum,maxNum,baseNum

	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ﾌﾟﾛｼﾞｪｸﾄ内容の設定
	SQL  = " SELECT"
	SQL += "    Parent"
	SQL += " FROM"
	SQL += "    projectNum"
	SQL += " WHERE"
	SQL += "    Project = 2" 
	SQL += "    AND"
	SQL += "    pNum = " + pNum
	RS.Open( SQL, DB, 3, 3);
	if( !RS.EOF ){
		RS.Fields("Parent").Value = Parent;
		RS.Update()
		}
	
	RS.Close();
	DB.Close();

	return(true)

	}catch(e){
		return(e.message)
		}
	}

//=====================================
//	集計用のプロジェクト名変更
//=====================================
function bbsJoinRename(pNum,pName)
	{

//EMGLog.Write("bbs.txt","bbsRenameJoin")
	try{
	var Year,yymm
	var pNum,maxNum,baseNum

	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ﾌﾟﾛｼﾞｪｸﾄ内容の設定
	SQL  = " SELECT"
	SQL += "    pName"
	SQL += " FROM"
	SQL += "    projectNum"
	SQL += " WHERE"
	SQL += "    Project = 5" 
	SQL += "    AND"
	SQL += "    pNum = " + pNum
	RS.Open( SQL, DB, 3, 3);
	if( !RS.EOF ){
		RS.Fields("pName").Value = pName;
		RS.Update()
		}
	
	RS.Close();
	DB.Close();

	return(true)

	}catch(e){
		return(false)
		}
	}

//=====================================
//	集計用のプロジェクトコード作成
//=====================================
function bbsJoinAdd(pName)
	{
//EMGLog.Write("bbs.txt","bbsAddJoin",pName)
	var Year,yymm
	var pNum,maxNum,baseNum

	var userName = Session("userName");
	var pDate = getDateTimeString();
	
//=====================================================================
// 排他制御設定
	Application.Lock
	Application("dummy") = 1
//---------------------------------------
   
	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ﾌﾟﾛｼﾞｪｸﾄｺｰﾄﾞの設定
	SQL  = " SELECT maxNum = max(pNum)"
	SQL += " FROM projectNum"
	RS = DB.Execute(SQL)
	maxNum = parseInt(RS.Fields("maxNum").Value)
	RS.Close()

//--------------------------------
//	新しい pNum を造る
	pNum = pNum_Inc(DB,maxNum)
//--------------------------------

	if( pNum > maxNum ){							// プロジェクト番号がオーバーした時は新規作成しない
//-- ﾌﾟﾛｼﾞｪｸﾄ内容の設定
		var pCode = make_pCode(pNum,"JP")

try{
		SQL  = " SELECT *"
		SQL += " FROM projectNum"

		RS.Open( SQL, DB, 3, 3);
		RS.AddNew();

		RS.Fields("pNum").Value         = pNum;
		RS.Fields("pCode").Value        = pCode;
		RS.Fields("pName").Value        = pName;
		RS.Fields("corpName").Value     = "";
		RS.Fields("Content").Value      = "";

		RS.Fields("userName").Value     = userName;
		RS.Fields("makeDate").Value     = pDate;
		RS.Fields("editDate").Value     = pDate;
		RS.Fields("newDate").Value      = pDate;
		RS.Fields("Title").Value        = "";
		RS.Fields("Stat").Value         = 98;
		RS.Fields("Project").Value      = 5;							// 種別：5			0:間接 / 1:部門 / 2:開発 / 5：結合
		RS.Fields("Parent").Value       = 1;							// Parent : 1
		RS.Fields("部署ID").Value       = 5;							// 部署：5 (未定)
		RS.Fields("担当営業").Value     = 0

		RS.Update();
		RS.Close();

}catch(e){
	EMGLog.Write("bbs.txt","bbsAddJoin",e.message)
	}

/*
		var mDate = new Date(pDate)
		var yymm = (mDate.getFullYear() * 100) + (mDate.getMonth()+1)

		SQL  = " DELETE"
		SQL += " FROM 業務部署データ"
		SQL += " WHERE pNum = '" + pNum + "'"
		DB.Execute(SQL)
   
		SQL  = " SELECT *"
		SQL += " FROM 業務部署データ"
		SQL += " WHERE pNum = " + pNum
		RS.Open( SQL, DB, 3, 3)
		if( RS.EOF ){
			RS.AddNew()
			RS.Fields("pNum").Value   = pNum
			RS.Fields("開始").Value   = yymm
			RS.Fields("終了").Value   = 205001
			RS.Fields("部署ID").Value = 5
//EMGLog.Write("BBS.txt","結合プロジェクト新規作成　bbsAddJoin [" + pNum + "][" + yymm + "][" + gID + "]")
			}
		RS.Update();
		RS.Close();
// 業務部署データの最適化
//		var gCode = projectUpdate(DB,pNum)   
*/	

		}
	DB.Close();
//---------------------------------------
// 排他制御解除
	Application.UnLock

	return(pNum);
	}

//----- 新規ﾌﾟﾛｼﾞｪｸﾄ追加 ------
function bbsAddList(dummy
					,pName
					,corpName
					,V_Title
					,V_Content
					,Stat
					,salesManID
					,gID
					,P_kind
					,P_kindNew
					,P_kindCategory1
					,P_kindCategory2
					,P_fixLevel
					)
	{

	if( Stat == "" ) Stat = "0"
	if( P_fixLevel == "" ) P_fixLevel = "10" 

	var Year,yymm
	var pNum,maxNum,baseNum
	var Content = unescape(V_Content)
	var Title   = unescape(V_Title)
// 使用されて「HTML」で困る文字を修正
    Title = VB_Replace(Title, "\"", "”")
    //Title = VB_Replace(Title, "\"", "’")
	Title = VB_Replace(Title,"\'","’")
	Title = VB_Replace(Title,"(","（")
	Title = VB_Replace(Title,")","）")
	Title = VB_Replace(Title,"&","＆")


//EMGLog.Write("bbs.txt","bbsAddList",Content.length,pName.length,corpName.length)
	if( Content.length == 0 || pName.length == 0 || corpName.length == 0){
		return(-1);
		}

	P_kind = (P_kind == "" ? null : P_kind)
	P_kindNew = (P_kindNew == "" ? null : P_kindNew)
	P_kindCategory1 = (P_kindCategory1 == "" ? null : P_kindCategory1)
	P_kindCategory2 = (P_kindCategory2 == "" ? null : P_kindCategory2)

	var userName = Session("userName");
	var pDate = getDateTimeString();

//=====================================================================
// 排他制御設定
	Application.Lock
	Application("dummy") = 1
//---------------------------------------

try{
   
	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ﾌﾟﾛｼﾞｪｸﾄｺｰﾄﾞの設定
	SQL  = " SELECT maxNum = max(pNum)"
	SQL += " FROM projectNum"
	RS = DB.Execute(SQL)
	maxNum = parseInt(RS.Fields("maxNum").Value)
	RS.Close()

//--------------------------------
//	新しい pNum を造る
	pNum = pNum_Inc(DB,maxNum)
//--------------------------------

	if( pNum > maxNum ){							// プロジェクト番号がオーバーした時は新規作成しない
//-- ﾌﾟﾛｼﾞｪｸﾄ内容の設定
		var pCode = make_pCode(pNum,"PJ")

		SQL  = " SELECT *"
		SQL += " FROM projectNum"
		RS.Open( SQL, DB, 3, 3);
		RS.AddNew();

		RS.Fields("pNum").Value          = pNum;
		RS.Fields("pCode").Value         = pCode;

		if( pName != "" )			RS.Fields("pName").Value         = pName;
		if( corpName != "" )		RS.Fields("corpName").Value      = corpName;
		if( Content != "" )			RS.Fields("Content").Value       = Content;
		if( userName != "" )		RS.Fields("userName").Value      = userName;
		if( Title != "" )			RS.Fields("Title").Value         = Title;
		if( Stat != "" )			RS.Fields("Stat").Value          = parseInt(Stat);
		if( gID != "" )				RS.Fields("部署ID").Value        = gID;
		if( salesManID != "" )		RS.Fields("担当営業").Value      = salesManID
		if( P_fixLevel != "" )		RS.Fields("fix_level").Value     = P_fixLevel;
		if( P_kind != "" )			RS.Fields("分類名").Value		 = P_kind;
		if( P_kindNew != "" )		RS.Fields("新規名").Value	 	 = P_kindNew;
		if( P_kindCategory1 != "" )	RS.Fields("カテゴリー名1").Value = P_kindCategory1;
		if( P_kindCategory2 != "" )	RS.Fields("カテゴリー名2").Value = P_kindCategory2;

		RS.Fields("makeDate").Value      = pDate;
		RS.Fields("editDate").Value      = pDate;
		RS.Fields("newDate").Value       = pDate;
		RS.Fields("Project").Value       = 2;
		RS.Fields("Parent").Value        = 0;

		RS.Update();
		RS.Close();

		var mDate = new Date(pDate)
		var yymm = (mDate.getFullYear() * 100) + (mDate.getMonth()+1)

		SQL  = " DELETE"
		SQL += " FROM 業務部署データ"
		SQL += " WHERE pNum = '" + pNum + "'"

		DB.Execute(SQL)
   
		SQL  = " SELECT *"
		SQL += " FROM 業務部署データ"
		SQL += " WHERE pNum = " + pNum

		RS.Open( SQL, DB, 3, 3)
		if( RS.EOF ){
			RS.AddNew()
			RS.Fields("pNum").Value   = pNum
			RS.Fields("開始").Value   = yymm
			RS.Fields("部署ID").Value = gID
//EMGLog.Write("BBS.txt","プロジェクト新規作成　bbsAddList ", pNum , yymm , gID)
			}
		RS.Update();
		RS.Close();
	
// 業務部署データの最適化
		var gCode = projectUpdate(DB,pNum)   

		}
	DB.Close();
}catch(e){
	EMGLog.Write("BBS.txt",e.message,"bbsAddList error" ,pNum , yymm , gID )
	}
//---------------------------------------
// 排他制御解除
	Application.UnLock

	return(pNum);
	}


//----- ﾌﾟﾛｼﾞｪｸﾄ編集 ------
function bbsEditList(pNum
					,pName
					,corpName
					,V_Title
					,V_Content
					,Stat
					,salesManID
					,P_kind
					,P_kindNew
					,P_kindCategory1
					,P_kindCategory2
					,P_fixLevel)
	{
	var Content = unescape(V_Content)
	var Title   = unescape(V_Title)

// 使用されて「HTML」で困る文字を修正
	Title = VB_Replace(Title,"\"","”")
	Title = VB_Replace(Title,"\'","’")
	Title = VB_Replace(Title,"(","（")
	Title = VB_Replace(Title,")","）")
	Title = VB_Replace(Title,"&","＆")

//EMGLog.Write("bbs.txt","bbsEditList",Content.length,pName.length,corpName.length)

	if( Content.length == 0 || pName.length == 0 || corpName.length == 0){
		return(-1);
		}

	P_kind = (P_kind == "" ? null : P_kind)
	P_kindNew = (P_kindNew == "" ? null : P_kindNew)
	P_kindCategory1 = (P_kindCategory1 == "" ? null : P_kindCategory1)
	P_kindCategory2 = (P_kindCategory2 == "" ? null : P_kindCategory2)

	var userName = Session("userName");
	var pDate = getDateTimeString();
   
	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ﾌﾟﾛｼﾞｪｸﾄ内容の設定
	SQL  = " SELECT *"
	SQL += " FROM projectNum"
	SQL += " WHERE pNum = " + pNum;
	RS.Open( SQL, DB, 3, 3);
	if( !RS.EOF){
		RS.Fields("pName").Value         = pName;
		RS.Fields("corpName").Value      = corpName;
		RS.Fields("Content").Value       = Content;

		RS.Fields("userName").Value      = userName;
		RS.Fields("Title").Value         = Title;
		RS.Fields("editDate").Value      = pDate;
		RS.Fields("newDate").Value       = pDate;
		RS.Fields("Stat").Value          = parseInt(Stat);

		RS.Fields("担当営業").Value      = salesManID

		RS.Fields("fix_level").Value     = P_fixLevel;
		RS.Fields("分類名").Value		 = P_kind;
		RS.Fields("新規名").Value		 = P_kindNew;
		RS.Fields("カテゴリー名1").Value = P_kindCategory1;
		RS.Fields("カテゴリー名2").Value = P_kindCategory2;

		RS.Update();
		}
	RS.Close();

	DB.Close();

	return(pNum);
	}



//--------------------------------------------------------------------
function pNum_Inc(DB,pNum)
	{
	var pNum_STEP = 3
	var NumMax = 9995

	var Year = makeYear()								// 作成するコードの年度
	var baseNum = parseInt(Year) * 10000;
	if(baseNum > pNum){									// 年が変わったとき
		pNum = makeEMG_Area(DB,baseNum);				// 共通領域の作成
		}
//	pNumを増加する
// いままでのCheckSumの4桁版で作成する
/*
	var work = parseInt(pNum /10) + 1
	var num  = parseInt(work % 1000);
	var year = parseInt(work / 1000);
	var nen  = parseInt(year % 10);
	pNum = (work*10) + checkSum(nen,num)
*/
//*******
	if( pNum < (baseNum + NumMax)){
		pNum += pNum_STEP
		}
	return(pNum)
	}

//-- ﾌﾟﾛｼﾞｪｸﾄ共通領域の作成
function makeEMG_Area(DB,baseNum)
	{
	var RS = Server.CreateObject("ADODB.Recordset");
	var JE_BEGIN = 10
	var JE_STEP = 1

	var BU_BEGIN = 200
	var BU_STEP  = 6

	var PJ_BEGIN = 1000
	var PJ_STEP = 3

	var SQL
	var pNum,i,nn,year,nen,num

	SQL  = " SELECT *"
	SQL += " FROM projectNum"
	RS.Open( SQL, DB, 3, 3);

	var year = parseInt(baseNum / 10000);
	for( i = JE_BEGIN; i < BU_BEGIN; i += JE_STEP){   
		nn    = parseInt(i /10)
		num   = parseInt(nn % 1000);
		nen   = parseInt(year % 10);
		pNum  = parseInt(year)*10000 + i
		pCode = make_pCode(pNum,"JE")
		RS.AddNew();
		RS.Fields("pNum").Value    = pNum;
		RS.Fields("pCode").Value   = pCode;
		RS.Fields("Project").Value = 0;
		RS.Fields("makeDate").Value = year + "/01/01";
		RS.Update();
//		pr(pCode + "][" + pNum)
		}
	for( i = BU_BEGIN; i < PJ_BEGIN; i += BU_STEP){   
		nn    = parseInt(i /10)
		num   = parseInt(nn % 1000);
		nen   = parseInt(year % 10);
//		pNum  = parseInt(year + numZ(num,3) + checkSum(nen,num))
		pNum  = parseInt(year)*10000 + i
		pCode = make_pCode(pNum,"BU")
		RS.AddNew();
		RS.Fields("pNum").Value    = pNum;
		RS.Fields("pCode").Value   = pCode;
		RS.Fields("Project").Value = 1;
		RS.Fields("makeDate").Value = year + "/01/01";
		RS.Update();
//		pr(pCode + "][" + pNum + "][" + nen + "][" + num)
		}
	RS.Close();

	var year = parseInt(baseNum / 10000);
	nen  = parseInt(year % 10);
	num  = parseInt(year % 100) + PJ_STEP;
	pNum = baseNum + PJ_BEGIN + checkSum(nen,num)
	pNum = pNum - PJ_STEP								// １つ少ない値を設定
	return(pNum)
	}

//-- ﾌﾟﾛｼﾞｪｸﾄ共通領域の作成
function OLD_makeEMG_Area(DB,baseNum)
	{
	var RS = Server.CreateObject("ADODB.Recordset");
	var JE_BEGIN = 10
	var BU_BEGIN = 200
	var PJ_BEGIN = 1000
	var BASE_STEP = 10
	var pNum_STEP = 3
   var SQL
   var pNum,i

   SQL  = " SELECT *"
   SQL += " FROM projectNum"
   RS.Open( SQL, DB, 3, 3);

	var year = parseInt(baseNum / 10000);
   for( i = JE_BEGIN; i < PJ_BEGIN; i += BASE_STEP){   
		nn = parseInt(i /10)
		var num  = parseInt(nn % 1000);
		var nen  = parseInt(year % 10);
	   pNum = parseInt(year + numZ(num,3) + checkSum(nen,num))
		if( i < BU_BEGIN ){
			pCode = make_pCode(pNum,"JE")
			}
		else{
			pCode = make_pCode(pNum,"BU")
			}
		
      RS.AddNew();
      RS.Fields("pNum").Value    = pNum;
      RS.Fields("pCode").Value   = pCode;
      RS.Fields("Project").Value = 0;
      RS.Update();
      }
   RS.Close();
	var nen  = parseInt(year % 10);
	pNum = baseNum + (PJ_BEGIN + nen) - pNum_STEP
	return(pNum)
   }
   
function make_pCode(pNum,Name)
   {
	var pNum4mode = ( pNum > 10000000 ? true : false )
	var pNum4value = ( pNum4mode ? 10000 : 1000 )
	var pCode = ""
	var num  = parseInt(pNum % pNum4value);
	var year = parseInt(pNum / pNum4value);
	var nen  = parseInt(year % 10);
	if( pNum4mode ){
	   pCode = nen + Name + numZ(num,4)
		}
	else{
	   pCode = nen + Name + numZ(num,3) + checkSum(nen,num);
		}
   return(pCode);   
   }

function checkSum(y, i)
    {
    var s;
    
    s = y;
    s = s + (digit(i, 100) * 3);
    s = s + (digit(i, 10) * 5);
    s = s + ((i % 10) * 7);
    return(s % 10);
    }

function digit(i, d)
    {
    var x;
    
    x = i % (d * 10);
    x = Math.floor(x / d);
    return( x );
    }

//--------------------------------------------------------------------
function getDateTimeString()
   {
   var cDate = new Date();
   var strTime
   strTime  = cDate.getFullYear() + "/";
   strTime += (cDate.getMonth() + 1) + "/";
   strTime += cDate.getDate() + " ";
   strTime += cDate.getHours() + ":";
   strTime += cDate.getMinutes() + ":";
   strTime += cDate.getSeconds();

   return(strTime);
   }

// 作成するコードの年度作成   
function makeYear()
   {
   var toDay = new Date()
   var yy = toDay.getFullYear()
   var mm = toDay.getMonth()+1
   var Year = yy									// その年を使用
   return(Year)
   }

//=====================================================================
function projectNew(DB,pNum,gCode)
   {
//EMGLog.Write("BBS.txt","projectNew")
//-- ﾌﾟﾛｼﾞｪｸﾄ内容の設定
   var SQL
   SQL  = " UPDATE projectNum"
   SQL += " SET"
   SQL += "    部署ID = '" + gCode + "'"
   if(false){
      var userName = Session("userName");
      var pDate = getDateTimeString();
      SQL += ",userName = '" + userName + "'"
      SQL += ",editDate = '" + pDate + "'"
      SQL += ",newDate  = '" + pDate + "'"
      }
   SQL += " WHERE"
   SQL += "    pNum = '" + pNum + "'"
   DB.Execute(SQL)
   }

function regGrpEdit(pNum,yymm,new_gCode,new_yymm)
   {
//EMGLog.Write("BBS.txt","regGrpEdit:" + pNum + "][" + new_gCode + "]["  + yymm + "][" + new_yymm)
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"


//EMGLog.Write("BBS.txt","グループコードの更新　regGrpEdit [" + pNum + "][" + yymm + "][" + new_gCode + "]")

//-- 開始・グループコードの更新
   SQL  = " UPDATE"
   SQL += "    業務部署データ"
   SQL += " SET"
   SQL += "    開始   = '" + new_yymm + "',"
   SQL += "    部署ID = '" + new_gCode + "'"
   SQL += " WHERE"
   SQL += "    pNum = '" + pNum + "'"
   SQL += "    AND"
   SQL += "    開始 = '" + yymm + "'"
   DB.Execute(SQL)


// 終了の最適化
   var gCode = projectUpdate(DB,pNum)

// プロジェクトを更新状態にする
   projectNew(DB,pNum,gCode)

   DB.Close();

   return(true);
   }

function regGrpAdd(pNum,gCode,yymm)
   {
//EMGLog.Write("BBS.txt","regGrpAdd")
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"


//EMGLog.Write("BBS.txt","グループの追加　regGrpAdd [" + pNum + "][" + yymm + "][" + gCode + "]")

//-- プロジェクトの追加
   SQL  = "INSERT INTO 業務部署データ"
   SQL += " (pNum,開始,部署ID)"
   SQL += " VALUES(" + pNum + "," + yymm + "," + gCode + ")"
   DB.Execute(SQL)
   

// 終了の最適化
   var gCode = projectUpdate(DB,pNum)

// プロジェクトを更新状態にする
   projectNew(DB,pNum,gCode)

   DB.Close();

   return(true);
   }

function regGrpDel(pNum,yymm)
   {
//EMGLog.Write("bbs.txt","regGrpDel:" + pNum + "][" + yymm)
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

// 削除
   SQL  = " DELETE"
   SQL += " FROM 業務部署データ"
   SQL += " WHERE"
   SQL += "   pNum = '" + pNum + "'"
   SQL += "   AND"
   SQL += "   開始 = '" + yymm + "'"
   DB.Execute(SQL)

// 終了の最適化
   var gCode = projectUpdate(DB,pNum)

// プロジェクトを更新状態にする
   projectNew(DB,pNum,gCode)

   DB.Close();

   return(true);
   }

//=====================================================================
function getProjectInfo(pNum)
{
	var Tab = new Object
	Tab.makeDate = ""
	Tab.Stat     = 0
	Tab.pCode    = 0
	Tab.pName    = ""
	Tab.Content  = ""
	Tab.gID      = 5
	Tab.gName    = "未定"
	Tab.Info0    = ""                 // T0:客先名
	Tab.Info1    = ""                 // T1:客先部署
	Tab.Info2    = ""                 // T2:客先担当者
	Tab.Info3    = ""                 // T3:営業担当者
	Tab.Info4    = ""                 // T4:期間
	Tab.Info5    = ""                 // T5:工数
	Tab.Info6    = ""                 // T6:場所
	Tab.kind         = ""
	Tab.kindNew      = ""
	Tab.kindCategory1 = ""
	Tab.kindCategory2 = ""
	Tab.fixLevel     = "30"

	if( parseInt(pNum) > 0 ){
		var Title,Work,Content
		var SQL
		var DB = Server.CreateObject("ADODB.Connection")
		var RS = Server.CreateObject("ADODB.Recordset")
		DB.Open( Session("ODBC") )
		DB.DefaultDatabase = "kansaDB"

		SQL  = " SELECT"
		SQL += "   Stat         = PNUM.Stat,"
		SQL += "   pCode        = PNUM.pCode,"
		SQL += "   pName        = PNUM.pName,"
		SQL += "   CorpName     = PNUM.corpName,"
		SQL += "   部署id       = PNUM.部署ID,"
		SQL += "   salesManID   = PNUM.担当営業,"
		SQL += "   分類名       = PNUM.分類名,"
		SQL += "   新規名       = PNUM.新規名,"
		SQL += "   カテゴリー名1 = PNUM.カテゴリー名1,"
		SQL += "   カテゴリー名2 = PNUM.カテゴリー名2,"
		SQL += "   fix_level    = PNUM.fix_level,"
		SQL += "   salesMan     = (SELECT 姓+名 FROM EMG.dbo.社員基礎データ WHERE 社員ID = PNUM.担当営業),"
		SQL += "   makeDate = CONVERT(char(10),PNUM.makeDate,111),"
		SQL += "   Content  = PNUM.Content,"
		SQL += "   Title    = PNUM.Title"
		SQL += " FROM projectNum PNUM"
		SQL += " WHERE PNUM.pNum = '" + pNum + "'"
		RS = DB.Execute(SQL)	
		if( !RS.EOF ){
			Tab.Stat          = RS.Fields("Stat").Value
			Tab.pCode         = RS.Fields("pCode").Value
			Tab.pName         = String(RS.Fields("pName").Value)
			Tab.corpName      = RS.Fields("corpName").Value
			Tab.salesManID    = RS.Fields("salesManID").Value
			Tab.salesMan      = RS.Fields("salesMan").Value
			Tab.gID           = RS.Fields("部署ID").Value
			Tab.makeDate      = RS.Fields("makeDate").Value
			Content           = String(RS.Fields("Content").Value)
			Title             = String(RS.Fields("Title").Value)

			Tab.kind          = RS.Fields("分類名").Value
			Tab.kindNew       = RS.Fields("新規名").Value
			Tab.kindCategory1 = RS.Fields("カテゴリー名1").Value
			Tab.kindCategory2 = RS.Fields("カテゴリー名2").Value
			Tab.fixLevel      = RS.Fields("fix_level").Value

			Tab.kind          = ( Tab.kind         == null ? "" : Tab.kind)
			Tab.kindNew       = ( Tab.kindNew      == null ? "" : Tab.kindNew)
			Tab.kindCategory1 = ( Tab.kindCategory1 == null ? "" : Tab.kindCategory1)
			Tab.kindCategory2 = ( Tab.kindCategory2 == null ? "" : Tab.kindCategory2)
			Tab.fixLevel      = ( Tab.fixLevel     == null ? "" : Tab.fixLevel)

			Tab.salesMan   = ( Tab.salesMan   == null ? "" : Tab.salesMan)
			Tab.salesManID = ( Tab.salesManID == null ? 0  : Tab.salesManID)
		
//			Tab.pName   = escape(Tab.pName)
			Tab.Content = escape(Content)                            // 改行コードが含まれるため
			Tab.pName   = Tab.pName
			Tab.Content = Tab.Content.replace(/\n/g, "<br/>")                            // 改行コードが含まれるため
            Tab.Content = Tab.Content.replace(/\"/g, "”")
			Work = Title.split("\n");
			for( var i = 0; i < Work.length; i++){
				Tab["Info" + i] = (Work[i].length == 0 ? "" : Work[i])
				}
			}


//      Tab["Info0"] = String(RS.Fields("corpName").Value)
		RS.Close();

		SQL  = " SELECT"
		SQL += "    部署名"
		SQL += " FROM"
		SQL += "    部署マスタ"
		SQL += " WHERE"
		SQL += "    部署コード = '" + Tab.gID + "'"
		RS = DB.Execute(SQL)
		if( !RS.EOF) Tab.gName = RS.Fields("部署名").Value
		RS.Close();

		DB.Close();
	}
    //EMGLog.Write("bbs1.txt", Tab.Content,Tab.Content.replace(/\"/g, "\”"))
	//EMGLog.Join("bbs_Json.txt", Tab);
	return(Tab)
	}

function getGroupHistoryInfo(pNum)
   {
try{
//EMGLog.Write("bbs.txt","getGroupHistoryInfo")
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

   var toDay = new Date()
   var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)
   
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL

   var Tab = new Array()
   
   SQL  = " SELECT"
   SQL +=   " 開始 = 業務部署データ.開始,"
   SQL +=   " 終了 = 業務部署データ.終了,"
   SQL +=   " 部署 = 業務部署データ.部署ID,"
   SQL +=   " 名前 = 部署マスタ.部署名"
   SQL += " FROM"
   SQL +=   " 業務部署データ inner join 部署マスタ on 業務部署データ.部署ID = 部署マスタ.部署コード"
   SQL += " WHERE"
   SQL += "   業務部署データ.pNum = " + pNum
   SQL += " ORDER BY"
   SQL += "   業務部署データ.開始"

   RS = DB.Execute(SQL)
   var n,s_yymm,e_yymm,gName,gID
   while(!RS.EOF){
      s_yymm = RS.Fields('開始').Value
      e_yymm = RS.Fields('終了').Value
      gID    = RS.Fields('部署').Value
      gName  = RS.Fields('名前').Value
      n = Tab.length
      Tab[n] = new Object
      Tab[n].s     = s_yymm
      Tab[n].e     = e_yymm
      Tab[n].gID   = gID
      Tab[n].gName = gName
      RS.MoveNext()
      }

   RS.Close()
   DB.Close()
   
	return(Tab)
}catch(e){EMGLog.Write("bbs.txt","getGroupHistoryInfo:" + e.message)}
   }

function getSalesHistoryInfo(pNum)
   {
try{
//EMGLog.Write("bbs.txt","getSalesHistoryInfo")
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

   var Dic = new getGroupDic(DB)
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL

   SQL = ""
   SQL += " SELECT"
   SQL += "    yymm   = 売上予測実績データ.yymm,"
   SQL += "    mode   = 売上予測実績データ.mode,"
   SQL += "    gCode  = 業務部署データ.部署ID,"
   SQL += "    amount = Sum(売上予測実績データ.金額)"
   SQL += " FROM"
   SQL += " 	(売上予測実績データ INNER JOIN 業務部署データ ON 売上予測実績データ.pNum = 業務部署データ.pNum)"
   SQL += " WHERE"
   SQL += "    売上予測実績データ.pNum = '" + pNum + "'"
   SQL += "    AND"
   SQL += "    (売上予測実績データ.yymm Between 業務部署データ.開始 And 業務部署データ.終了)"
   SQL += " GROUP BY"
   SQL += "    売上予測実績データ.yymm,"
   SQL += "    売上予測実績データ.mode,"
   SQL += "    業務部署データ.部署ID"
   SQL += " ORDER BY"
   SQL += "    売上予測実績データ.yymm,"
   SQL += "    業務部署データ.部署ID"

   RS = DB.Execute(SQL)
   var n,pNum,amount,gCode,c_yymm,mode
   var Tab = new Object
   while(!RS.EOF){
      c_yymm  = RS.Fields('yymm').Value
      mode    = RS.Fields('mode').Value
      gCode   = RS.Fields('gCode').Value
      amount  = RS.Fields('amount').Value

      if( !IsObject(Tab[c_yymm]) ){
         Tab[c_yymm] = new Object
         Tab[c_yymm].gName  = Dic.Item(gCode)
         Tab[c_yymm].plan   = 0
         Tab[c_yymm].actual = 0
         }
      if( mode == 0 ) Tab[c_yymm].actual= amount
      else            Tab[c_yymm].plan  = amount

      RS.MoveNext()
      }

   RS.Close()
   DB.Close()
   Dic = null
   
   return(Tab)

}catch(e){EMGLog.Write("bbs.txt","getSalesHistoryInfo:" + e.message)}
   }

//===========================================================================================
function getGroupList(yymm)
   {
//EMGLog.Write("bbs.txt","getGroupList")
   var cDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   var RS = Server.CreateObject("ADODB.Recordset")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

   SQL  = " SELECT"
   SQL += "   Mode  = 直間,"
   SQL +=   " Code  = 部署コード,"
   SQL +=   " Name  = 部署名"
   SQL += " FROM"
   SQL +=   " EMG.dbo.部署マスタ"
   SQL += " WHERE"
   SQL += "   直間 IN(0,1,2)"
   SQL += "   AND '" + cDate + "' BETWEEN 開始 AND 終了"
// SQL += "   AND ACCコード >= 0"
   SQL += " ORDER BY"
   SQL += "   直間,"
   SQL +=   " 部署名,"
   SQL += "   終了 DESC,"
   SQL += "   開始"
   RS = DB.Execute(SQL)

   var Tab = new Array()
   var n,Mode,Code,Name
   while(!RS.EOF){
      Mode    = RS.Fields('Mode').Value
      Code    = RS.Fields('Code').Value
      Name    = RS.Fields('Name').Value
      n = Tab.length
      Tab[n] = new Object
      Tab[n].mode = Mode
      Tab[n].code = Code
      Tab[n].name = Name
      RS.MoveNext()
      }
   RS.Close()
   DB.Close()

   return(Tab)
   }

//==============================================================================
function getGroupDic(DB)
   {
//   if(!dic.Exists(key))          //未登録ならば抜ける
//   pr(dic.Item(key))             //値を表示する
   this.dic = new ActiveXObject("Scripting.Dictionary")
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL
   SQL  = " SELECT"
   SQL += "    gCode = 部署コード,"
   SQL += "    gName = 部署名"
   SQL += " FROM"
   SQL +=   " EMG.dbo.部署マスタ"
   SQL += " ORDER BY"
   SQL += "    部署コード"
   RS = DB.Execute(SQL)
   var gCode,gName
   while(!RS.EOF){
      gCode  = RS.Fields('gCode').Value
      gName  = RS.Fields('gName').Value
      this.dic.Add(gCode,gName)
      RS.MoveNext()
      }
   RS.Close()
   return(this.dic)
   }


//====================================================================
function projectUpdate(DB,pNum)
   {
//EMGLog.Write("bbs.txt","projectUpdate")

   var toDay = new Date()
   var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)
   yymm = yymmAdd(yymm,-3)                                  // 3ヶ月前からのデータ
   yymm = 0                                                 // すべて

// 売上データの抽出
   var sTab = getSalesData(DB,pNum,yymm)

// 廃止グループの抽出
   var rTab = getGroupData_retire(DB)
   
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL = ""

// 開始より売上が早い時の修正
   SQL  = " SELECT"
   SQL += "     pNum    = pNum,"
   SQL += "     groupID = 部署ID,"
   SQL += "     開始    = 開始"
   SQL += " FROM"
   SQL += "     業務部署データ"
   SQL += " WHERE"
   SQL += "     pNum = '" + pNum + "'"
   SQL += " ORDER BY"
   SQL += "     pNum,"
   SQL += "     開始"

   RS.Open(SQL,DB,3,3)
   var pNum,groupID,s_yymm,e_yymm,w_yymm,u_yymm,new_yymm
   var saveNum = -1
   while(!RS.EOF){
      pNum     = RS.Fields("pNum").Value
      groupID  = RS.Fields("groupID").Value
      s_yymm   = RS.Fields("開始").Value
      if( pNum != saveNum ){
         saveNum = pNum                                                    // 最初のデータ
         if(IsObject(sTab[pNum]) && sTab[pNum].s < s_yymm ){
            RS.Fields("開始").Value = sTab[pNum].s
            RS.Update()
//pr("[" + pNum + "][" + s_yymm + "][" + sTab[pNum].s + "]")
            }
         }
      RS.MoveNext()
      }
   RS.Close()

   var lastGroupID = groupID                                               // 最新のグループID

   // [開始]の日付から[終了]の日付を正しくする
   
   SQL  = " SELECT"
   SQL += "     pNum    = pNum,"
   SQL += "     groupID = 部署ID,"
   SQL += "     開始    = 開始,"
   SQL += "     終了    = 終了"
   SQL += " FROM"
   SQL += "     業務部署データ"
   SQL += " WHERE"
   SQL += "     pNum = '" + pNum + "'"
   SQL += " ORDER BY"
   SQL += "     pNum,"
   SQL += "     開始 DESC"

   RS.Open(SQL,DB,3,3)
   var pNum,groupID,s_yymm,e_yymm,w_yymm,u_yymm,new_yymm
   var saveNum = -1
   while(!RS.EOF){
      pNum     = RS.Fields("pNum").Value
      groupID  = RS.Fields("groupID").Value
      s_yymm   = RS.Fields("開始").Value
      e_yymm   = RS.Fields("終了").Value
      if( pNum != saveNum ){
         saveNum = pNum                                                    // 最初のデータ
//pr("---------------------------------------")
         new_yymm = yymmAdd(s_yymm,11)                                     // グループの有効期限を1年に設定
         if(IsObject(rTab[groupID]) && new_yymm > rTab[groupID]){          // 廃止グループの時終了yymmを設定
            new_yymm = rTab[groupID]
            if(s_yymm > new_yymm) new_yymm = s_yymm                        // 廃止月より開始が遅い時
            }
         if(IsObject(sTab[pNum])){
            u_yymm = yymmAdd(sTab[pNum].e,3)                               // 3ヶ月を加える
            if( new_yymm < u_yymm) new_yymm = u_yymm                       // 売上yymmを設定
            }
         if( new_yymm > e_yymm ) e_yymm = new_yymm                         // 前回更新済はそのまま
         }
      else{
         e_yymm = yymmAdd(w_yymm,-1)                                       // 2回目以降の終了を設定
         }
      w_yymm = s_yymm
      RS.Fields("終了").Value = e_yymm
      RS.Update()
//      pr("[" + pNum + "][" + groupID + "][" + s_yymm + "][" + e_yymm + "]")
      RS.MoveNext()
      }
   RS.Close()
//EMGLog.Write("bbs.txt","projectUpdate end")

   return(lastGroupID)
   }


function getGroupData_retire(DB)
   {
//EMGLog.Write("bbs.txt","getGroupData_retire")
   var toDay = new Date()
   var Tab = new Object
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL
   SQL  = " SELECT"
   SQL += "     gName   = 部署名,"
   SQL += "     groupID = 部署コード,"
   SQL += "     rDate   = CONVERT(char(10),終了,111)"
   SQL += " FROM"
   SQL += "     部署マスタ"
   SQL += " WHERE"
   SQL += "     終了 < '" + convertDate(toDay) + "'"              // 本日より前に廃止になったグループ
   SQL += " ORDER BY"
   SQL += "     部署コード"
   RS = DB.Execute(SQL)
   var groupID,rDate
   while(!RS.EOF){
      gName   = RS.Fields("gName").Value
      groupID = RS.Fields("groupID").Value
      rDate   = RS.Fields("rDate").Value
      Tab[groupID] = (JsDatePart("yyyy",rDate) * 100) + JsDatePart("m",rDate)
//pr("[" + groupID + "][" + rDate + "][" + gName + "]")
      RS.MoveNext()
      }
   RS.Close()
//EMGLog.Write("bbs.txt","getGroupData_retire end")
   return(Tab)
   }

function getSalesData(DB,pNum,yymm)
   {
//EMGLog.Write("bbs.txt","getSalesData")
   var Tab = new Object
   var SQL
   var RS = Server.CreateObject("ADODB.Recordset")

   SQL = ""
   SQL += " SELECT"
   SQL += "    pNum   = pNum,"
   SQL += "    s_yymm = min(yymm),"
   SQL += "    e_yymm = max(yymm)"
   SQL += " FROM"
   SQL += "    営業売上データ"
   SQL += " WHERE"
   SQL += "    Flag = 0"
   SQL += "    AND"
   SQL += "    pNum = '" + pNum + "'"
   if( yymm != 0){
      SQL += "    AND"
      SQL += "    yymm >= '" + yymm + "'"
      }
   SQL += " GROUP BY"
   SQL += "    pNum"
   SQL += " ORDER BY"
   SQL += "    pNum"
   RS = DB.Execute(SQL)

   var pNum,x_yymm
   while(!RS.EOF){
      pNum   = RS.Fields("pNum").Value
      s_yymm = RS.Fields("s_yymm").Value
      e_yymm = RS.Fields("e_yymm").Value
      if( !IsObject(Tab[pNum]) ){
         Tab[pNum] = new Object
         Tab[pNum].s = s_yymm
         Tab[pNum].e = e_yymm
         }
      else{
         if( s_yymm < Tab[pNum].s ) Tab[pNum].s = s_yymm
         if( e_yymm > Tab[pNum].e ) Tab[pNum].e = e_yymm
         }
      RS.MoveNext()
      }

   RS.Close()

// 売上予測データ
   SQL = ""
   SQL += " SELECT"
   SQL += "    pNum   = pNum,"
   SQL += "    s_yymm = min(yymm),"
   SQL += "    e_yymm = max(yymm)"
   SQL += " FROM"
   SQL += "    営業予測データ"
   SQL += " WHERE"
   SQL += "    pNum = '" + pNum + "'"
   if( yymm != 0){
      SQL += "    AND"
      SQL += "    yymm >= '" + yymm + "'"
      }
   SQL += " GROUP BY"
   SQL += "    pNum"
   SQL += " ORDER BY"
   SQL += "    pNum"
   RS = DB.Execute(SQL)

   var pNum,x_yymm
   while(!RS.EOF){
      pNum   = RS.Fields("pNum").Value
      s_yymm = RS.Fields("s_yymm").Value
      e_yymm = RS.Fields("e_yymm").Value
      if( !IsObject(Tab[pNum]) ){
         Tab[pNum] = new Object
         Tab[pNum].s = s_yymm
         Tab[pNum].e = e_yymm
         }
      else{
         if( s_yymm < Tab[pNum].s ) Tab[pNum].s = s_yymm
         if( e_yymm > Tab[pNum].e ) Tab[pNum].e = e_yymm
         }
      RS.MoveNext()
      }

   RS.Close()
//	EMGLog.Write("bbs.txt","getSalesData end")
   return(Tab)
   }



function IsObject(o)
   {
   if( typeof(o) != "undefined" ) return(true)
   return(false)
   }

%>
<Script language="VBScript"  runat="server">
Function VB_Replace(Buff,oldChr,newChr)
VB_Replace = Replace(Buff,oldChr,newChr)
End Function
</Script>

