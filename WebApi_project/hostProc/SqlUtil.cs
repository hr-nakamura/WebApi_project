using System;
using System.Web;

namespace WebApi_project.hostProc
{
    public class SqlUtil 
    {
        public static string Parameter(object value)
        {
            string result = "";
            if (value.GetType().Name == "String")
            {
                result = string.Concat("'", value, "'");
            }
            else
            {
                result = null;
            }
            return (result);
        }


    }
}
