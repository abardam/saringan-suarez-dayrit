using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateApiUserTest : Test
    {
        public CreateApiUserTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            CreateApiUserModel caum = new CreateApiUserModel();
            caum.ApiKey = apiServices.GenerateApiKey();
            caum.Email = "iikwalsemsiskweyrd@yahoo.com.ph";
            caum.AppName = "App-" + random.Next(1000);

            return apiServices.CreateApiUser(caum);
        }
    }
}
