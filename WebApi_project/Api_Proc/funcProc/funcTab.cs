using System;
using System.Web;
using System.Collections.Generic;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {
        public Dictionary<string, Dictionary<string, string>> funcTab = new Dictionary<string, Dictionary<string, string>>() {
            { "XX",new Dictionary<string, string>(){
                { "mode", "method" },
                { "url", "hostProc/TestX" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_部門",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_部門_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_分類",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_分類_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_新規",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "売上予実_新規2",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/売上予測/json/売上予実_新規2_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "費用状況",new Dictionary<string, string>(){
                { "mode", "json" },
                { "url", "http://kansa.in.eandm.co.jp/Project/費用予測/json/EMG費用状況_JSON.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
            { "要員一覧",new Dictionary<string, string>(){
                { "mode", "xml" },
                { "url", "http://kansa.in.eandm.co.jp/Project/要員情報/要員一覧/xml/要員一覧_XML.asp" },
                { "option", "{year:2022,actual:5}" }
            } },
        };
    }
}
