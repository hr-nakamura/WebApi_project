using System;
using System.Web;

namespace WebApi_project.hostProc
{
    public class SqlUtil 
    {
        public static string Parameter(object value)
        {
            string result = "";
            string typeName = value.GetType().Name;
            if (typeName == "String")
            {
                result = string.Concat("'", value, "'");
            }
            else if (typeName == "Int32")
            {
                result = value.ToString();
            }
            else if (typeName == "DateTime")
            {
                result = string.Concat("'", value.ToString(), "'");
            }
            else
            {
                result = value.ToString();
            }
            return (result);
        }


    }
}
