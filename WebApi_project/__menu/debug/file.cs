using System;
using System.Web;

namespace WebApi_project.__menu.debug
{
    public class file : IHttpModule
    {
        /// <summary>
        /// モジュールを使用するには、Web の Web.config ファイルでこの
        /// モジュールを設定し、IIS に登録する必要があります。詳細については、
        /// 次のリンクをご覧ください: https://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpModule Members

        public void Dispose()
        {
            //後処理用コードはここに追加します。
        }

        public void Init(HttpApplication context)
        {
            // LogRequest イベントの処理方法とそれに対するカスタム ログの 
            // 実装方法の例を以下に示します
            context.LogRequest += new EventHandler(OnLogRequest);
        }

        #endregion

        public void OnLogRequest(Object source, EventArgs e)
        {
            //カスタム ログのロジックはここに挿入します
        }
    }
}
