using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class GetFriendRequestsTest : Test
    {
        public GetFriendRequestsTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int totalUsers = accountServices.GetAllUserProfiles().Count();
            GetFriendRequestsModel gfrm = new GetFriendRequestsModel();
            gfrm.UserProfileId = random.Next(1, totalUsers);

            Console.WriteLine("All pending friend requests of " + gfrm.UserProfileId);

            foreach (UserProfileModel upm in accountServices.GetFriendRequests(gfrm))
            {
                Console.WriteLine("\t" + upm.UserProfileId);
            }

            return true;
        }
    }
}
