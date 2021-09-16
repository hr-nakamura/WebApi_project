<%@ Language=JavaScript %>
<!--#include file="cmn.inc"-->
<!--#include file="dispXML.inc"-->
<%
    Session("memberName1") = "中村"
    Session("memberName2") = "博"
    pr(Session("memberName1"));
    var limitYear = 2004

    %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>

    <script src="../../__home/Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>

    <script src="../../__home/Scripts/json2.js" type="text/javascript"></script>
    <script src="../../__home/Scripts/jquery.kansa.Query.js" type="text/javascript"></script>
    <script src="../../__home/debug/jquery.my.debug.js" type="text/javascript"></script>

    <!-- menu -->
    <script src="../../__home/Scripts/jquery.my.frame.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE="JavaScript" src="xmlProc.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
    var limitYear = "<%=limitYear%>"
    var xml_name1 = "project.xml"				// 地域別
    var xsl_name1 = "projectList.xsl"

    var xml_proc
    var source = "ABC"

</SCRIPT>
    <script type="text/javascript">
        window.onload = function () {

            xml_proc = new xmlProc()
            var xml = xml_name1;
            xml_proc.loadXML(source, xml, xml_func)

            var xsl = xsl_name1
            xml_proc.transfor(source, xsl, xsl_func)

            $.alert(limitYear);

        }

        function xml_func(xmlDoc) {
            var xsl = xsl_name1
            xml_proc.transfor(xmlDoc, xsl, xsl_func)
            source = xmlDoc
        }

        function xsl_func(Buff) {
            dataG.innerHTML = Buff;

        }
    </script>


</head>
<body>
    test2
    <div id="dataG"></div>
</body>
</html>