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
        //=========================================================================================

        public SortedDictionary<string, EntryInfoXml> sample_XML_部門収支 = new SortedDictionary<string, EntryInfoXml>() {
            { "_sample/部門収支/EMG収支計画", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'EMG',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/EMG収支計画.xml",
                }
            },
            { "_sample/部門収支/統括収支計画", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括一覧',secMode:'開発',dispMode:'統括',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/統括収支計画.xml",
                }
            },
            { "_sample/部門収支/部収支計画", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'部門一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:5}",
                dataX = "http://localhost/test/_xmlData/部収支計画.xml",
                }
            },
            { "_sample/部門収支/課収支計画", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'課一覧',dispName:'営業本部',secMode:'開発',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/課収支計画.xml",
                }
            },
        };
        //=========================================================================================
        public SortedDictionary<string, EntryInfoXml> sample1_XML_部門収支 = new SortedDictionary<string, EntryInfoXml>() {
            { "_sample/部門収支/統括収支計画1", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/統括収支計画.xml",
                }
            },
            { "_sample/部門収支/統括収支計画2", new EntryInfoXml{
                type = "xml",
                data = "http://localhost/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/統括収支計画.xml",
                }
            },
            // dispCmd=統括一覧 にすると：遅い、
            // dispName=指定しないと：全部持ってくる
            { "_sample/部門収支/統括収支計画_第一開発本部", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括詳細',secMode:'開発',dispName:'第1開発本部',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/統括収支計画.xml",
                }
            },
            { "_sample/部門収支/統括収支計画_第一開発本部2", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括個別',secMode:'開発',dispName:'第1開発本部',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/統括収支計画.xml",
                }
            },
            { "_sample/部門収支/統括収支計画_本社", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'統括詳細',secMode:'開発',dispName:'本社',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/統括収支計画.xml",
                }
            },
            { "_sample/部門収支/部収支計画", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'部門一覧',secMode:'開発',dispName:'',year:2022,fix:70,yosoku:5}",
                dataX = "http://localhost/test/_xmlData/部収支計画.xml",
                }
            },
            { "_sample/部門収支/課収支計画", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/部門収支/xml/部門収支_XML.asp",
                option = "{dispCmd:'課一覧',dispName:'営業本部',secMode:'開発',year:2022,fix:70,yosoku:3}",
                dataX = "http://localhost/test/_xmlData/課収支計画.xml",
                }
            },
        };
        //===================================================================================================================
        public SortedDictionary<string, EntryInfoXml> sample_XML_部門リスト = new SortedDictionary<string, EntryInfoXml>(){
            { "_sample/部門リスト/部門リスト_統括", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/common_data/xmlProc/部門リスト_XML.asp",
                option = "{dispMode:'統括',secMode:'開発',year:2022}",
                }
            },
            { "_sample/部門リスト/部門リスト_部", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/common_data/xmlProc/部門リスト_XML.asp",
                option = "{dispMode:'部',secMode:'開発',year:2022}",
                }
            },
            { "_sample/部門リスト/部門リスト_課", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/common_data/xmlProc/部門リスト_XML.asp",
                option = "{dispMode:'課',secMode:'開発',year:2022}",
                }
            },
            { "_sample/部門リスト/間接_部門リスト_統括", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/common_data/xmlProc/部門リスト_XML.asp",
                option = "{dispMode:'統括',secMode:'間接',year:2022}",
                }
            },
            { "_sample/部門リスト/間接_部門リスト_部", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/common_data/xmlProc/部門リスト_XML.asp",
                option = "{dispMode:'部',secMode:'間接',year:2022}",
                }
            },
            { "_sample/部門リスト/間接_部門リスト_課", new EntryInfoXml{
                type = "xml",
                data = "http://kansa.in.eandm.co.jp/Project/common_data/xmlProc/部門リスト_XML.asp",
                option = "{dispMode:'課',secMode:'間接',year:2022}",
                }
            },
        };


        public SortedDictionary<string, EntryInfoXml> sample_XML_要員情報 = new SortedDictionary<string, EntryInfoXml>(){
            { "_sample/要員情報/要員一覧_method", new EntryInfoXml{
                type = "method",
                data ="要員情報/要員一覧",
                option ="{year:2022,actual:5}"
                }
            },
        };
    }
}
