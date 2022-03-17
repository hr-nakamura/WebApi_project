using System;
using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebApi_project.hostProc
{
    public partial class hostProc : projectInfo
    {
        public void ArrayConvert(ref JObject oJ, string tagName, string atrName)
        {
            foreach (var x in (JObject)oJ)
            {
                var Key = x.Key;
                var Value = x.Value;
                if (Value.Type.ToString() == "Object")
                {
                    var target_Value = (JObject)oJ[Key];
                    ArrayConvert(ref target_Value, tagName, atrName);
                }
                else if (Value.Type.ToString() == "Array")
                {
                    oJ[Key] = (JObject)JsonArrayConvert(Value, tagName, atrName);
                }
                else
                {
                }
            }
        }
        private JObject JsonArrayConvert(object oJ, string tagName, string atrName)
        {
            List<string> work = new List<string>();
            int i = 0;
            foreach (var value in (JArray)oJ)
            {
                work.Add(" {'@" + atrName + "':" + i++.ToString() + ",'#text':'" + value.ToString() + "'}");
            }

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("{");
            sb.AppendLine(" '" + tagName + "': [");
            sb.AppendLine(String.Join(",", work));
            sb.AppendLine(" ]");
            sb.AppendLine("}");

            JObject Json = (JObject)JsonConvert.DeserializeObject(sb.ToString());
            return (Json);

        }

    }
}
