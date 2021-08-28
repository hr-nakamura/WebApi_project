<%
//AspLog呼び出しの履歴
//Server.CreateObject("EMG.AspLog");

//--------------------------------------------------------
var $Browser = BrowserType();

function BrowserType() {
	var Agent = String(Request.ServerVariables("HTTP_USER_AGENT"));
	var browser;
	if( Agent.match(/OPR/i) ){
		browser = "opera";
		}
	else if( Agent.match(/Edg/i) ){
		browser = "edge";
		}
	else if( Agent.match(/Chrome/i) ){
		browser = "chrome";
		}
	else if( Agent.match(/Trident/i) ){
		browser = "msie";
		}
	else{
		browser = "IE";
		}

	return ({
		name: browser,
		agent : Agent
  		});
	}
//--------------------------------------------------------

function pr_p()
	{
	var work = []
	for( var i = 0; i < arguments.length; i++ ){
		work.push(arguments[i])
		}
	pr("["+work.join("][") + "]")
	}

function argOut()
	{
	var work = []
	for( var i = 0; i < arguments.length; i++ ){
		work.push(arguments[i])
		}
	return("["+work.join("][") + "]")
	}
function getCurrentURL()
	{
	var server = Request.ServerVariables("SERVER_NAME")
	var path   = Request.ServerVariables("PATH_INFO")
	var n = String(path).lastIndexOf("/")
	path = String(path).substr(0,n)
	var serverURL = "http://" + server + path + "/"
	return(serverURL)
	}

function func_funcName(f){
	var s = ("" + f).match(/function (\w*)/)[1];
	return( func_isEmpty(s) ? "[anonymous]" : s );
	}

function func_isEmpty(s){
	return( (s==null) || (s.length == 0) );
	}

function stackTrace()
	{
	var stack = []
	for(var a = arguments.callee.caller; a != null; a = a.caller){
		stack[stack.length] = func_funcName(a)
		}
	if( stack.length == 0 ) stack[0] = "[PageTop]"
	return(stack);
	}
//--------------------------------------------------------
function $Text2Node(node, text) {
    var xmlDoc1 = node.ownerDocument;
    var Text = xmlDoc1.createTextNode(text);
    node.appendChild(Text)
    }

function $queryString( key_name, defStr ){
	var work = (Request.QueryString(key_name).Count == 0 ? defStr : Request.QueryString(key_name).Item);
	return(work);
	}
function writeCookies(name,value)
   {
   var exp = new Date();
   exp.setFullYear(exp.getFullYear()+1);				// 有効期間1年
   var expStr = (exp.getMonth()+1) + "/" + exp.getDate() + "/" + exp.getYear();

   Response.Cookies(name) = value
   Response.Cookies(name).expires = expStr;
   }

function readCookies(name)
   {
   return(String(Request.Cookies(name)));
   }


function convertDateTime(cDate)
   {
   var value = convertDate(cDate) + " " + convertTime(cDate)
   return(value)
   }

function convertDate(cDate)
   {
   var exp = new Date(cDate);
   var Str = exp.getFullYear() + "/" + numZ((exp.getMonth()+1),2) + "/" + numZ(exp.getDate(),2);
   return(Str);
   }

function convertTime(cDate)
   {
   var exp = new Date(cDate);
   var Str = numZ(exp.getHours(),2) + ":" + numZ(exp.getMinutes(),2) + ":" + numZ(exp.getSeconds(),2);
   return(Str);
   }

function yymmAdd(yymm,value)
   {
   var yy,mm,ym
   yymm  = parseInt(yymm)
   value = parseInt(value)
   yy	 = parseInt(yymm / 100)
   mm	 = parseInt(yymm % 100)

   ym = (yy * 12) + mm
   ym += value
   yy = parseInt(ym / 12)
   mm = parseInt(ym % 12)
   if( mm == 0 ){ yy--;mm = 12;}
   return( (yy * 100 ) + mm)
   }
function yymmDiff( base_yymm, yymm )
   {
   var b_yy,b_mm,yy,mm,n
   base_yymm = parseInt(base_yymm)
   yymm 	 = parseInt(yymm)
   b_yy = parseInt(base_yymm / 100)
   b_mm = base_yymm % 100;
   yy	= parseInt(yymm / 100)
   mm	= yymm % 100;

   mm += (yy - b_yy) * 12
   n = (mm - b_mm)
   return(n);
   }

function yymmStr(yymm)
   {
   var s,yStr,mStr
   yymm  = parseInt(yymm)
   yStr  = String(parseInt(yymm / 100))
   mStr  = String(parseInt(yymm % 100) + 100)
   s = yStr.substr(2,2) + "/" + mStr.substr(1,2)
   return(s)
   }
   
function strMonth(yymm)
   {
   var strYYMM = ""
   if(yymm != "undefined"){
	  yy = parseInt(yymm / 100)
	  mm = parseInt(yymm % 100)
	  strYYMM = yy + "年" + numZ(mm,2) + "月"
	  }
   return(strYYMM)
   }

function exit()
   {
   Response.End();
   }

//--------------------------------------------------------
function put(s)
   {
   s = "" + s + "";			// m を確実に文字列にします。
   if( s != "undefined"){		// 空の文字列や未定義項目でないかどうかを調べます。
	  Response.Write(s);
	  }
   Response.Write("<BR>\n");
   }

function p(s)
   {
   s = "" + s + "";			// m を確実に文字列にします。
   if( s != "undefined"){		// 空の文字列や未定義項目でないかどうかを調べます。
	  Response.Write(s);
	  }
   }
function pn(s)
   {
   s = "" + s + "";			// m を確実に文字列にします。
   if( s != "undefined"){		// 空の文字列や未定義項目でないかどうかを調べます。
	  Response.Write(s);
	  Response.Write("\n");
	  }
   }
function pr(s)
   {
   s = "" + s + "";			// m を確実に文字列にします。
   if( s != "undefined"){		// 空の文字列や未定義項目でないかどうかを調べます。
	  Response.Write(s);
	  Response.Write("<BR>");
	  }
   }
function cr()
   {
   Response.Write("<BR>");
   }

//--------------------------------------------------------
function numZ(num,width)
   {
   num = parseInt(num,10)
   var n = 1;
   var w = width;
   var s = "";

   while(w-- != 0){
	  n = n *10;
	  }

   if( num >= n ){
	  return(String(num));
	  }
   
   s = String(num + n);
   return(s.substr(1,width));
   }
		 
function numZsup(num,width)
   {
   num = parseInt(num,10)
   var i;
   var n;
   var s = "";

   if(IsNull(num)) num = 0;

   s = String(num);
   n = s.length;
   if( n >= width ){						// 指定桁より大きいとき
	  return(s);
	  }
   for( i = 0; i < width - n; i++){
	  s = " " + s;
	  }
   return(s);
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

//--------------------------------------------------------
function IsObject(o)
   {
   if( typeof(o) == "undefined"){	// 
	  return(false);			// NG
	  }
   return(true);			// OK
   }
function IsEmpty(m)
   {
    if (typeof (m) == "object") {
        var stat = true;
        for (var x in m) {
            stat = false;
            break;
        }
        return(stat);
    }
    else {
        m = "" + m + "";			// m を確実に文字列にします。
        if( m == "undefined"){		// 空の文字列や未定義項目でないかどうかを調べます。
    	    return(true);			// 初期化されていない
	        }
        else if( m == "null"){		// 空の文字列や未定義項目でないかどうかを調べます。
            return(true);			// 初期化されていない
            }
        else if( m == ""){			// 空の文字列や未定義項目でないかどうかを調べます。
	        return(true);			// 初期化されていない
            }
        else{
            return(false);			// 初期化済
            }
        }
    }
function abs(num){
   if(num != null ) return(Math.abs(num));
   else 			return(null);
   }


//----------- テーブル定義 -------------------------------
function tableBegin(Str){
   p("\n<TABLE ");
   p(Str);
   p(">");
   }

function tableEnd(){
   p("\n</TABLE>");
   }

function tableCaption(Str,FieldData){
   p("\n<CAPTION ");
   p(Str);
   p(">");
   p(FieldData);
   pn("</CAPTION>");
   }

function tableHeadBegin(Str){
   p("\n<THEAD ");
   p(Str);
   p(">");
   }

function tableHeadEnd(){
   p("\n</THEAD>");
   }

function tableRowBegin(Str){
   p("\n<TR ");
   p(Str);
   p(">");
   }

function tableRowEnd(){
   p("\n</TR>");
   }

function tableFootBegin(Str){
   p("\n<TFOOT ");
   p(Str);
   p(">");
   }

function tableFootEnd(){
   p("</TFOOT>");
   }

function tableBodyBegin(Str){
   p("\n<TBODY ");
   p(Str);
   p(">");
   }

function tableBodyEnd(){
   p("\n</TBODY>");
   }

function tableHeadCell(Str,FieldData){
   p("\n<TH nowrap ");
   p(Str);
   p(">");
   p(FieldData);
   p("</TH>");
   }

function tableHeadCellBegin(Str){
   p("\n<TH nowrap ");
   p(Str);
   p(">");
   }

function tableHeadCellEnd(){
   p("</TH>");
   }

function tableDataCell(Str,FieldData){
   if( JsTrim(FieldData) == "" || IsEmpty(FieldData) ) FieldData = "　";
   p("\n<TD ");
   p(Str);
   p(">");
   p(FieldData);
   p("</TD>");
   }

function tableDataCellBegin(Str){
   p("\n<TD ");
   p(Str);
   p(">");
   }

function tableDataCellEnd(){
   p("</TD>");
   }

//----------- テーブル定義(領域に作成) -------------------------------
function makeTable()
   {
   this.Buff = ""
   this.Put 		  = o_tablePut
   this.GetData 	  = o_tableGetData
   this.Flush		  = o_tableFlush
   this.Begin		  = o_tableBegin
   this.End 		  = o_tableEnd
   this.Caption 	  = o_tableCaption
   this.HeadBegin	  = o_tableHeadBegin
   this.HeadEnd 	  = o_tableHeadEnd
   this.RowBegin	  = o_tableRowBegin
   this.RowEnd		  = o_tableRowEnd
   this.FootBegin	  = o_tableFootBegin
   this.FootEnd 	  = o_tableFootEnd
   this.BodyBegin	  = o_tableBodyBegin
   this.BodyEnd 	  = o_tableBodyEnd
   this.HeadCell	  = o_tableHeadCell
   this.HeadCellBegin = o_tableHeadCellBegin
   this.HeadCellEnd   = o_tableHeadCellEnd
   this.DataCell	  = o_tableDataCell
   this.DataCellBegin = o_tableDataCellBegin
   this.DataCellEnd   = o_tableDataCellEnd
   return(this)
   }

function o_tableGetData(){
   return(this.Buff)
   }
function o_tablePut(Str){
   this.Buff += Str
   }

function o_tableFlush(){
   this.Buff = ""
   }

function o_tableBegin(Str){
   this.Buff += "<TABLE " + Str + ">"
   }

function o_tableEnd(){
   this.Buff += "</TABLE>"
   }

function o_tableCaption(Str,FieldData){
   this.Buff += "<CAPTION " + Str + ">" + FieldData + "</CAPTION>"
   }

function o_tableHeadBegin(Str){
   this.Buff += "<THEAD " + Str + ">"
   }

function o_tableHeadEnd(){
   this.Buff += "</THEAD>"
   }

function o_tableRowBegin(Str){
   this.Buff += "<TR " + Str + ">"
   }

function o_tableRowEnd(){
   this.Buff += "</TR>"
   }

function o_tableFootBegin(Str){
   this.Buff += "<TFOOT " + Str + ">"
   }

function o_tableFootEnd(){
   this.Buff += "</TFOOT>"
   }

function o_tableBodyBegin(Str){
   this.Buff += "<TBODY " + Str + ">"
   }

function o_tableBodyEnd(){
   this.Buff += "</TBODY>"
   }

function o_tableHeadCell(Str,FieldData){
   this.Buff += "<TH nowrap " + Str + ">" + FieldData + "</TH>"
   }

function o_tableHeadCellBegin(Str){
   this.Buff += "<TH nowrap " + Str + ">"
   }

function o_tableHeadCellEnd(){
   this.Buff += "</TH>"
   }

function o_tableDataCell(Str,FieldData){
   if( JsTrim(FieldData) == "" || IsEmpty(FieldData) ) FieldData = "　";
   this.Buff += "<TD " + Str + ">" + FieldData + "</TD>"
   }

function o_tableDataCellBegin(Str){
   this.Buff += "<TD " + Str + ">"
   }

function o_tableDataCellEnd(){
   this.Buff += "</TD>"
   }

//=====================================================================
function FormatDateTime(Date,NamedFormat){
   return(JsFormatDateTime(convertDateTime(Date),NamedFormat))
   }
function IsNull(expression){
   return(JsIsNull(expression));
   }

function IsNumeric(expression){
   return(JsIsNumeric(expression));
   }

function IsDate(expression){
   return(JsIsDate(expression));
   }

function DateSerial(yyyy,mm,dd){
   return(JsDateSerial(yyyy,mm,dd));
   }

function DatePart(interval,date){
   return(JsDatePart(interval,convertDateTime(date)));
   }

function DateDiff(interval,date1,date2){
   return(JsDateDiff(interval,convertDateTime(date1),convertDateTime(date2)));
   }

function DateAdd(interval,number,date){
   return(JsDateAdd(interval,number,convertDateTime(date)));
   }

function Trim(str){
   return(JsTrim(str));
   }

function LTrim(str){
   return(JsLTrim(str));
   }

function RTrim(str){
   return(JsRTrim(str));
   }

function getBrowser() {
	var userAgent = Request.ServerVariables("HTTP_USER_AGENT");
	var ua = String(userAgent).toLowerCase();
    var browser = ""
    if (ua.indexOf("edge") > -1) {
		browser = "edge"
        }
	else if (ua.indexOf("chrome") > -1) {
		browser = "chrome"
        }
	else if (ua.indexOf("safari") > -1) {
		browser = "safari"
        }
	else if (ua.indexOf("opera") > -1) {
		browser = "opera"
        }
	else if (ua.indexOf("msie") > -1) {
		browser = "msie"
        }
	else if (ua.indexOf("trident") > -1) {
		browser = "msie"
        }
	return (browser);
    }
%>

<script LANGUAGE="VBScript" RUNAT="Server">
Function formatNum(num,n)
   if num <> "" then
	  formatNum = formatnumber(num,n)
	  end if
End Function

Function formatNumZ(num,n)
   if num <> "" then
	  if num <> 0 then
		 formatNumZ = formatnumber(num,n)
	  else
		 formatNumZ = "　"
		 end if
	  end if
End Function

Function putNum(num)
   if num = 0 then
	  putNum = null
   else
	  putNum = num
	  end if
End Function

</script>

<script LANGUAGE="VBScript" RUNAT="Server">
Function JsReplace(str,src,dst)
	JsReplace = Replace(str,src,dst)
End Function

Function JsFormatDateTime(Date,NamedFormat)
   JsFormatDateTime = FormatDateTime(Date,NamedFormat)
End Function

Function JsIsNull(expression)
   JsIsNull = IsNull(expression)
End Function

Function JsIsNumeric(expression)
   JsIsNumeric = IsNumeric(expression)
End Function

Function JsIsDate(expression)
   JsIsDate = IsDate(expression)
End Function

Function JsFormatDateTime(date1,format)
   JsFormatDateTime = FormatDateTime(date1,format)
End Function

Function JsDateSerial(year, month, day)
   JsDateSerial = DateSerial(year, month, day)
End Function

Function JsDatePart(interval,date1)
   JsDatePart = DatePart(interval,date1)
End Function

Function JsDateDiff(interval,date1,date2)
   JsDateDiff = DateDiff(interval,date1,date2)
End Function

Function JsDateAdd(interval,number,date1)
   JsDateAdd = DateAdd(interval,number,date1)
End Function

Function JsYear(date1)
   JsYear = Year(date1)
End Function

Function JsMonth(date1)
   JsMonth = Month(date1)
End Function

Function JsDay(date1)
   JsDay = Day(date1)
End Function

Function JsWeekday(date1)
   JsWeekday = Weekday(date1)
End Function

Function JsTrim(str)
   JsTrim = Trim(str)
End Function

Function JsLTrim(str)
   JsLTrim = LTrim(str)
End Function

Function JsRTrim(str)
   JsRTrim = RTrim(str)
End Function
</script>


