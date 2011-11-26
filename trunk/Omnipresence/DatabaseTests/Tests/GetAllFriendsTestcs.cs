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
            GetAllFriendsModel getAllFriendsModel = new GetAllFriendsModel();
            int randomId = random.Next(1, accountServices.GetAllUserProfiles().Count());
            UserProfileModel userProfileModel = accountServices.GetUserProfileById(randomId);

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
