<%@ Language=JavaScript %>
<%
    var x = Request.QueryString("ABC").Item;
    Response.Write("XX" + x + "ZZ")
    Response.End();
%>
ABCDE