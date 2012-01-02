using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class GetAllFriendsTest : Test
    {
        public GetAllFriendsTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            GetFriendsModel getAllFriendsModel = new GetFriendsModel();
            int randomId = random.Next(1, accountServices.GetAllUserProfiles().Count());
            UserProfileModel userProfileModel = accountServices.GetUserProfileByUserProfileId(randomId);

            if (userProfileModel != null)
            {
                getAllFriendsModel.UserProfileId = userProfileModel.UserProfileId;

                Console.WriteLine("Retrieveing all of " + userProfileModel.UserProfileId + "\'s Friends");

                foreach (UserProfileModel up in accountServices.GetAllFriends(getAllFriendsModel))
                {
                    Console.WriteLine("\t{0}", up.UserProfileId);
                }

                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
