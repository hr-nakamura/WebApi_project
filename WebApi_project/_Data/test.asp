<%@ Language=VBScript %>
<html>

<head>
<title>TEST-B</title>
<meta name="Microsoft Theme" content="none, default">
</head>

<body>
<%
  For Each key in Request.ServerVariables
           Response.Write key + "F"

      if Request.ServerVariables(key) = "" Then
           Response.Write "-"
      else 
           Response.Write Request.ServerVariables(key)
      end if
      Response.Write "<BR>"
	Next
      Response.Write "END"
 %>
  
  </body>
</html>
