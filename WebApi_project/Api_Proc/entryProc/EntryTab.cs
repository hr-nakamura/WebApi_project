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
        public Dictionary<string, EntryInfo> projectInfo = new Dictionary<string, EntryInfo>() {
            { "projectTest/test", new EntryInfo{
                type = "text",
                data = "http://localhost/Asp/Test/test.asp",
                option = "{year:2022,actual:'漢字'}"
                }
            },
            { "projectTest/kanji", new EntryInfo{
                type = "xml",
                data = "http://localhost/Asp/Test/漢字.asp",
                option = "{year:2022,actual:'漢字'}"
                }
            },
        };
        public Dictionary<string, EntryInfo> 部門収支 = new Dictionary<string, EntryInfo>() {
            { "部門収支/EMG収支計画", new EntryInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML_5.asp",
                option = "{dispCmd:'EMG',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/統括収支計画", new EntryInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML_5.asp",
                option = "{dispCmd:'統括一覧',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/部収支計画", new EntryInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML_5.asp",
                option = "{dispCmd:'部門一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:3}"
                }
            },
            { "部門収支/課収支計画", new EntryInfo{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML_5.asp",
                option = "{dispCmd:'課一覧',dispName:'営業本部',secMode:'開発',year:2022,fix:70,yosoku:3}"
                }
            },
        };
        public Dictionary<string, EntryInfo> projectBBS = new Dictionary<string, EntryInfo>(){
            { "projectBBS/projectList", new EntryInfo{
                type = "method",
                data ="projectBBS/projectList",
                option ="{beforBBS:'2021/06/30 00:00:00',visitBBS:'2021/07/07 10:12:12',limitYear:2019}"
                }
            },
        };
        public Dictionary<string, EntryInfo> projectCostProc = new Dictionary<string, EntryInfo>(){
            { "projectCostProc/projectInfo_XML_Detail", new EntryInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Detail.asp",
                option ="{pNum:20214693}"
                }
            },
            { "projectCostProc/projectInfo_XML_Join", new EntryInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Join.asp",
                option ="{pNum:20214693}"
                }
            },
            { "projectCostProc/projectInfoList_XML", new EntryInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp",
                option ="{pNum:20214693}"
                }
            },
        };
        public Dictionary<string, EntryInfo> 売上予測 = new Dictionary<string, EntryInfo>(){
            { "売上予測/売上予実_部門", new EntryInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "売上予測/売上予実_分類", new EntryInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "売上予測/売上予実_新規", new EntryInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
            { "売上予測/売上予実_新規2", new EntryInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<string, EntryInfo> 費用予測 = new Dictionary<string, EntryInfo>(){
            { "費用予測/費用状況", new EntryInfo{
                type = "json",
                data ="http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp",
                option ="{year:2022,actual:5}"
                }
            },
        };
        public Dictionary<string, EntryInfo> 要員情報 = new Dictionary<string, EntryInfo>(){
            { "要員情報/要員一覧", new EntryInfo{
                type = "xml",
                data ="http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp",
                option ="{year:2022,actual:5}"
                }
            },
        };

        public Dictionary<string, Dictionary<string, string>> EntryTabX = new Dictionary<string, Dictionary<string, string>>() {
            { "projectTest",new Dictionary<string, string>(){
                { "type", "method" },
                { "func", "projectInfo/projectTest" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "projectBBS/projectList",new Dictionary<string, string>(){
                { "type", "method" },
                { "func", "projectBBS/projectList" },
                { "option", "{beforBBS:'2021/06/30 00:00:00',visitBBS:'2021/07/07 10:12:12',limitYear:2019}" }
            } },
            { "projectCostProc/xml/projectInfo_XML_Detail",new Dictionary<string, string>(){
                { "type", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Detail.asp" },
                { "option", "{pNum:20214693}" }
            } },
            { "projectCostProc/xml/projectInfo_XML_Join",new Dictionary<string, string>(){
                { "type", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Join.asp" },
                { "option", "{pNum:20214693}" }
            } },
            { "projectCostProc/xml/projectInfoList_XML",new Dictionary<string, string>(){
                { "type", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp" },
                { "option", "{s_yymm:202110,mCnt:12}" }
            } },


            { "売上予測/売上予実_部門",new Dictionary<string, string>(){
                { "type", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_分類",new Dictionary<string, string>(){
                { "type", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_新規",new Dictionary<string, string>(){
                { "type", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_新規2",new Dictionary<string, string>(){
                { "type", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "費用予測/費用状況",new Dictionary<string, string>(){
                { "type", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "要員情報/要員一覧",new Dictionary<string, string>(){
                { "type", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
        };
    }
}
