using System;
using System.Web;
using System.Xml;
using System.Reflection;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class projectBBS : hostProc
    {
        public object json_projectEdit(String Json)
        {
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Dictionary<string, object> Info = new Dictionary<string, object>();
            Dictionary<string, object> Data = new Dictionary<string, object>();

            string classPath = this.GetType().FullName;                                         //クラスパスの取得
            string className = this.GetType().Name;                                             //クラス名の取得
            string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;           //メソッド名の取得
            Debug.WriteLog(classPath);

            string mName = Environment.MachineName;

            Info.Add("mName", mName);
            Info.Add("className", className);
            Info.Add("methodName", methodName);
            Info.Add("DB_Conn", DB_connectString);

            Tab.Add("Info", (object)Info);
            Tab.Add("Data", (object)Data);

            //XmlDocument xmlDoc = new XmlDocument();
            return (Tab);
        }

        public XmlDocument projectEdit(String Json)
        {
            //var o_json = JsonConvert.DeserializeObject<SampleData>(Json);

            object json_data = json_projectEdit(Json);
            XmlDocument xmlDoc = Json2Xml(json_data);
            //XmlDocument xmlDoc = new XmlDocument();

            //var x = new projectBBS();
            //Dictionary<string, object> Tab = (Dictionary<string, object>)x.projectList_json(Json);
            //object Data = (object) Tab["Data"];


            return (xmlDoc);
        }


        Dictionary<string, object> dbFunc_A()
        {
            SqlConnection DB;
            string pNum = "";
            string pName = "";
            Dictionary<string, object> Tab = new Dictionary<string, object>();

            try
            {
                DB = new SqlConnection(DB_connectString);
                DB.Open();
                Debug.noWrite("DB Open", DB_connectString);

                StringBuilder sql = new StringBuilder("");
                sql.Append(" SELECT");
                sql.Append("    pNum  = MAST.id,");
                sql.Append("    pName = MAST.mail");
                sql.Append(" FROM");
                sql.Append("    ログデータ MAST");
                //sql.Append(" WHERE");
                //sql.Append("    MAST.pName IS NOT NULL");


                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.noWrite("reader Start");

                int i = 10;
                while (reader.Read())
                {
                    pNum = (string)reader["pNum"].ToString();
                    pName = (string)reader["pName"];
                    Debug.noWrite(pNum, pName);
                    if (!Tab.ContainsKey(pNum))
                    {
                        Tab.Add(pNum, pName);
                    }
                    if (i-- == 0) break;
                }

                Debug.noWrite("reader Close");
                reader.Close();

                Debug.noWrite("DB Close");
                DB.Close();
                Debug.noWrite("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message);
            }
            finally
            {
                Debug.noWrite("DB null");
                DB = null;
            }
            return (Tab);
        }
        public XmlDocument projectList(String Json)
        {

     // <item name="limitYear"> 2019 </item>
     // <item name="yymm"> 202107 </item>
     // <item name="beforBBS">2021/06/30 00:00:00</item>
     // <item name="visitBBS">2021/07/07 10:12:12</item>

            Debug.WriteLog("projectList");
            var o_json = JsonConvert.DeserializeObject<projectPara>(Json);
            var visitBBS = o_json.visitBBS;
            var limitYear = o_json.limitYear;

            Dictionary<string,object>Tab = (Dictionary<string, object>) projectList_json(Json);
            List<DB_projectNum> Data = (List<DB_projectNum>)Tab["Data"];

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.CreateXmlDeclaration("1.0", null, null);

            var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
            XmlElement root = xmlDoc.CreateElement("root");

            XmlElement projectHead = xmlDoc.CreateElement("projectHead");
            XmlElement projectList = xmlDoc.CreateElement("projectList");

            var comment = xmlDoc.CreateComment("comment");
            xmlDoc.AppendChild(xmlMain);
            xmlDoc.AppendChild(comment);
            xmlDoc.AppendChild(root);
            foreach (DB_projectNum project in Data)
            {
                string[] work = project.Title.Split('\n');
                XmlElement projectNode = xmlDoc.CreateElement("pNum");
                projectList.AppendChild(projectNode);
                projectNode.SetAttribute("pNum", project.pNum.ToString());
                projectNode.SetAttribute("pCode", project.pCode);
                projectNode.SetAttribute("pName", project.pName);
                projectNode.SetAttribute("Stat", (string)project.Stat.ToString());
                projectNode.SetAttribute("登録者", project.登録者);
                projectNode.SetAttribute("グループ名", project.グループ名);
                projectNode.SetAttribute("客先会社", project.客先会社);
                projectNode.SetAttribute("Title", project.Title);
                projectNode.SetAttribute("営業", work[3]);
                projectNode.SetAttribute("更新日", project.editDate.Substring(5, 5));
                projectNode.SetAttribute("newFlag", Check_newFlag(project.editDate, visitBBS) );
                //Title[0] : 客先会社名
                //Title[1] : 客先部署
                //Title[2] : 客先担当者
                //Title[3] : 担当営業
                //Title[4] : 期間
                //Title[5] : 規模
                //Title[6] : 場所

            }
            root.AppendChild(projectHead);
            root.AppendChild(projectList);
            return (xmlDoc);
        }
        string Check_newFlag(string s_editDate, string s_visitDate)
        {
            string mode = "0";
            DateTime editDate = DateTime.Parse(s_editDate);
            DateTime visitDate = DateTime.Parse(s_visitDate);
            DateTime beforDate = visitDate.AddDays(-7);
            if (visitDate.CompareTo(editDate) < 0)
            {
                mode = "1";
            }
            else if (beforDate.CompareTo(editDate) < 0)
            {
                mode = "2";
            }
            return (mode);
        } 
        public object projectList_json(String Json)
        {
            Dictionary<string, object> Tab;
            Tab = json_Get_projectData(Json);
            return (Tab);
        }
        Dictionary<string, object> json_Get_projectData(String Json)
        {
            SqlConnection DB;

            Dictionary<string, object> Tab = new Dictionary<string, object>();
            Dictionary<string, object> Info = new Dictionary<string, object>();

            var o_json = JsonConvert.DeserializeObject<projectPara>(Json);
            var visitBBS = o_json.visitBBS;
            var limitYear = ( o_json.limitYear == "undefined" ? "2019" : o_json.limitYear);
            var i_limitYear = int.Parse(limitYear);
            string limitNum = (i_limitYear * 10000).ToString();

            List<DB_projectNum> Data = new List<DB_projectNum>();
            try
            {

                DB = new SqlConnection(DB_connectString);
                DB.Open();
                Debug.noWrite("DB Open", DB_connectString);

                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                //sql.Append("    ID           = projectNum.ID,");
                sql.Append("    Stat         = projectNum.Stat,");
                sql.Append("    pNum         = projectNum.pNum,");
                sql.Append("    pCode        = projectNum.pCode,");
                sql.Append("    pName        = projectNum.pName,");
                sql.Append("    userName     = projectNum.userName,");
                sql.Append("    corpName     = projectNum.corpName,");
                sql.Append("    gName        = (SELECT 部署名 FROM 部署マスタ WHERE 部署マスタ.部署コード = projectNum.部署ID),");
                sql.Append("    newDate      = CONVERT(CHAR(10),projectNum.newDate,111) + ' ' + CONVERT(CHAR(8),projectNum.newDate,14),");
                sql.Append("    makeDate     = CONVERT(CHAR(10),projectNum.makeDate,111) + ' ' + CONVERT(CHAR(8),projectNum.makeDate,14),");
                sql.Append("    editDate     = CONVERT(CHAR(10),projectNum.editDate,111) + ' ' + CONVERT(CHAR(8),projectNum.editDate,14),");
                //sql.Append("    Kind         = projectNum.Kind,");
                sql.Append("    Title        = projectNum.Title");
                sql.Append(" FROM");
                sql.Append("    projectNum");
                //INNER JOIN 部署マスタ ON projectNum.部署ID = 部署マスタ.部署コード");
                sql.Append(" WHERE");
                sql.Append("    projectNum.Project IN(2)");
                sql.Append("    AND");
                sql.Append("    projectNum.pName Is Not Null ");
                sql.Append("    AND");
                sql.Append("    (projectNum.pNum >= " + limitNum + " OR projectNum.stat NOT IN(5,-1) )");
                //sql.Append("    (projectNum.pNum >= " + limitNum +")");
                sql.Append(" ORDER BY");
                sql.Append("    projectNum.pNum DESC");


                Debug.noWrite("reader Start");
                SqlDataReader reader = dbRead(DB, sql.ToString());
                int Cnt = 0;
                while (reader.Read())
                {
                    DB_projectNum project = new DB_projectNum();
                    project.pNum = reader["pNum"].ToString();
                    project.pCode = (string)reader["pCode"];
                    project.pName = (string)reader["pName"];
                    project.Stat = (string)reader["Stat"].ToString();
                    project.グループ名 = (string)reader["gName"].ToString();       // グループ名
                    project.客先会社 = (string)reader["corpName"];                 // 客先会社名
                    project.登録者 = (string)reader["userName"];                   // 登録者
                    project.Title = reader["Title"].ToString();                    // 担当営業
                    project.newDate = (string)reader["newDate"];
                    project.makeDate = (string)reader["makeDate"];
                    project.editDate = (string)reader["editDate"];
                    project.No = (++Cnt).ToString();

                    Data.Add(project);
                    //if (i-- == 0) break;
                }
                Info.Add("Cnt", Cnt);
                Info.Add("limitYear", limitYear);
                Info.Add("visitBBS", visitBBS);
                Info.Add("SQL", sql.ToString());

                Tab.Add("Info", (object)Info);
                Tab.Add("Data", (object)Data);
                Debug.noWrite("reader Close");
                reader.Close();

                Debug.noWrite("DB Close");
                DB.Close();
                Debug.noWrite("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message);
                //Tab.Add("== ERROR ==", ex.Message);
            }
            finally
            {
                //Debug.noWrite("DB null");
                DB = null;
            }
            return (Tab);
        }

        class DB_projectNum
        {
            public string No { get; set; }
            public string pNum { get; set; }
            public string pCode { get; set; }
            public string pName { get; set; }
            public string Stat { get; set; }
            public string グループ名 { get; set; }
            public string 登録者 { get; set; }
            public string 客先会社 { get; set; }
            public string Title { get; set; }
            public string newDate { get; set; }
            public string makeDate { get; set; }
            public string editDate { get; set; }
        }
        class projectPara
        {
            public string visitBBS { get; set; }
            public string limitYear { get; set; }
        }
    }
}
