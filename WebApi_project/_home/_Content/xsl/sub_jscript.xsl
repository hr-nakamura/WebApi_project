<?xml version="1.0" encoding="shift_jis" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:user="mynamespace">


	<!--	<xsl:value-of select="user:DateDiff(mode,s,e)"/>	-->

<msxsl:script language="JScript" implements-prefix="user">
  function DateDiff(mode,sDate,eDate){
  var value = ""
  if( typeof(sDate) != "object" || typeof(eDate) != "object") return(-1)
  var sDateStr = sDate.nextNode().text
  var eDateStr = eDate.nextNode().text
  var sValue = new Date( sDateStr )
  var eValue = new Date( eDateStr )
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

  function dispX(value,mode)
  {
  if( typeof(value) == "object") value = parseInt(value.nextNode().text)
  if( typeof(mode) == "object")  mode  = parseInt(mode.nextNode().text)
  if( value == 0 ) return("")
  if( mode == 1 ){
  value = -value
  }
  return(formatNum(value));
  }
  function formatNum(value)
  {
  var Buff =	value.toLocaleString()
  var n = Buff.indexOf(".")
  if( n > 0 )	Buff = Buff.substr(0,n)
  return(Buff)
  }

  function yymmNow()
  {
  var d = new Date()
  var yy = d.getFullYear() 
  var mm = d.getMonth()+1
  return( (yy * 100 ) + mm)
  }

  function yymmAdd(yymm,value)
  {
  if( typeof(yymm)  == "object") yymm  = parseInt(yymm.nextNode().text)
  if( typeof(value) == "object") value = parseInt(value.nextNode().text)
  var yy,mm,ym
  yy = parseInt(yymm / 100)
  mm = parseInt(yymm % 100)

  ym = (yy * 12) + mm
  ym += value
  yy = parseInt(ym / 12)
  mm = parseInt(ym % 12)
  if( mm == 0 ){ yy--;mm = 12;}
  return( (yy * 100 ) + mm)
  }
  function yymmAddStr(yymm,value)
  {
  if( typeof(yymm)  == "object") yymm  = parseInt(yymm.nextNode().text)
  if( typeof(value) == "object") value = parseInt(value.nextNode().text)
  var yy,mm,ym
  yy = parseInt(yymm / 100)
  mm = parseInt(yymm % 100)

  ym = (yy * 12) + mm
  ym += value
  yy = parseInt(ym / 12)
  mm = parseInt(ym % 12)
  if( mm == 0 ){ yy--;mm = 12;}
  return( yy + "年" + numZ(mm,2)) + "月"
  }
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
</msxsl:script>

</xsl:stylesheet>