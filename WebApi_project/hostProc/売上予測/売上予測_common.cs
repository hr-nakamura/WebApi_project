using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測
    {
        // クラスでの共通情報
        string DB_connectString;
        public 売上予測()
        {
            hostProc hProc = new hostProc();
            DB_connectString = hProc.DB_connectString;
        }
        class SampleData
        {
            public string a { get; set; }
            public string b { get; set; }
        }

    }
}

