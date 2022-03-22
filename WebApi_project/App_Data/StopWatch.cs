using System;
using System.Diagnostics;
using System.Collections.Generic;

using DebugHost;

namespace CodingSquareCS
{
	/// <summary>
	/// ストップウォッチ
	/// </summary>
	public class StopWatch : IDisposable
	{
		#region Constructions
		/// <summary>
		/// コンストラクタ
		/// </summary>
		List<string> work;
		public StopWatch()
		{
			// 計測用の内部ストップウォッチインスタンス作成
			Timer = new Stopwatch();
		}
		#endregion Constructions

		#region Methods
		/// <summary>
		/// 計測開始
		/// </summary>
		/// <param name="title">タイトル</param>
		public void Start(string title = "Stopwatch")
		{
			// タイトルと見出し表示
			//Trace.WriteLine($"-------------------< {title} >-------------------");
			//Trace.WriteLine("Total Time       | Lap Time         | Comment");

			work = new List<string>();
			work.Add("");
			work.Add($"-------------------< {title} >-------------------");
			work.Add($"Total Time       | Lap Time         | Comment");

			// 区間計測用の前回経過時間の初期化
			LastElapsed = new TimeSpan();

			// 時計をリセットして計測開始
			Timer.Restart();
		}

		/// <summary>
		/// 区間計測（ラップタイム）
		/// </summary>
		/// <param name="comment">コメント</param>
		public void Lap(string comment = "Lap")
		{
			// 計測を止めて時間を表示
			Stop(comment);

			// 計測再開
			Timer.Start();
		}

		/// <summary>
		/// 計測終了
		/// </summary>
		/// <param name="comment">コメント</param>
		public void Stop(string comment = "Stop")
		{
			// 計測を止める
			Timer.Stop();

			// 経過時間の合計
			TimeSpan elapsed = Timer.Elapsed;

			// ラップタイム
			TimeSpan lap = elapsed - LastElapsed;

			// 時間表示
			//Trace.WriteLine($"{elapsed} | {lap} | " + comment);

			if( comment != "Stop")
            {
				work.Add($"{elapsed} | {lap} | " + comment);
			}
			else
			{
				work.Add($"{elapsed} | {lap} | " + comment);
				work.Add($"===================< 計測終了 >===================");

				string output = string.Join(Environment.NewLine, work.ToArray());
                DebugHost.MyDebug.Write(output);
            }

			// 前回経過時間として今回の経過時間を退避
			LastElapsed = elapsed;
		}

		/// <summary>
		/// リソース解放
		/// </summary>
		public void Dispose()
		{
			Timer.Stop();
			Timer = null;
		}
		#endregion Methods

		#region Fields
		/// <summary>
		/// 内部的に利用しているストップウォッチ
		/// </summary>
		private Stopwatch Timer = null;

		/// <summary>
		/// 区間計測用の前回経過時間
		/// </summary>
		private TimeSpan LastElapsed = new TimeSpan();
		#endregion Fields
	}
}