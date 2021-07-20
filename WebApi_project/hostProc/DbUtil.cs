using System;
using System.Data;
using System.Data.SqlClient;

namespace WebApi_project.hostProc
{
    public class DbUtil
    {

        public static SqlParameter LongParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.BigInt);
            if (value == null || value.ToString() == "")
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter IntParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.Int);
            if (value == null || value.ToString() == "")
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter SmallIntParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.SmallInt);
            if (value == null)
            {
                sqlParam.Value = 0;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter NVarCharParameter(string name, int size, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.NVarChar, size);
            if (value == null)
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }

        public static SqlParameter DateTimeParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.DateTime);
            if (value == null || value.ToString() == "")
            {
                sqlParam.Value = DBNull.Value;
            }
            else
            {
                sqlParam.Value = value;
            }
            return (sqlParam);
        }
        
        public static SqlParameter TextParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.Text);
            sqlParam.Value = value;
            return (sqlParam);
        }
        
        public static SqlParameter XmlParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.Xml);
            sqlParam.Value = value;
            return (sqlParam);
        }

        public static SqlParameter VarBinaryParameter(string name, object value)
        {
            SqlParameter sqlParam = new SqlParameter(name, SqlDbType.VarBinary);
            sqlParam.Value = value;
            return (sqlParam);
        }

    }
}
