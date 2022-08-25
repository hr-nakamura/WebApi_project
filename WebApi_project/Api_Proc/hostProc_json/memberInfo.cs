using System;
using System.Web;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Xml;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class hostProc
    {
        public XmlDocument memberInfo(String Json)
        {
            if( Json == "{}")
            {
                Json = "{mailAddr : 'nakamura@eandm.co.jp'}";
            }
            //            var o_json = JsonConvert.DeserializeObject<SampleData>(Json);
            object json_data = memberInfo_json(Json);
            string sJson = JsonConvert.SerializeObject(json_data);                      // Json形式を文字列に
            XmlDocument xmlDoc = JsonConvert.DeserializeXmlNode(sJson, "root");         // Json文字列をXML　objectに

            //XmlDocument xmlDoc = Json2Xml(json_data);

            return (xmlDoc);
        }

        public object memberInfo_json(string Json)
        {
            try
            {

            var o_json = JsonConvert.DeserializeObject<para_mailInfo>(Json);
            if (o_json.mailAddr == null) o_json.mailAddr = "azuma@psl-em.co.jp";

            s_memberInfo memberInfo; 
            string mailAddr = o_json.mailAddr;

            memberInfo = memberInfo_DB1(mailAddr);
            if (memberInfo.mail == null)
            {
                memberInfo.mail = mailAddr;
            }
            else
            {
                memberInfo.Tag = memberInfo_DB2(mailAddr);
            }
            return (memberInfo);
            }catch(Exception ex)
            {
                MyDebug.Write(ex.Message);
                return (new object());
            }
        }
        s_memberInfo memberInfo_DB1(string mailAddr)
        {
            s_memberInfo memberInfo = new s_memberInfo();
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);

            List<s_memberInfo> sub = new List<s_memberInfo>();

            try
            {
                MyDebug.noWrite("DB Open", DB_connectString);
                DB.Open();

                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                sql.Append("    mail = MAST.メールアドレス,");
                sql.Append("    name = MAST.姓 + ' ' + MAST.名,");
                sql.Append("    postCode = POST.postCode,");
                sql.Append("    postName = PMAST.name,");
                sql.Append("    mode = POST.兼務,");
                sql.Append("    groupName = BMAST.部署名,");
                sql.Append("    groupCode = BMAST.部署コード");

                sql.Append(" FROM");
                sql.Append("    EMG.dbo.社員基礎データ MAST");
                sql.Append("        LEFT JOIN(SELECT * FROM EMG.dbo.ポスト履歴 WHERE GETDATE() BETWEEN startDate AND endDate) POST");
                sql.Append("            ON MAST.社員ID = POST.memberID");
                sql.Append("        INNER JOIN EMG.dbo.部署マスタ BMAST");
                sql.Append("            ON POST.部署コード = BMAST.部署コード");
                sql.Append("        INNER JOIN EMG.dbo.ポストマスタ PMAST");
                sql.Append("            ON PMAST.postCode = POST.postCode");
                sql.Append(" WHERE");
                sql.Append("    MAST.メールアドレス = @mailAddr");
                sql.Append(" ORDER BY");
                sql.Append("    mode");

                sql.Replace("@mailAddr", SqlUtil.Parameter("string",mailAddr));

                SqlDataReader reader = dbRead(DB, sql.ToString());

                while (reader.Read())
                {
                    var mode = (string)reader["mode"].ToString();
                    if (mode == "0")
                    {
                        memberInfo.mail = (string)reader["mail"].ToString();
                        memberInfo.name = (string)reader["name"].ToString();
                        memberInfo.postCode = (string)reader["postCode"].ToString();
                        memberInfo.postName = (string)reader["postName"].ToString();
                        memberInfo.所属コード = (string)reader["groupCode"].ToString();
                        memberInfo.所属名 = (string)reader["groupName"].ToString();
                    }
                    else
                    {
                        var work = new s_memberInfo();
                        work.mail = (string)reader["mail"].ToString();
                        work.name = (string)reader["name"].ToString();
                        work.postCode = (string)reader["postCode"].ToString();
                        work.postName = (string)reader["postName"].ToString();
                        work.所属コード = (string)reader["groupCode"].ToString();
                        work.所属名 = (string)reader["groupName"].ToString();
                        sub.Add(work);

                    }
                }
                memberInfo.兼務 = sub;
                MyDebug.noWrite("reader Close");
                reader.Close();

                MyDebug.noWrite("DB Close");
                DB.Close();
                MyDebug.noWrite("DB Dispose");
                DB.Dispose();
                }
                catch (Exception ex)
                {
                MyDebug.WriteLog(ex.Message);
                }
                finally
                {
                MyDebug.noWrite("DB null");
                    DB = null;
                 }
            return (memberInfo);
        }
        List<string> memberInfo_DB2(string mailAddr)
        {
            Dictionary<string, string> Tab = new Dictionary<string, string>();
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);
            try
            {
                MyDebug.noWrite("DB Open", DB_connectString);
                DB.Open();
                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                sql.Append("    name = '個別',");
                sql.Append("    mID  = DATA.memberID,");
                sql.Append("    item = DATA.許可位置,");
                sql.Append("    mode = DATA.mode");
                sql.Append(" FROM");
                sql.Append("    ページ参照許可情報 DATA INNER JOIN EMG.dbo.社員基礎データ MAST");
                sql.Append("        ON DATA.memberID = MAST.社員ID");

                sql.Append(" WHERE");
                sql.Append("    MAST.メールアドレス = @mailAddr");
                sql.Append("    AND");
                sql.Append("    DATA.mode = 1");
                sql.Append(" UNION ALL ");

                sql.Append(" SELECT");
                sql.Append("    name = 'ポスト',");
                sql.Append("    mID  = DATA.memberID,");
                sql.Append("    item = DATA.許可位置,");
                sql.Append("    mode = DATA.mode");
                sql.Append(" FROM");
                sql.Append("    ページ参照許可情報 DATA");
                sql.Append("          INNER JOIN (SELECT * FROM EMG.dbo.ポスト履歴 WHERE GETDATE() BETWEEN startDate AND endDate) POST");
                sql.Append("              ON DATA.memberID = POST.postCode");
                sql.Append("          INNER JOIN EMG.dbo.社員基礎データ MAST");
                sql.Append("              ON POST.memberID = MAST.社員ID");
                sql.Append(" WHERE");
                sql.Append("    MAST.メールアドレス = @mailAddr");
                sql.Append("    AND");
                sql.Append("    DATA.mode = 1");
                sql.Append(" ORDER BY");
                sql.Append("    item");

                sql.Replace("@mailAddr", SqlUtil.Parameter("string", mailAddr));

                SqlDataReader reader = dbRead(DB, sql.ToString());

                var name = "";
                var mID = "";
                var item = "";
                var mode = "";
                while (reader.Read())
                {
                    name = (string)reader["name"].ToString();
                    mID = (string)reader["mID"].ToString();
                    item = (string)reader["item"].ToString();
                    mode = (string)reader["mode"].ToString();
                    //Debug.noWrite(name, mID, item, mode);
                    if (!Tab.ContainsKey(item))
                    {
                        Tab.Add(item, mode);
                    }
                }

                MyDebug.noWrite("reader Close");
                reader.Close();

                MyDebug.noWrite("DB Close");
                DB.Close();
                MyDebug.noWrite("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                MyDebug.WriteLog(ex.Message);
            }
            finally
            {
                MyDebug.noWrite("DB null");
                DB = null;
            }
            List<string> xTab = new List<string>();
            foreach (var item in Tab)
            {
                xTab.Add(item.Key);
            }
            xTab.Sort();
//            return (string.Join(",", xTab));
            return (xTab);
        }
    }
    class para_mailInfo
    {
        public string mailAddr { get; set; }
    }
    class s_memberInfo
    {
        public string name { get; set; }
        public string mail { get; set; }
        public string postCode { get; set; }
        public string postName { get; set; }
        public string 所属名 { get; set; }
        public string 所属コード { get; set; }
        public List<string> Tag { get; set; }             // 許可情報
        public List<s_memberInfo> 兼務 { get; set; }
        public s_memberInfo()
        {
            this.兼務 = new List<s_memberInfo>();
            this.Tag = new List<string>();
        }
    }
}
