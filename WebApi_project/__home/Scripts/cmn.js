//(function ($) {
    function getPath()
   {
   var path = String(window.document.location.pathname)
        var n = path.indexOf("/");
        if (n > 0) path = "/" + path;
        var n = path.lastIndexOf("/");
        var value = path.substr(0, n + 1);
        return (value);
   }
function convertDateTime(cDate)
   {
    var value = convertDate(cDate) + " " + convertTime(cDate);
    return (value);
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
   var Str = exp.getHours() + ":" + numZ(exp.getMinutes(),2) + ":" + numZ(exp.getSeconds(),2);
   return(Str);
   }

function yymmAdd(yymm,value)
   {
   var yy,mm,ym
    yy = parseInt(yymm / 100, 10);
    mm = parseInt(yymm % 100, 10);

    ym = (yy * 12) + mm;
    ym += value;
    yy = parseInt(ym / 12, 10);
    mm = parseInt(ym % 12, 10);
   if( mm == 0 ){ yy--;mm = 12;}
   return( (yy * 100 ) + mm)
   }
function yymmDiff( base_yymm, yymm )
   {
   var b_yy,b_mm,yy,mm,n
   
    b_yy = parseInt(base_yymm / 100, 10);
   b_mm = base_yymm % 100;
    yy = parseInt(yymm / 100, 10);
   mm = yymm % 100;

    mm += (yy - b_yy) * 12;
    n = (mm - b_mm);
   return(n);
   }

function yymmStr(yymm)
   {
   var s,yStr,mStr
    yStr = String(parseInt(yymm / 100, 10));
    mStr = String(parseInt(yymm % 100, 10) + 100);
    s = yStr.substr(2, 2) + "/" + mStr.substr(1, 2);
   return(s)
   }
   
function strMonth(yymm)
   {
    var strYYMM = "";
   if(yymm != "undefined"){
       yy = parseInt(yymm / 100,10);
       mm = parseInt(yymm % 100, 10);
       strYYMM = yy + "年" + numZ(mm, 2) + "月";
      }
    return (strYYMM);
   }

//--------------------------------------------------------
function numZ(num,width)
   {
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
function IsEmpty(m)
   {
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
function abs(num){
   if(num != null ) return(Math.abs(num));
   else             return(null);
   }

//----------- テーブル定義(領域に作成) -------------------------------
function makeTable()
   {
    this.Buff = "";
    return (this);
   }
   
makeTable.prototype.Begin = function(Str){
    this.Buff += "<TABLE " + Str + ">";
    return;
   }

makeTable.prototype.End = function(){
    this.Buff += "</TABLE>";
    return;
   }

makeTable.prototype.Caption = function(Str,FieldData){
    this.Buff += "<CAPTION " + Str + ">" + FieldData + "</CAPTION>";
    return;
   }

makeTable.prototype.HeadBegin = function(Str){
    this.Buff += "<THEAD " + Str + ">";
    return;
   }

makeTable.prototype.HeadEnd = function(){
    this.Buff += "</THEAD>";
    return;
   }

makeTable.prototype.RowBegin = function(Str){
    this.Buff += "<TR " + Str + ">";
    return;
   }

makeTable.prototype.RowEnd = function(){
    this.Buff += "</TR>";
    return;
   }

makeTable.prototype.FootBegin = function(Str){
    this.Buff += "<TFOOT " + Str + ">";
    return;
   }

makeTable.prototype.FootEnd = function(){
    this.Buff += "</TFOOT>";
    return;
   }

makeTable.prototype.BodyBegin = function(Str){
    this.Buff += "<TBODY " + Str + ">";
    return;
   }

makeTable.prototype.BodyEnd = function(){
    this.Buff += "</TBODY>";
    return;
   }

makeTable.prototype.HeadCell = function(Str,FieldData){
    this.Buff += "<TH nowrap " + Str + ">" + FieldData + "</TH>";
    return;
   }

makeTable.prototype.HeadCellBegin = function(Str){
    this.Buff += "<TH nowrap " + Str + ">";
    return;
   }

makeTable.prototype.HeadCellEnd = function(){
    this.Buff += "</TH>";
    return;
   }

makeTable.prototype.DataCell = function(Str,FieldData){
   if( Trim(FieldData) == "" || IsEmpty(FieldData) ) FieldData = "&nbsp;";
    this.Buff += "<TD " + Str + ">" + FieldData + "</TD>";
    return;
   }

makeTable.prototype.DataCellBegin = function(Str){
    this.Buff += "<TD " + Str + ">";
    return;
   }

makeTable.prototype.DataCellEnd = function(){
    this.Buff += "</TD>";
    return;
   }

makeTable.prototype.Put = function(FieldData){
   if( Trim(FieldData) == "" || IsEmpty(FieldData) ) FieldData = "　";
    this.Buff += FieldData;
    return;
   }

makeTable.prototype.GetData = function(){
    return (this.Buff);
   }

makeTable.prototype.Flush = function(){
    var Buff = this.Buff;
    this.Buff = "";
    return (Buff);
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

function DateSerial(year, month, day){
   return(JsDateSerial(year, month, day));
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

//})(jQuery);