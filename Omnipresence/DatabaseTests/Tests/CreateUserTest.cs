using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateUserTest : Test
    {
        public CreateUserTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            CreateUserModel createUserModel = new CreateUserModel();
            createUserModel.Username = ""+DateTime.Now.ToString();
            createUserModel.Password = "password";
            createUserModel.Email = "saringan.emanuel@gmail.com";

            CreateUserProfileModel createUserProfileModel = new CreateUserProfileModel();
            createUserProfileModel.FirstName = "FName-" + DateTime.Now.ToString();
            createUserProfileModel.LastName = "LName-" + DateTime.Now.ToString();
            createUserProfileModel.Description = "Desc-" + DateTime.Now.ToString();
            createUserProfileModel.Birthdate = DateTime.Now;
            createUserProfileModel.IsFemale = false;

            return accountServices.CreateUser(createUserModel, createUserProfileModel);
        }
    }
}
