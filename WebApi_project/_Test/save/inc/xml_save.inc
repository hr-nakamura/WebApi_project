<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/fileInfo.inc"-->
<%
//===================================================================================
function xmlFileSave(xmlDoc,fName)
	{
	var pathName = Server.MapPath("/Project/common_data/xmlData" )
	var FileName = fName + ".xml"
	FileName = pathName + "\\" + FileName

//	var commnt = xmlDoc.createComment("ABC")
//	xmlDoc.appendChild(commnt)

	EMGLog.Write("xmlData.txt",fName + "を保存しました")

	xmlDoc.save(FileName)
	}

function xmlFileLoad(xmlDoc,fName)
	{
	var pathName = Server.MapPath("/Project/common_data/xmlData" )
	var n
	var now = convertDateTime(new Date())
	var fs = Server.CreateObject("Scripting.FileSystemObject")
	// 古いファイルを削除
	var fileTab = getFileList(pathName)
	for( var i = 0; i < fileTab.length; i++ ){
		if( fileTab[i].ExtName == "xml" ){
			n = JsDateDiff("d",fileTab[i].更新時刻,now)
			if( n > 0 ){
				fs.DeleteFile(fileTab[i].FullName)
				}
			}
		}

//	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
//	xmlDoc.async=false

	var FileName = fName + ".xml"
	FileName = pathName + "\\" + FileName

	if( fs.FileExists(FileName) ){
		EMGLog.Write("xmlData.txt",fName + "を読込しました")
		// 存在するとき
		var ret = xmlDoc.load(FileName)
		return(ret)
		}
	return(false)
	}

%>
