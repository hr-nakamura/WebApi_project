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
   Head[i++] = "�v���W�F�N�g��:String";
   Head[i++] = "pCode:String";
   Head[i++] = "pNum:Integer";
   Head[i++] = "�X�V��:String";
   Head[i++] = "�c��:String";
   Head[i++] = "�o�^��:String";
   Head[i++] = "�O���[�v��:String";

   Head[i++] = "�q����:String";
   Head[i++] = "����:String";
   Head[i++] = "�K��:String";
   Head[i++] = "�ꏊ:String";


   var i = 0
    Buff[i++] = "Stat";
    Buff[i++] = "Mark";
    Buff[i++] = "newFlag";
    Buff[i++] = "�v���W�F�N�g��";
    Buff[i++] = "pCode";
    Buff[i++] = "pNum";
    Buff[i++] = "�X�V��";
    Buff[i++] = "�o�^��";
    Buff[i++] = "�O���[�v��";

    Buff[i++] = "�q����";
    Buff[i++] = "����";
    Buff[i++] = "�K��";
    Buff[i++] = "�ꏊ";




    csvOut(Head.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))
    csvOut(Buff.join(","))

   }

%>
