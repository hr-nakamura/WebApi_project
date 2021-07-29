using System;
using System.Web;

namespace WebApi_project.Models
{
    public class 売上原価
    {
        public int[] 外注費 { get; set; }
        public int[] 仕入費 { get; set; }
        public int[] 外注費_EMG間費用 { get; set; }
        public int[] 仕入費_EMG間費用 { get; set; }
        public int[] 期首棚卸 { get; set; }
        public int[] 期末棚卸 { get; set; }
        public 売上原価()
        {
            this.外注費 = new int[12];
            this.仕入費 = new int[12];
            this.外注費_EMG間費用 = new int[12];
            this.仕入費_EMG間費用 = new int[12];
            this.期首棚卸 = new int[12];
            this.期末棚卸 = new int[12];
        }
    }
    public class 売上高
    {
        public int[] 売上 { get; set; }
        public 売上高()
        {
            this.売上 = new int[12];
        }
    }
    public class 予算
    {
        public int[] _予算 { get; set; }
        public 予算()
        {
            this._予算 = new int[12];
        }
    }
    public class 販管費
    {
        public int[] 人件費 { get; set; }
        public int[] 雑給 { get; set; }
        public int[] 広告交際 { get; set; }
        public int[] 交通費 { get; set; }
        public int[] 通信費 { get; set; }
        public int[] 発送費 { get; set; }
        public int[] 備品 { get; set; }
        public int[] 設備費 { get; set; }
        public int[] 家賃 { get; set; }
        public int[] その他 { get; set; }
        public int[] EMG間費用 { get; set; }
        public 販管費()
        {
            this.人件費 = new int[12];
            this.雑給 = new int[12];
            this.広告交際 = new int[12];
            this.交通費 = new int[12];
            this.通信費 = new int[12];
            this.発送費 = new int[12];
            this.備品 = new int[12];
            this.設備費 = new int[12];
            this.家賃 = new int[12];
            this.その他 = new int[12];
            this.EMG間費用 = new int[12];
        }
    }
    public class 固定資産
    {
        public int[] 機器_ソフト { get; set; }
        public 固定資産()
        {
            this.機器_ソフト = new int[12];
        }
    }
    public class 営業外収益
    {
        public int[] 雑収入他 { get; set; }
        public int[] EMG間費用 { get; set; }
        public 営業外収益()
        {
            this.雑収入他 = new int[12];
            this.EMG間費用 = new int[12];
        }
    }
    public class 営業外費用
    {
        public int[] 雑支出他 { get; set; }
        public int[] EMG間費用 { get; set; }
        public 営業外費用()
        {
            this.雑支出他 = new int[12];
            this.EMG間費用 = new int[12];
        }
    }
    public class 部門固定費
    {
        public int[] その他 { get; set; }
        public int[] 光熱費 { get; set; }
        public int[] 事務所費 { get; set; }
        public int[] 人件費 { get; set; }
        public int[] 転勤費 { get; set; }
        public 部門固定費()
        {
            this.その他 = new int[12];
            this.光熱費 = new int[12];
            this.事務所費 = new int[12];
            this.人件費 = new int[12];
            this.転勤費 = new int[12];
        }
    }
    public class 本社費配賦
    {
        public int[] 本社費 { get; set; }
        public 本社費配賦()
        {
            this.本社費 = new int[12];
        }
    }
    public class 売上付替
    {
        public int[] 収入 { get; set; }
        public int[] 支出 { get; set; }
        public 売上付替()
        {
            this.収入 = new int[12];
            this.支出 = new int[12];
        }
    }
    public class 費用付替
    {
        public int[] 収入 { get; set; }
        public int[] 支出 { get; set; }
        public 費用付替()
        {
            this.収入 = new int[12];
            this.支出 = new int[12];
        }
    }
    public class 要員数
    {
        public int[] 社員 { get; set; }
        public int[] パート { get; set; }
        public int[] 協力 { get; set; }
        public int[] 契約 { get; set; }
        public int[] 派遣 { get; set; }
        public int[] 休職 { get; set; }
        public 要員数()
        {
            this.社員 = new int[12];
            this.パート = new int[12];
            this.協力 = new int[12];
            this.契約 = new int[12];
            this.派遣 = new int[12];
            this.休職 = new int[12];
        }
    }
    public class 売上予測
    {
        public int[] 確度70 { get; set; }
        public int[] 確度50 { get; set; }
        public int[] 確度30 { get; set; }
        public int[] 確度10 { get; set; }
        public 売上予測()
        {
            this.確度70 = new int[12];
            this.確度50 = new int[12];
            this.確度30 = new int[12];
            this.確度10 = new int[12];
        }
    }
    public class accountInfo
    {
        public 予算 予算 { get; set; }
        public 売上高 売上高 { get; set; }
        public 売上原価 売上原価 { get; set; }
        public 販管費 販管費 { get; set; }
        public 固定資産 固定資産 { get; set; }
        public 営業外収益 営業外収益 { get; set; }
        public 営業外費用 営業外費用 { get; set; }
        public 部門固定費 部門固定費 { get; set; }
        public 本社費配賦 本社費配賦 { get; set; }
        public 売上付替 売上付替 { get; set; }
        public 費用付替 費用付替 { get; set; }
        public 要員数 要員数 { get; set; }
        public 売上予測 売上予測 { get; set; }
        public accountInfo()
        {
            this.予算 = new 予算();
            this.売上高 = new 売上高();
            this.売上原価 = new 売上原価();
            this.販管費 = new 販管費();
            this.固定資産 = new 固定資産();
            this.営業外収益 = new 営業外収益();
            this.営業外費用 = new 営業外費用();
            this.部門固定費 = new 部門固定費();
            this.本社費配賦 = new 本社費配賦();
            this.売上付替 = new 売上付替();
            this.費用付替 = new 費用付替();
            this.要員数 = new 要員数();
            this.売上予測 = new 売上予測();
        }
    }
}
