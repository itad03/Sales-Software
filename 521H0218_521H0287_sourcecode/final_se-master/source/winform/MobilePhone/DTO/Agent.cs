using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class Agent
    {
        public string id { get; set; }
        public string name { get; set; }
        public string address { get;set; }
        public string contact { get; set; }
        public string password { get; set; }
        public Agent(string id, string name, string add , string contact, string password)
        {
            this.name = name;
            this.id = id;
            this.name = name;
            this.address = add;
            this.contact = contact;
            this.password = password;
        }
    }
}
