using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApi_project.Controllers
{
    public class TestController : ApiController
    {
        // GET api/<controller>
        public Dictionary<string, string> Get()
        {
            var hProc = new hostProc.hostProc();

            string mName = Environment.MachineName;

            Dictionary<string, string> Tab = new Dictionary<string, string>();
            //Tab[nameof(mName)] = mName;
            Tab.Add("mName", mName);
            Tab.Add("DB_Conn", hProc.DB_connectString);
            Tab.Add("DB_status", (hProc.DB_status ? "OK" : "NG"));
            Tab.Add("DB_result", hProc.DB_result);

            return (Tab);
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}