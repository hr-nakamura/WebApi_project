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
        }
    }
}
