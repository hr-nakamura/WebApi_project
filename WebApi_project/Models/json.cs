using System;
using System.Web;
using Newtonsoft.Json;
using System.ComponentModel;

namespace WebApi_project.Models
{
    public class JsonOption
    {
        [JsonObject("projectPara")]
        public class projectPara
        {
            [JsonProperty("yymm")]
            public int yymm { get; set; } = (DateTime.Now.Year * 100) + DateTime.Now.Month;

            [JsonProperty("mCnt")]
            public int mCnt { get; set; } = 12;

            [JsonProperty("year")]
            public int year { get; set; } = DateTime.Now.Year;

            [JsonProperty("fix")]
            public int fix { get; set; } = 70;

            [JsonProperty("actual")]
            public int actual { get; set; } = 3;

            [JsonProperty("dispMode")]
            public string dispMode { get; set; } = "";
        }
    }
}
