<%@ Language=JScript %>
<!--#include virtual="/Project/common_data/確定日付.inc"-->
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/Json.inc"-->
<%
try{
var adjustDayCnt = 7
var OK_DAY = dayChk(new Date("2021/09/01"),adjustDayCnt)


pr_p("XX",OK_DAY,"XX")



	var yosokuCnt,actualCnt
	var year = 2021

	var d = new Date()
	var yy = d.getFullYear()
	var mm = d.getMonth()+1
	var dd = d.getDate()
	var yymm = yy * 100 + mm								// 今月のyymm

	var OKday = dayChk(d,adjustDayCnt)
	yymm = ( parseInt(dd) < parseInt(OKday) ? yymmAdd(yymm, -1) : yymmAdd(yymm, 0))		// データ有効月の計算(12日以前は前々月)

	var b_yymm = ((year-1)*100) + 10
	var actualCnt = yymmDiff( b_yymm, yymm )
	if(actualCnt >= 12) actualCnt = 12

	if(Request.QueryString("yosoku").count == 0){
		yosokuCnt = 12 - actualCnt
		}
	else{
		yosokuCnt = 3
		if(yosokuCnt == 0){
			//	すべて計画
			actualCnt = 0
			yosokuCnt = 0
			}
		else if( yosokuCnt < 0 ){
			// 残り全て予測
			yosokuCnt = 12 - actualCnt
			}
		}
		
var Json ={
	yosokuCnt : yosokuCnt,
	actualCnt : actualCnt,
	year:year,
	yymm:yymm,
	b_yymm:b_yymm
}
var work = EMGLog.Json(Json).replace(/\n/g,"<br>").replace(/ /g,"　");

pr(work);

/*

           var sDate,eDate,curDate,n
           var value

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
*/

}catch(e){
pr(e.message);
}
%>
