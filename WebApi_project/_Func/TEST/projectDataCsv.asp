<%@ Language=JavaScript %>

<%

    Session("memberID") = 451862;
//    Session("ODBC") = "DRIVER={SQL Server};SERVER={10.10.10.52};UID=readuser;PWD=readuser;DATABASE=kansaDB";

    Response.ContentType = "application/octet/stream"
//   Response.ContentType = "text/html; charset=SHIFT_JIS"
   Response.AddHeader("content-disposition","inline; filename=project.csv")

	var limitYear = 2020;

   var memberID = Session("memberID")

   var mode = String(Request.QueryString("mode"))
   if( mode == "undefined" ) mode = 1

   dispProject(mode,limitYear);
   
   Response.End
   
function csvOut(Str)
   {
// Response.Write( Str + "<BR>" )
   Response.Write( Str + "\n" )
   }




function dispProject(mode,limitYear)
   {

   var Head = [];
   var Buff = [];

//------------------------------------------------------------------

   var i = 0

   Head[i++] = "Stat:Integer";
   Head[i++] = "Mark:String";
   Head[i++] = "newFlag:Integer";
   Head[i++] = "プロジェクト名:String";
   Head[i++] = "pCode:String";
   Head[i++] = "pNum:Integer";
   Head[i++] = "更新日:String";
   Head[i++] = "営業:String";
   Head[i++] = "登録者:String";
   Head[i++] = "グループ名:String";

   Head[i++] = "客先会社:String";
   Head[i++] = "期間:String";
   Head[i++] = "規模:String";
   Head[i++] = "場所:String";


   var i = 0
    Buff[i++] = "Stat";
    Buff[i++] = "Mark";
    Buff[i++] = "newFlag";
    Buff[i++] = "プロジェクト名";
    Buff[i++] = "pCode";
    Buff[i++] = "pNum";
    Buff[i++] = "更新日";
    Buff[i++] = "登録者";
    Buff[i++] = "グループ名";

    Buff[i++] = "客先会社";
    Buff[i++] = "期間";
    Buff[i++] = "規模";
    Buff[i++] = "場所";




    csvOut(Head.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))

   }

%>
