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
            public string yymm { get; set; } = ((DateTime.Now.Year * 100) + DateTime.Now.Month).ToString();

            [JsonProperty("mCnt")]
            public string mCnt { get; set; } = 12.ToString();

            [JsonProperty("year")]
            public string year { get; set; } = (DateTime.Now.Year).ToString();

            [JsonProperty("fix")]
            public string fix { get; set; } = 70.ToString();

            [JsonProperty("actual")]
            public string actual { get; set; } = 3.ToString();

            [JsonProperty("dispCnt")]
            public string dispCnt { get; set; } = 12.ToString();

            [JsonProperty("dispMode")]
            public string dispMode { get; set; } = "";
        }

        public class SampleData
        {
            public string Description { get; set; }
            public DateTimeOffset UpdateDate { get; set; }
            public System.Collections.Generic.Dictionary<string, object> Data { get; set; }
        }
    }
}
