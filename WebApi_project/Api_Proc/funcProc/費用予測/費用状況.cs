using System;
using System.Web;
using System.Xml;
using System.Reflection;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

using System.IO;
using System.Text.Json;
using WebApi_project.Models;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class 費用予測 : hostProc
    {
        public XmlDocument 費用状況(String s_option)
        {
            XmlDocument xmlDoc = LoadAsp("費用状況", s_option);
            return (xmlDoc);
        }
    }
}