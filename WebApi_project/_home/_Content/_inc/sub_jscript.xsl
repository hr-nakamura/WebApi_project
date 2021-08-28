<?xml version="1.0" encoding="shift_jis" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:user="mynamespace">


	<!--	<xsl:value-of select="user:DateDiff(mode,s,e)"/>	-->

<msxsl:script language="JScript" implements-prefix="user">
	function DateDiff(mode,sDate,eDate){
	var value
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
</msxsl:script>

</xsl:stylesheet>