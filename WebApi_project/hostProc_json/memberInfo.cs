using System;
using System.Web;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class jsonProc
    {
        class in_Data
        {
            public string mailAddr { get; set; }
        }
        class para_memberInfo
        {
            public string name { get; set; }
            public string mail { get; set; }
            public string postCode { get; set; }
            public string postName { get; set; }
            public string 所属名 { get; set; }
            public string 所属コード { get; set; }
            public string Tag { get; set; }
            public List<para_memberInfo> 兼務 { get; set; }
        }
        public object json_memberInfo(String Json)
        {
            var o_json = JsonConvert.DeserializeObject<in_Data>(Json);
            o_json.mailAddr = "azuma@psl-em.co.jp";

            para_memberInfo hostInfo; ;
            string mailAddr = o_json.mailAddr;

            hostInfo = memberInfoX1(mailAddr);
            hostInfo.Tag = memberInfoX2(mailAddr);
            if(hostInfo.mail == null) hostInfo.mail = mailAddr;
            return (hostInfo);
        }
        para_memberInfo memberInfoX1(string mailAddr)
        {
            para_memberInfo hostInfo = new para_memberInfo();
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);
            List<para_memberInfo> sub = new List<para_memberInfo>();

            try
            {
                Debug.Write("DB Open", DB_connectString);
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
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql.ToString();
                cmd.Parameters.Add(DbUtil.NVarCharParameter("@mailAddr", 32, mailAddr));

                DB.Open();
                cmd.Connection = DB;

                SqlDataReader reader = cmd.ExecuteReader();
                Debug.Write("reader Start");
                cmd.Dispose();
                Debug.Write("cmd Dispose");

                while (reader.Read())
                {
                    var mode = (string)reader["mode"].ToString();
                    if (mode == "0")
                    {
                        hostInfo.mail = (string)reader["mail"].ToString();
                        hostInfo.name = (string)reader["name"].ToString();
                        hostInfo.postCode = (string)reader["postCode"].ToString();
                        hostInfo.postName = (string)reader["postName"].ToString();
                        hostInfo.所属コード = (string)reader["groupCode"].ToString();
                        hostInfo.所属名 = (string)reader["groupName"].ToString();
                    }
                    else
                    {
                        var work = new para_memberInfo();
                        work.mail = (string)reader["mail"].ToString();
                        work.name = (string)reader["name"].ToString();
                        work.postCode = (string)reader["postCode"].ToString();
                        work.postName = (string)reader["postName"].ToString();
                        work.所属コード = (string)reader["groupCode"].ToString();
                        work.所属名 = (string)reader["groupName"].ToString();
                        sub.Add(work);

                    }
                }
                hostInfo.兼務 = sub;
                Debug.Write("reader Close");
                reader.Close();

                Debug.Write("DB Close");
                DB.Close();
                Debug.Write("DB Dispose");
                DB.Dispose();
                }
                catch (Exception ex)
                {
                    Debug.WriteLog(ex.Message);
                }
                finally
                {
                    Debug.Write("DB null");
                    DB = null;
                 }
            return (hostInfo);
        }
        string memberInfoX2(string mailAddr)
        {
            Dictionary<string, string> Tab = new Dictionary<string, string>();
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);
            try
            {
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

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql.ToString();
                cmd.Parameters.Add(DbUtil.NVarCharParameter("@mailAddr", 32,mailAddr));

                Debug.Write("DB Open", DB_connectString);
                DB.Open();
                cmd.Connection = DB;

                SqlDataReader reader = cmd.ExecuteReader();
                Debug.Write("reader Start");
                cmd.Dispose();
                Debug.Write("cmd Dispose");
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
                    //Debug.Write(name, mID, item, mode);
                    if (!Tab.ContainsKey(item))
                    {
                        Tab.Add(item, mode);
                    }
                }

                Debug.Write("reader Close");
                reader.Close();

                Debug.Write("DB Close");
                DB.Close();
                Debug.Write("DB Dispose");
                DB.Dispose();
            }
            catch (Exception ex)
            {
                Debug.WriteLog(ex.Message);
            }
            finally
            {
                Debug.Write("DB null");
                DB = null;
            }
            List<string> xTab = new List<string>();
            foreach (var item in Tab)
            {
                xTab.Add(item.Key);
            }
            xTab.Sort();
            return (string.Join(",",xTab) );
        }
    }
}
