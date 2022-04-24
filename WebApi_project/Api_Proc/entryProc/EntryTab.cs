﻿using System;
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
        public Dictionary<string, EntryXmlInfo> 部門収支 = new Dictionary<string, EntryXmlInfo>() {
            { "部門収支/部門収支_XML", new EntryXmlInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'EMG',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/EMG収支計画", new EntryXmlInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'EMG',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/統括収支計画", new EntryXmlInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括一覧',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/部収支計画", new EntryXmlInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'部門一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/課収支計画", new EntryXmlInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'課一覧',dispName:'営業本部',secMode:'開発',year:2022,fix:70,yosoku:3}"
                }
            },
        };
        public Dictionary<string, EntryXmlInfo> projectBBS = new Dictionary<string, EntryXmlInfo>(){
            { "projectBBS/projectList", new EntryXmlInfo{
                type = "method",
                data ="projectBBS/projectList",
                option ="{beforBBS:'2021/06/30 00:00:00',visitBBS:'2021/07/07 10:12:12',limitYear:2019}"
                }
            },
        };
        public Dictionary<string, EntryXmlInfo> projectCostProc = new Dictionary<string, EntryXmlInfo>(){
            { "projectCostProc/projectInfo_XML_Detail", new EntryXmlInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Detail.asp",
                option ="{pNum:20214693}"
                }
            },
            { "projectCostProc/projectInfo_XML_Join", new EntryXmlInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Join.asp",
                option ="{pNum:20214693}"
                }
            },
            { "projectCostProc/projectInfoList_XML", new EntryXmlInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp",
                option ="{pNum:20214693}"
                }
            },
        };
        public Dictionary<string, EntryXmlInfo> 売上予測 = new Dictionary<string, EntryXmlInfo>(){
            { "売上予測/売上予実_部門", new EntryXmlInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "売上予測/売上予実_分類", new EntryXmlInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "売上予測/売上予実_新規", new EntryXmlInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "売上予測/売上予実_新規2", new EntryXmlInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<string, EntryXmlInfo> 費用予測 = new Dictionary<string, EntryXmlInfo>(){
            { "費用予測/費用状況", new EntryXmlInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<string, EntryXmlInfo> 要員情報 = new Dictionary<string, EntryXmlInfo>(){
            { "要員情報/要員一覧", new EntryXmlInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "要員情報/要員一覧_method", new EntryXmlInfo{
                type = "method",
                data ="要員情報/要員一覧",
                option ="{year:2022,actual:5}"
                }
            },
        };

        public Dictionary<string, EntryJsonInfo> projectInfo = new Dictionary<string, EntryJsonInfo>() {
            { "hostProc/memberInfo_json", new EntryJsonInfo{
                type = "method",
                data = "hostProc/memberInfo_json",
                option = "{mailAddr:'nakamura@eandm.co.jp'}"
                }
            },
            { "projectInfo/dayChk_json", new EntryJsonInfo{
                type = "method",
                data = "hostProc/dayChk_json",
                option = "{yymm:202204}"
                }
            },
        };
    }
}
