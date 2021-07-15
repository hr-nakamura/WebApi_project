using System;
using System.Xml;
using System.Reflection;

using DebugHost;

namespace WebApi_project.hostProc
{
    public class hostProcEntry
    {
        public  hostProcEntry()
        {
            //Debug.WriteLog("hostProcEntry Start");
        }
        ~hostProcEntry()
        {
        //Debug.WriteLog("hostProcEntry End");
        }
        public XmlDocument Entry(String Item, String Func, String Json)
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {

            String nameSpace = "WebApi_project.hostProc";

            Type classType = Type.GetType(nameSpace + "." + Item);
            if (classType == null) throw new Exception("calss名[" + Item +"]が不明です");
            var obj = Activator.CreateInstance(classType);
            MethodInfo method = classType.GetMethod(Func);
            if (method == null) throw new Exception("method名[" + Func + "]が不明です");
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
    }
}
