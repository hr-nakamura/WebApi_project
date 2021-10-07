using System;
using System.Collections.Generic;
using System.Reflection;

using DebugHost;

namespace WebApi_project.hostProc
{
    partial class hostProcEntry
    {
        public object Entry_json(String Item, String Json)
        {
            object o_obj = new object();
            try
            {
                string[] ItemWork = Item.Split('/');
                string className = ItemWork[0];
                string methodName = ItemWork[1];

                String nameSpace = "WebApi_project.hostProc";

                Type classType = Type.GetType(string.Concat(nameSpace, "." , className) );
                if (classType == null) throw new Exception("calss名[" + className + "]が不明です");
                var obj = Activator.CreateInstance(classType);
                MethodInfo method = classType.GetMethod(methodName);
                if (method == null) throw new Exception("method名[" + methodName + "]が不明です");
                o_obj = (object)method.Invoke(obj, new object[] { Json });

                return (o_obj);
            }
            catch (Exception ex)
            {
                Dictionary<string, object> Tab = new Dictionary<string, object>();
                Tab.Add("error_json", ex.Message);
                return (Tab);
            }
            finally
            {
                //Debug.WriteErr("finally");
            }
        }
    }
}
