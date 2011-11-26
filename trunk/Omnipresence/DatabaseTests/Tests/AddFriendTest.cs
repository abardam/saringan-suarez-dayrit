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
            MakeFriendsModel m = new MakeFriendsModel();
            m.AddedUserProfileId = random.Next(1,totalUsers);
            m.AdderUserProfileId = random.Next(1, totalUsers);
            Console.WriteLine("Making users " + m.AdderUserProfileId + " and " + m.AddedUserProfileId + " friends.");
            
            return accountServices.MakeFriends(m);
        }
    }
}
