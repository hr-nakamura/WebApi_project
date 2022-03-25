using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

using WebApi_project.Models;
using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 売上予測 : hostProc
    {
        public XmlDocument 売上予実_部門(String s_option)
        {
            XmlDocument xmlDoc = LoadAsp("売上予実_部門", s_option);
            return (xmlDoc);
        }
        public XmlDocument 売上予実_分類(String s_option)
        {
            XmlDocument xmlDoc = LoadAsp("売上予実_分類", s_option);
            return (xmlDoc);
        }
        public XmlDocument 売上予実_新規(String s_option)
        {
            XmlDocument xmlDoc = LoadAsp("売上予実_新規", s_option);
            return (xmlDoc);
        }
        public XmlDocument 売上予実_新規2(String s_option)
        {
            XmlDocument xmlDoc = LoadAsp("売上予実_新規2", s_option);
            return (xmlDoc);
        }
    }

}
