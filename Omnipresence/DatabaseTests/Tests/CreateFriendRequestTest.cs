using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateFriendRequestTest : Test
    {
        public CreateFriendRequestTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int totalUsers = accountServices.GetAllUserProfiles().Count();
            CreateFriendRequestModel cfrm = new CreateFriendRequestModel();
            cfrm.AdderUserProfileId = random.Next(1, totalUsers);
            cfrm.AddedUserProfileId = random.Next(1, totalUsers);

            Console.WriteLine(cfrm.AdderUserProfileId + " added " + cfrm.AddedUserProfileId + " as a friend.");

            return accountServices.CreateFriendRequest(cfrm);
        }
    }
}
