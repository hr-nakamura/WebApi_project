<%
try{
    var xTab = main(year, dispCnt, fixLevel)
var x1 = 0;
var x2 = 0;
    var Tab = { "新規": [], "既存": [] };
    for (var  key in xTab) {
		if (key.indexOf("新規")) {
			Tab["新規"][x1++] = xTab[key];
            }
		else {
			Tab["既存"][x2++] = xTab[key];
            }
        }

    $JsonOut_P(xTab);
}catch(e){
	pr(e.message)
	}

    Response.End
%>