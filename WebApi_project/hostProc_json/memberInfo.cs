using System;
using System.Web;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public partial class jsonProc
    {
        public Dictionary<string, string> memberInfo(string mailAddr)
        {
            Dictionary<string, string> hostInfo = new Dictionary<string, string>(){
                { "name" , "テスト　データ" },
                { "mail", "test@eandm.co.jp" },
                { "postCode", ""},
                { "postName", ""},
                { "所属名", ""},
                { "所属コード", ""},
                { "Tag" , "" }
                };

            memberInfoX1(mailAddr);
            memberInfoX2(mailAddr);

            return (hostInfo);
        }
        Dictionary<string, string> memberInfoX1(string mailAddr)
        {
            Dictionary<string, string> hostInfo = new Dictionary<string, string>();
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);
            try
            {
                DB.Open();
                Debug.Write("DB Open", DB_connectString);
                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                sql.Append("    mail = MAST.メールアドレス,");
                sql.Append("    name = MAST.姓 + ' ' + MAST.名,");
                sql.Append("    postCode = POST.postCode,");
                sql.Append("    postName = PMAST.name,");
                sql.Append("    mode = POST.兼務,");
                sql.Append("    gName = BMAST.部署名,");
                sql.Append("    gCode = BMAST.部署コード");

                sql.Append(" FROM");
                sql.Append("    EMG.dbo.社員基礎データ MAST");
                sql.Append("        LEFT JOIN(SELECT * FROM EMG.dbo.ポスト履歴 WHERE GETDATE() BETWEEN startDate AND endDate) POST");
                sql.Append("            ON MAST.社員ID = POST.memberID");
                sql.Append("        INNER JOIN EMG.dbo.部署マスタ BMAST");
                sql.Append("            ON POST.部署コード = BMAST.部署コード");
                sql.Append("        INNER JOIN EMG.dbo.ポストマスタ PMAST");
                sql.Append("            ON PMAST.postCode = POST.postCode");
                sql.Append(" WHERE");
                sql.Append("    MAST.メールアドレス = '" + mailAddr + "'");
    
                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.Write("reader Start");

                while (reader.Read())
                {
                    var pNum = (string)reader["名前"].ToString();
                    var pName = (string)reader["部門"];
                    var gCode = (string)reader["gCode"].ToString();
                    Debug.Write(pNum, pName, gCode);
                //if (!Tab.ContainsKey(pNum))
                //{
                //    Tab.Add(pNum, pName);
                //}
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
            return (hostInfo);
        }
        Dictionary<string, string> memberInfoX2(string mailAddr)
        {
            Dictionary<string, string> hostInfo = new Dictionary<string, string>();
            SqlConnection DB;
            DB = new SqlConnection(DB_connectString);
            try
            {
                DB.Open();
                Debug.Write("DB Open", DB_connectString);
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
                sql.Append("    MAST.メールアドレス = '" + mailAddr + "'");
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
                sql.Append("    MAST.メールアドレス = '" + mailAddr + "'");
                sql.Append("    AND");
                sql.Append("    DATA.mode = 1");


                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.Write("reader Start");

                while (reader.Read())
                {
                    var pNum = (string)reader["name"].ToString();
                    var pName = (string)reader["mID"];
                    var gCode = (string)reader["item"].ToString();
                    Debug.Write(pNum, pName, gCode);
                    //if (!Tab.ContainsKey(pNum))
                    //{
                    //    Tab.Add(pNum, pName);
                    //}
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
            return (hostInfo);
        }
    }
}
