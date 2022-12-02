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
        public SortedDictionary<string, EntryInfoJson> projectInfo_JSON = new SortedDictionary<string, EntryInfoJson>() {
            { "projectInfo/memberInfo_json", new EntryInfoJson{
                type = "method",
                data = "hostProc/memberInfo_json",
                dataX = "/_Data/json/memberInfo.json",
                option = "{mailAddr:'nakamura@eandm.co.jp'}"
                }
            },
            { "projectInfo/dayChk_json", new EntryInfoJson{
                type = "method",
                data = "hostProc/dayChk_json",
                dataX = "/_Data/json/dayChk.json",
                option = "{yymm:202204}"
                }
            },
        };
// Jsonで作成したデータを確認するためのテーブル（実際はXMLに変換して使用する）
        public SortedDictionary<string, EntryInfoJson> sample_JSON = new SortedDictionary<string, EntryInfoJson>() {
            { "売上予測/売上目標_部門", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上目標_部門_JSON.asp",
                option ="{year:2022,fix:70}",
                dataX = "http://localhost/test/_jsonData/売上目標_部門_JSON.json",
                }
            },
            { "売上予測/売上予実_部門", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp",
                option ="{year:2022,fix:70}",
                dataX = "http://localhost/test/_jsonData/売上予実_部門_JSON.json",
                }
            },
            { "売上予測/売上予実_分類", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp",
                option ="{year:2022,fix:70}",
                dataX = "http://localhost/test/_jsonData/売上予実_分類_JSON.json",
                }
            },
            { "売上予測/売上予実_新規", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp",
                option ="{year:2022,fix:70}",
                dataX = "http://localhost/test/_jsonData/売上予実_新規_JSON.json",
                }
            },
            { "売上予測/売上予実_新規2", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp",
                option ="{year:2022,fix:70}",
                dataX = "http://localhost/test/_jsonData/売上予実_新規2_JSON.json",
                }
            },
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
                option ="{mode:'新規名',kind:'新規顧客',yymm:202110,dispCnt:12,fix:70}",
                dataX = "http://localhost/test/_jsonData/グループ予実_分類_JSON.json",
                }
            },
            { "売上予測/部門リスト", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門リスト_json.asp",
                option ="{year:2023,fixLevel:70,dispCnt:12}",
                }
            },
            { "費用予測/費用状況", new EntryInfoJson{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp",
                option ="{year:2022,fix:70,actual:5}",
                typeX = "xml",
                dataX = "http://localhost/test/_xmlData/費用状況.xml",
                }
            },
        };

    }
}
