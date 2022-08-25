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
        //===================================================================================================================
        public SortedDictionary<string, EntryInfoJson> projectInfo = new SortedDictionary<string, EntryInfoJson>() {
            { "projectInfo/memberInfo_json", new EntryInfoJson{
                type = "method",
                data = "hostProc/memberInfo_json",
                option = "{mailAddr:'nakamura@eandm.co.jp'}",
                dataX ="_Test/xml/memberInfo.json"
                }
            },
            { "projectInfo/dayChk_json", new EntryInfoJson{
                type = "method",
                data = "hostProc/dayChk_json",
                option = "{yymm:202204}"
                }
            },
        };
        public SortedDictionary<string, EntryInfoJson> sample_JSON = new SortedDictionary<string, EntryInfoJson>() {
            { "売上予測/グループ予実_部門", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/グループ予実_部門_JSON.asp",
                option ="{gName:'ACEL事業推進本部',yymm:202110,dispCnt:12,fix:70}",
                dataX = "http://localhost/test/_jsonData/グループ予実_部門_JSON.json",
                }
            },
            { "売上予測/グループ予実_分類", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/グループ予実_分類_JSON.asp",
                option ="{mode:'新規名',kind:'指定なし',yymm:202110,dispCnt:12,fix:70}",
                dataX = "http://localhost/test/_jsonData/グループ予実_分類_JSON.json",
                }
            },
            { "売上予測/グループ予実_分類2", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/グループ予実_分類_JSON.asp",
                option = "{mode:'分類名',kind:'指定なし',yymm:202110,dispCnt:12,actualCnt:7,fix:70}",
                dataX = "http://localhost/test/_jsonData/グループ予実_分類_JSON.json",
                }
            },
        };

    }
}
