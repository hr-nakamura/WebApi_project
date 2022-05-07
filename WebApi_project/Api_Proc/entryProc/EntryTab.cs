using System;
using System.Web;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;
using DebugHost;
using WebApi_project.Models;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {
        public Dictionary<string, EntryInfoXml> 部門収支 = new Dictionary<string, EntryInfoXml>() {
            { "部門収支/部門収支_XML", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'EMG',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/sample/EMG収支計画", new EntryInfoXml{
                //type = "xml",
                //data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/EMG収支計画.xml",
                option = "{dispCmd:'EMG',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/sample/統括収支計画", new EntryInfoXml{
                //type = "xml",
                //data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/統括収支計画.xml",
                option = "{dispCmd:'統括一覧',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/sample/部収支計画", new EntryInfoXml{
                //type = "xml",
                //data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/部収支計画.xml",
                option = "{dispCmd:'部門一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/sample/課収支計画", new EntryInfoXml{
                //type = "xml",
                //data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/課収支計画.xml",
                option = "{dispCmd:'課一覧',dispName:'営業本部',secMode:'開発',year:2022,fix:70,yosoku:3}"
                }
            },
        };
        public Dictionary<string, EntryInfoXml> projectCostProc = new Dictionary<string, EntryInfoXml>(){
            { "projectCostProc/projectInfo_XML_Detail", new EntryInfoXml{
                //type = "xml",
                //data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Detail.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/projectInfo_XML_Detail.xml",
                option ="{pNum:20214693}"
                }
            },
            { "projectCostProc/projectInfo_XML_Join", new EntryInfoXml{
                //type = "xml",
                //data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Join.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/projectInfo_XML_Join.xml",
                option ="{pNum:20214693}"
                }
            },
            { "projectCostProc/projectInfoList_XML", new EntryInfoXml{
                //type = "xml",
                //data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/projectInfoList_XML.xml",
                option ="{pNum:20214693}"
                }
            },
        };
        public Dictionary<string, EntryInfoXml> 売上予測 = new Dictionary<string, EntryInfoXml>(){
            { "売上予測/売上予実_部門", new EntryInfoXml{
                //type = "json",
                //data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/売上予実_部門.xml",
                option ="{year:2022,actual:6}"
                }
            },
            { "売上予測/売上予実_分類", new EntryInfoXml{
                //type = "json",
                //data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/売上予実_分類.xml",
                option ="{year:2022,actual:6}"
                }
            },
            { "売上予測/売上予実_新規", new EntryInfoXml{
                //type = "json",
                //data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/売上予実_新規.xml",
                option ="{year:2022,actual:6}"
                }
            },
            { "売上予測/売上予実_新規2", new EntryInfoXml{
                type = "json",
                data ="http://localhost/Project/売上予測/json/売上予実_新規2_JSON.asp",
                //type = "xml",
                //data = "http://localhost/test/_xmlData/売上予実_新規2.xml",
                option ="{year:2022,actual:6}"
                }
            },
        };
        public Dictionary<string, EntryInfoXml> 費用予測 = new Dictionary<string, EntryInfoXml>(){
            { "費用予測/費用状況", new EntryInfoXml{
                //type = "json",
                //data ="http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp",
                type = "xml",
                data = "http://localhost/test/_xmlData/費用状況.xml",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<string, EntryInfoXml> 要員情報 = new Dictionary<string, EntryInfoXml>(){
            { "要員情報/要員一覧", new EntryInfoXml{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "要員情報/要員一覧_method", new EntryInfoXml{
                type = "method",
                data ="要員情報/要員一覧",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<string, EntryInfoXml> projectBBS = new Dictionary<string, EntryInfoXml>(){
            { "projectBBS/projectList", new EntryInfoXml{
                type = "method",
                data ="projectBBS/projectList",
                option ="{beforBBS:'2021/06/30 00:00:00',visitBBS:'2021/07/07 10:12:12',limitYear:2019}"
                }
            },
        };

        public Dictionary<string, EntryInfoJson> projectInfo = new Dictionary<string, EntryInfoJson>() {
            { "売上予実_新規2_JSON", new EntryInfoJson{
                type = "json",
                data ="http://localhost/Project/売上予測/json/売上予実_新規2_JSON.asp",
                option ="{year:2022,actual:6}"
                }
            },
            { "projectInfo/memberInfo_json", new EntryInfoJson{
                type = "method",
                data = "hostProc/memberInfo_json",
                option = "{mailAddr:'nakamura@eandm.co.jp'}"
                }
            },
            { "projectInfo/dayChk_json", new EntryInfoJson{
                type = "method",
                data = "hostProc/dayChk_json",
                option = "{yymm:202204}"
                }
            },
        };
    }
}
