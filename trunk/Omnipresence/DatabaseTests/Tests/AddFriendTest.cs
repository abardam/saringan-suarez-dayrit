using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class AddFriendTest : Test
    {
        public AddFriendTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int totalUsers = accountServices.GetAllUserProfiles().Count();
            UserProfileModel accepter = accountServices.GetUserProfileById(random.Next(1, totalUsers));

            GetFriendRequestsModel gfrm = new GetFriendRequestsModel();
            gfrm.UserProfileId = accepter.UserProfileId;

            IQueryable<UserProfileModel> friendRequests = accountServices.GetFriendRequests(gfrm);
            UserProfileModel requester = friendRequests.FirstOrDefault();

            if (requester != null)
            {
                FriendRequestModel m = new FriendRequestModel();
                m.AddedUserProfileId = accepter.UserProfileId;
                m.AdderUserProfileId = requester.UserProfileId;

                Console.WriteLine("Making users " + m.AdderUserProfileId + " and " + m.AddedUserProfileId + " friends.");

                return accountServices.ConfirmFriendRequest(m);
            }
            else
            {
                return false;
            }
        }
    }
}
