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
        XmlDocument 売上予実_部門(object option)
        {
            string s_option = JsonConvert.SerializeObject(option);
            XmlDocument xmlDoc = new XmlDocument();

            //XmlDocument xmlDoc = LoadAsp("売上予実_部門", s_option);
            return (xmlDoc);
        }
        XmlDocument 売上予実_分類(object option)
        {
            string s_option = JsonConvert.SerializeObject(option);
            XmlDocument xmlDoc = new XmlDocument();
            //XmlDocument xmlDoc = LoadAsp("売上予実_分類", s_option);
            return (xmlDoc);
        }
        XmlDocument 売上予実_新規(object option)
        {
            string s_option = JsonConvert.SerializeObject(option);
            XmlDocument xmlDoc = new XmlDocument();
            //XmlDocument xmlDoc = LoadAsp("売上予実_新規", s_option);
            return (xmlDoc);
        }
        XmlDocument 売上予実_新規2(object option)
        {
            string s_option = JsonConvert.SerializeObject(option);
            XmlDocument xmlDoc = new XmlDocument();
            //XmlDocument xmlDoc = LoadAsp("売上予実_新規2", s_option);
            return (xmlDoc);
        }
    }

}
