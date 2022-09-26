<script Language="VBScript" RUNAT="Server">
Function xx()
	Dim myDictionary
	Set myDictionary = CreateObject("Scripting.Dictionary")
	Dim item
	For Each Key In Request.QueryString
		' 配列から取得した値を表示
      If Not IsNULL(Request.QueryString(key)) Then
			myDictionary.Add Key, Request.QueryString(key)
		End If

	Next
Set xx = myDictionary
End Function
</script>
