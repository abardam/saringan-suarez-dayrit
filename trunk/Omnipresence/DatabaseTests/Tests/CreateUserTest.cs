using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateUserTest : Test
    {
        private AccountServices accountServices;
        
        public CreateUserTest(string name)
        {
            Name = name;
            accountServices = new AccountServices();
        }

        public override bool Execute()
        {
            CreateUserModel cum = new CreateUserModel();
            cum.Username = "iikwalsemsiskweyrd";
            cum.Password = "password";
            cum.Email = "saringan.emanuel@gmail.com";

            CreateUserProfileModel cupm = new CreateUserProfileModel();
            cupm.FirstName = "Emanuel";
            cupm.LastName = "Saringan";
            cupm.Description = "A handsome man";
            cupm.Birthdate = DateTime.Now;
            cupm.IsFemale = false;

            return accountServices.CreateUser(cum, cupm);
        }
    }
}
