<%
//var adjustDayCnt = 6					// ２００８年１月のみ
var adjustDayCnt = 7
//var OK_DAY = dayChk(new Date(),adjustDayCnt)

function dayChk(d,targetCnt)
	{
   var DB = Server.CreateObject("ADODB.Connection")
   var RS = Server.CreateObject("ADODB.Recordset")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

   var sDate,eDate,curDate,n
   var value
   
// var d = new Date()
   sDate = JsDateSerial(d.getFullYear(), d.getMonth()+1, 1)
   eDate = JsDateAdd("m", 1, sDate)
   eDate = JsDateAdd("d", -1, eDate)

//------------------------------------------------------------------
   curDate = sDate 
   var n
   var dBuff = new Array()
   do{
	  n = dBuff.length
	  dBuff[n] = new Object;
	  dBuff[n].日付 = JsFormatDateTime(curDate,2)
	  dBuff[n].曜日 = JsWeekday(curDate) - 1
	  dBuff[n].offDay = (dBuff[n].曜日 == 0 || dBuff[n].曜日 == 6 ? 1 : 0) 
	  curDate = JsDateAdd("d", 1, curDate)
	  }while(JsDay(curDate) != 1)

//========================================================
// 「土日以外で休み」及び「土日で出勤」する日のデータを更新する

   var SQL,date,offDay,yy,mm,dd
   SQL	= " SELECT 日付x=日付,offDay"
   SQL += " FROM EMG.dbo.勤務出勤日"
   SQL += " WHERE 日付 BETWEEN '" + JsFormatDateTime(sDate,2) + "' AND '" + JsFormatDateTime(eDate,2) + "'"
   SQL += "   AND"
   SQL += "   memberID=0"
   RS = DB.Execute(SQL)
   while( !RS.EOF ){
     date = RS.Fields("日付x").Value
	  offDay = RS.Fields("offDay").Value
	  n = JsDateDiff("d",JsFormatDateTime(sDate,2),JsFormatDateTime(date,2))
	  dBuff[n].offDay = (offDay == true ? 1 : 0)
	  RS.MoveNext()
	  }
   RS.Close()
   DB.Close()
   var Cnt = 0
   for( n in dBuff ){
	  if( dBuff[n].offDay == 0 ) Cnt++
	  if( Cnt > targetCnt ) break;
	  }
   var selDate = dBuff[n].日付
   var d = new Date(selDate)
   var OK_DAY = d.getDate()
   return(OK_DAY)
   }
%>
