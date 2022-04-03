using System;
using System.Web;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;
using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {
        public Dictionary<string, Dictionary<string, string>> xmlEntryTab = new Dictionary<string, Dictionary<string, string>>() {
            { "projectTest",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "projectInfo/projectTest" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "projectBBS/projectList",new Dictionary<string, string>(){
                { "mode", "method" },
                { "func", "projectBBS/projectList" },
                { "option", "{beforBBS:'2021/06/30 00:00:00',visitBBS:'2021/07/07 10:12:12',limitYear:2019}" }
            } },
            { "projectCostProc/xml/projectInfo_XML_Detail",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Detail.asp" },
                { "option", "{pNum:20214693}" }
            } },
            { "projectCostProc/xml/projectInfo_XML_Join",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfo_XML_Join.asp" },
                { "option", "{pNum:20214693}" }
            } },
            { "projectCostProc/xml/projectInfoList_XML",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/projectCostProc/xml/projectInfoList_XML.asp" },
                { "option", "{s_yymm:202110,mCnt:12}" }
            } },
            { "売上予測/売上予実_部門",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_分類",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_新規",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予測/売上予実_新規2",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "費用予測/費用状況",new Dictionary<string, string>(){
                { "mode", "json" },
                { "func", "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "要員情報/要員一覧",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "func", "http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
        };
    }
}
