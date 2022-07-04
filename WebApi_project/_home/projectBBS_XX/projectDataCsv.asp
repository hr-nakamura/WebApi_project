<%@ Language=JavaScript %>
<!--#include file="cmn.inc"-->

<%
   Response.ContentType = "application/octet/stream"
//   Response.ContentType = "text/html; charset=SHIFT_JIS"
   Response.AddHeader("content-disposition","inline; filename=project.csv")

	var limitYear = makeYear() - 2

   var memberID = Session("memberID")

   var mode = String(Request.QueryString("mode"))

   if( mode == "undefined" ) mode = 1
   dispProject(mode,limitYear)
   
   Response.End
   
function csvOut(Str)
   {
// Response.Write( Str + "<BR>" )
   Response.Write( Str + "\n" )
   }



// 作成するコードの年度作成   
function makeYear()
   {
   var toDay = new Date()
   var yy = toDay.getFullYear()
   var mm = toDay.getMonth()+1
   var Year
//	Year = ( mm >= 3 ? yy : yy - 1 )			// 3月から新年度用のコード
	Year = yy
   return(Year)
   }

function dispProject(mode,limitYear)
   {
   var Head = Array()
   var Buff = Array()
   var Work = Array()
   var beforBBS
   var visitBBS
   var m,d,i
   var newFlag,newMark,LinkStr

   var toDay = new Date()
   var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)

   beforBBS = convertDateTime(new Date(Session("beforBBS")))
   visitBBS = convertDateTime(new Date(Session("visitBBS")))

//	EMGLog.Write("project.txt",beforBBS,visitBBS);

   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   var RS = Server.CreateObject("ADODB.Recordset")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

	var pNum = 0
	SQL = "SELECT pNum = max(pNum) FROM projectNum"
	RS = DB.Execute(SQL)
	if( !RS.EOF ) pNum = RS.Fields("pNum").Value
	var pNum4mode = ( pNum > 10000000 ? true : false )
	var pNum4Value = ( pNum4mode ? 10000 : 1000 )
	var limitNum = (limitYear * pNum4Value) + 1

   SQL  = " SELECT"
   SQL += "    ID           = projectNum.ID,"
   SQL += "    Stat         = projectNum.Stat,"
   SQL += "    pNum         = projectNum.pNum,"
   SQL += "    pCode        = RTRIM(LTRIM(projectNum.pCode)),"
   SQL += "    pName        = RTRIM(LTRIM(projectNum.pName)),"
   SQL += "    userName     = RTRIM(LTRIM(projectNum.userName)),"
   SQL += "    corpName     = RTRIM(LTRIM(projectNum.corpName)),"
   SQL += "    gName        = RTRIM(LTRIM(部署マスタ.部署名)),"
   SQL += "    newDate      = projectNum.newDate,"
   SQL += "    makeDate     = projectNum.makeDate,"
   SQL += "    editDate     = projectNum.editDate,"
   SQL += "    Kind         = projectNum.Kind,"
   SQL += "    Title        = projectNum.Title"
   SQL += " FROM"
   SQL += "    projectNum INNER JOIN 部署マスタ ON projectNum.部署ID = 部署マスタ.部署コード"
   SQL += " WHERE"
   SQL += "    projectNum.Project IN(2)"
   SQL += "    AND"
   SQL += "    projectNum.pName Is Not Null "
	SQL += "    AND"
	SQL += "    (projectNum.pNum >= " + limitNum + " OR projectNum.stat NOT IN(5,-1) )"
   SQL += " ORDER BY"
   SQL += "    projectNum.pNum DESC"
   RS = DB.Execute(SQL)
//------------------------------------------------------------------
   var i = 0

   Head[i++] = "Stat:Integer"
   Head[i++] = "Mark:String"
   Head[i++] = "newFlag:Integer"
   Head[i++] = "プロジェクト名:String"
   Head[i++] = "pCode:String"
   Head[i++] = "pNum:Integer"
   Head[i++] = "更新日:String"
   Head[i++] = "営業:String"
   Head[i++] = "登録者:String"
   Head[i++] = "グループ名:String"

   Head[i++] = "客先会社:String"
   Head[i++] = "期間:String"
   Head[i++] = "規模:String"
   Head[i++] = "場所:String"

/*
   Head[i++] = "Stat"
   Head[i++] = "Mark"
   Head[i++] = "newFlag"
   Head[i++] = "プロジェクト名"
   Head[i++] = "pCode"
   Head[i++] = "pNum"
   Head[i++] = "更新日"
   Head[i++] = "登録者"
   Head[i++] = "グループ名"

   Head[i++] = "客先会社"
   Head[i++] = "期間"
   Head[i++] = "規模"
   Head[i++] = "場所"
*/

   csvOut(Head.join("\t"))
	var Temp,Work
	while( !RS.EOF ){
      ID       = RS.Fields("ID").Value
      Kind     = RS.Fields("Kind").Value
      pNum     = RS.Fields("pNum").Value
      pCode    = RS.Fields("pCode").Value
      pName    = RS.Fields("pName").Value
      Stat     = RS.Fields("Stat").Value
      newDate  = RS.Fields("newDate").Value
      makeDate = RS.Fields("makeDate").Value
      editDate = RS.Fields("editDate").Value
      uName    = RS.Fields("userName").Value
      corpName = RS.Fields("corpName").Value
      gName    = RS.Fields("gName").Value
      Temp     = String(RS.Fields("Title").Value)
      Work     = Temp.split("\n")

//      User0  = Trim(Work[0])							// 客先会社名
      User0  = corpName										// 客先会社名
      User0  = User0.replace("(","（")					// 
      User0  = User0.replace(")","）")					// 
      User0  = User0.replace("&","＆")					// 
      User1  = Trim(Work[1])								// 客先部署
      User2  = Trim(Work[2])								// 客先担当者
      sales  = Trim(Work[3])								// 担当営業
      kikan  = Trim(Work[4])								// 期間
      kibo   = Trim(Work[5])								// 規模
      basyo  = Trim(Work[6])								// 場所

      d = dayDiff("d",newDate,beforBBS)	// 日
      m = dayDiff("n",newDate,visitBBS)	// 分

      if( m < 15){											// 15分前
         newFlag = 1;
         }
      else if( d <  7){										//  7日前
         newFlag = 2;
         }
      else{
         newFlag = 0
         }

      var dispMode = ( mode == 1 ? true : (newFlag > 0 || Stat == 0 || Stat == 1 ) )
      if( dispMode ){
         var i = 0
         Buff[i++] = Stat;
         Buff[i++] = cnvStatMark(Stat)
         Buff[i++] = newFlag
         Buff[i++] = pName.replace(/\t/g, "") + cnvNewMark(newFlag)         // ↓↓↓文字列内にタブが含まれていれば除去する　2016.10.14
         Buff[i++] = pCode.replace(/\t/g, "");
         Buff[i++] = pNum;
         Buff[i++] = JsFormatDateTime(editDate,2).substr(5,5)
         Buff[i++] = sales.replace(/\t/g, "")
         Buff[i++] = uName.replace(/\t/g, "")
         Buff[i++] = gName.replace(/\t/g, "")

         Buff[i++] = (User0 == "" ? "　" : User0).replace(/\t/g, "")
         Buff[i++] = (kikan == "" ? "　" : kikan).replace(/\t/g, "")
         Buff[i++] = (kibo  == "" ? "　" : kibo).replace(/\t/g, "")
         Buff[i++] = (basyo == "" ? "　" : basyo).replace(/\t/g, "")

         csvOut(Buff.join("\t"))
         }
      RS.MoveNext();
      }

   RS.Close();
   DB.Close();

   }

function cnvStatMark(stat)
   {
      switch(parseInt(stat)){
         case 0 :
            Str = "▲".fontcolor("green");			// 引き合い中
            break;
         case 1 :
            Str = "●".fontcolor("blue");			// 開発中
            break;
         case 4 :
            Str = "●".fontcolor("gray");			// 開発終了
            break;
         case 5 :
            Str = "★".fontcolor("gray");			// 終了
            break;
         case -1 :
            Str = "×".fontcolor("gray");			// 没
            break;
         default:
            Str = "";
         }
   return(Str);
   }

function cnvNewMark(newFlag)
   {
      switch(parseInt(newFlag)){
         case 1 :
            Str = "<img src='new.gif'>";				// 15分前
            break;
         case 2 :
            Str = "<img src='new7.gif'>";				//  7日前
            break;
         default:
            Str = "";
         }
   return(Str);
   }
function dayDiff(mode,sDate,eDate)
   {
   var sValue = new Date(sDate)
   var eValue = new Date(eDate)
   var value
   switch(mode){
      case "s":      // 秒
         value = parseInt(eValue / 1000) - parseInt(sValue / 1000)
         break;
      case "n":      // 分
         value = parseInt(eValue / (60*1000)) - parseInt(sValue / (60*1000))
         break;
      case "h":      // 時
         value = parseInt(eValue / (60*60*1000)) - parseInt(sValue / (60*60*1000))
         break;
      case "d":      // 日
         value = parseInt(eValue / (24*60*60*1000)) - parseInt(sValue / (24*60*60*1000))
         break;
      case "m":      // 月
         value = ((eValue.getFullYear() * 12) + eValue.getMonth()) - ((sValue.getFullYear() * 12 ) + sValue.getMonth())
         break;
      case "yyyy":   // 年
         value = eValue.getFullYear() - sValue.getFullYear()
         break;
      default:
         break;
      }
   return(value)
   }
%>
