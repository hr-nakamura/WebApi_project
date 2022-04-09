using System;
using System.Web;
using System.Xml;
using System.Text;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Collections.Generic;



namespace WebApi_project.hostProc
{
	partial class hostProc
	{
		class para_dayChk
        {
			public int yymm { get; set; }
			public int day { get; set; }
		}
		public object json_dayChk(string Json)
        {
            var o_json = JsonConvert.DeserializeObject<para_dayChk>(Json);
			o_json.day = dayChk(o_json.yymm);
			return (o_json);
        }
		public int dayChk(int yymm, int adjustDayCnt = 7)
		{

			int yy = yymm / 100;
			int mm = yymm % 100;
			Dictionary<DateTime, bool> dBuff = new Dictionary<DateTime, bool>();
			DateTime sDate = new DateTime(yy, mm, 1);
			DateTime eDate = sDate.AddMonths(1).AddDays(-1);
			DateTime curDate = sDate;
			do
			{
				dBuff.Add(curDate, "0,6".Contains(curDate.DayOfWeek.ToString("d")));            // "0":日 ,"6":土
				curDate = curDate.AddDays(1);
			} while (curDate <= eDate);


			string SQL = "";
			StringBuilder sql = new StringBuilder("");

			SqlConnection DB = new SqlConnection(DB_connectString);
			DB.Open();
			sql.Append(" SELECT *");
			sql.Append(" FROM EMG.dbo.勤務出勤日");
			sql.Append(" WHERE 日付 BETWEEN @sDate AND @eDate");
			sql.Append(" AND memberID = 0");

			sql.Replace("@sDate", SqlUtil.Parameter("string", sDate));
			sql.Replace("@eDate", SqlUtil.Parameter("string", eDate));
			SQL = sql.ToString();
			DateTime targetDay;
			bool offDay;
			SqlDataReader reader = dbRead(DB, SQL);
			while (reader.Read())
			{
				targetDay = (DateTime)reader["日付"];
				offDay = (bool)reader["offDay"];
				if (dBuff.ContainsKey(targetDay)) dBuff[targetDay] = offDay;
			}
			reader.Close();
			DB.Close();
			DB.Dispose();

			int Cnt = 0;
			DateTime target = new DateTime();
			foreach (DateTime n in dBuff.Keys)
			{
				target = n;
				if (dBuff[n] == false) Cnt++;           // 出勤日を数える
				if (Cnt > adjustDayCnt) break;
			}
			return (target.Day);
		}
	}
}
