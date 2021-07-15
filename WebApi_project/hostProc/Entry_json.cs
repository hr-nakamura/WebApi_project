using System;
using System.Xml;
using System.Reflection;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class hostProcEntry_json
    {
        public hostProcEntry_json()
        {
            //Debug.WriteLog("hostProcEntry Start");
        }
        ~hostProcEntry_json()
        {
            //Debug.WriteLog("hostProcEntry End");
        }
        public object Entry(String Item, String Func, String Json)
        {
            try
            {
                Func += "_json";
                object o_obj = new object();
                String nameSpace = "WebApi_project.hostProc";

                Type classType = Type.GetType(nameSpace + "." + Item);
                if (classType == null) throw new Exception("calss名[" + Item + "]が不明です");
                var obj = Activator.CreateInstance(classType);
                MethodInfo method = classType.GetMethod(Func);
                if (method == null) throw new Exception("method名[" + Func + "]が不明です");
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
