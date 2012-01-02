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
            int index = (accountServices.GetAllUsers().Count()+1);
            CreateUserModel createUserModel = new CreateUserModel();
            createUserModel.Username = "user" + index;
            createUserModel.Password = "password";
            createUserModel.Email = "saringan.emanuel@gmail.com";

            CreateUserProfileModel createUserProfileModel = new CreateUserProfileModel();
            createUserProfileModel.FirstName = "FName-" + index;
            createUserProfileModel.LastName = "LName-" + index;
            createUserProfileModel.Description = "Desc-" + index;
            createUserProfileModel.Birthdate = DateTime.Now;
            createUserProfileModel.IsFemale = false;

            return accountServices.CreateUser(createUserModel, createUserProfileModel);
        }
    }
}
