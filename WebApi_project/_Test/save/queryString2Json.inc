<script Language="JScript" RUNAT="Server">
function queryString2Json()
	{
	var Tab = getQueryInfo();
	var json = {};
	for( var i = 0; i < Tab.Count; i++){
		var work = Tab(i).split("＠");
		var key   = work[0];
		var value = work[1];
		json[key] = value
		}
	return(json);
}

</script>

<script Language="VBScript" RUNAT="Server">
Function getQueryInfo()
	Dim array
	Set array = CreateObject("System.Collections.ArrayList")
	Dim myDictionary
	Set myDictionary = CreateObject("Scripting.Dictionary")
	Dim work
	For Each Key In Request.QueryString
		' 配列から取得した値を表示
      If Not IsNULL(Request.QueryString(key)) Then
			array.add( key & "＠" & Request.QueryString(key) )
		End If
	Next
	array.Sort
	Set getQueryInfo = array
End Function
</script>
