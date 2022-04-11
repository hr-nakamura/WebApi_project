using System;
using System.Reflection;
using System.Xml;
using System.Collections.Generic;

using DebugHost;

namespace WebApi_project.entryProc
{
    partial class entryProc
    {
        public  entryProc()
        {
            //Debug.WriteLog("hostProcEntry Start");
        }
        ~entryProc()
        {
            //Debug.WriteLog("hostProcEntry End");
        }
        public XmlDocument testEntry(String Item, String Json)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {
                Item = Item.Trim('/');
                string[] ItemWork = Item.Split('/');
                string className = ItemWork[0];
                string methodName = ItemWork[1];

                String nameSpace = "WebApi_project.hostProc";

                Type classType = Type.GetType(string.Concat(nameSpace ,"." ,className) );
                if (classType == null) throw new Exception("calss名[" + className + "]が不明です");
                var obj = Activator.CreateInstance(classType);
                MethodInfo method = classType.GetMethod(methodName);
                if (method == null) throw new Exception("method名[" + methodName + "]が不明です");
                xmlDoc = (XmlDocument)method.Invoke(obj, new object[] { Json });

                return (xmlDoc);
            }
            catch (Exception ex)
            {
                xmlDoc.CreateXmlDeclaration("1.0", null, null);

                var xmlMain = xmlDoc.CreateProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'");
                XmlElement error = xmlDoc.CreateElement("error");
                var comment = xmlDoc.CreateComment(ex.Message);

                //xmlDoc.AppendChild(xmlMain);
                xmlDoc.AppendChild(error);
                error.AppendChild(comment);
                return (xmlDoc);
            }
            finally
            {
                //Debug.WriteErr("finally");
            }
        }
        public object testEntry_json(String Item, String Json)
        {
            object o_obj = new object();
            try
            {
                string[] ItemWork = Item.Split('/');
                string className = ItemWork[0];
                string methodName = ItemWork[1];

                String nameSpace = "WebApi_project.hostProc";

                Type classType = Type.GetType(string.Concat(nameSpace, ".", className));
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
