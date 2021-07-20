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
    public partial class jsonProc
    {

        public object 部門リスト_json()
        {
            dbFunc_A();

            return ("");
        }
        public Dictionary<string, object> dbFunc_A()
        {
            SqlConnection DB;
            string pNum = "";
            string pName = "";
            string gCode = "";
            Dictionary<string, object> Tab = new Dictionary<string, object>();
            string secMode = "直接";
            string dispMode = "統括";
            string s_yymm = "201810";
            string e_yymm = "201909";
            string secNum = "0,1,2";
            try
            {
                DB = new SqlConnection(DB_connectString);
                DB.Open();
                Debug.Write("DB Open", DB_connectString);

                StringBuilder sql = new StringBuilder("");

                sql.Append(" SELECT");
                sql.Append("   名前  = BMAST.部署名,");
                sql.Append("   直間  = TM.直間,");
                sql.Append("   統括  = TM.統括,");
                sql.Append("   部門  = TM.部門,");
                sql.Append("   課    = TM.グループ,");
                sql.Append("   gCode = TM.部署ID");

                sql.Append(" FROM");
                sql.Append("    統括本部マスタ TM");
                sql.Append("        LEFT JOIN EMG.dbo.部署マスタ BMAST ON TM.部署ID = BMAST.部署コード");
                sql.Append(" WHERE");
                sql.Append("    NOT(TM.開始 > '" + e_yymm + "' or TM.終了 < '" + s_yymm + "')");
                sql.Append("    AND");
                sql.Append("    TM.直間 IN(" + secNum + ")");
                if (secMode == "間接" && dispMode == "統括")
                {
                    sql.Append("    AND");
                    sql.Append("    TM.部署ID >= 0");
                }
                else
                {
                    sql.Append("    AND");
                    sql.Append("    TM.部署ID > 0");
                }

                sql.Append(" ORDER BY");
                sql.Append("    直間 desc,");
                sql.Append("    統括,");
                sql.Append("    部門,");
                sql.Append("    課,");
                sql.Append("    gCode");


                SqlDataReader reader = dbRead(DB, sql.ToString());
                Debug.Write("reader Start");

                while (reader.Read())
                {
                    pNum = (string)reader["名前"].ToString();
                    pName = (string)reader["部門"];
                    gCode = (string)reader["gCode"].ToString();
                    Debug.Write(pNum, pName,gCode);
                    if (!Tab.ContainsKey(pNum))
                    {
                        Tab.Add(pNum, pName);
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
            return (Tab);
        }
        //SqlDataReader dbRead(SqlConnection DB, string sql)
        //{
        //    SqlCommand cmd = null;
        //    try
        //    {
        //        Debug.Write("cmd Start");
        //        cmd = new SqlCommand(sql, DB);
        //        SqlDataReader reader = cmd.ExecuteReader();
        //        return (reader);
        //    }
        //    catch (Exception ex)
        //    {
        //        Debug.WriteLog(ex.Message);
        //        return (null);
        //    }
        //    finally
        //    {
        //        Debug.Write("cmd Dispose");
        //        cmd.Dispose();
        //        cmd = null;
        //    }
        //}

        /*
                SQL += " SELECT"
            SQL += "   名前  = BMAST.部署名,"
            SQL += "   直間  = TM.直間,"
            SQL += "   統括  = TM.統括,"
            SQL += "   部門  = TM.部門,"
            SQL += "   課    = TM.グループ,"
            SQL += "   gCode = TM.部署ID"

            SQL += " FROM"
            SQL += "    統括本部マスタ TM"
            SQL += "        LEFT JOIN EMG.dbo.部署マスタ BMAST ON TM.部署ID = BMAST.部署コード"
            SQL += " WHERE"
            SQL += "    NOT(TM.開始 > '" + e_yymm + "' or TM.終了 < '" + s_yymm + "')"
            SQL += "    AND"
            SQL += "    TM.直間 IN(" + secNum + ")"
            if(secMode == "間接" && dispMode == "統括" ){
                SQL += "    AND"
                SQL += "    TM.部署ID >= 0"
                }
            else{
                SQL += "    AND"
                SQL += "    TM.部署ID > 0"
                }

        SQL += " ORDER BY"
            SQL += "    直間 desc,"
            SQL += "    統括,"
            SQL += "    部門,"
            SQL += "    課,"
            SQL += "    gCode"
        */
    }
}
