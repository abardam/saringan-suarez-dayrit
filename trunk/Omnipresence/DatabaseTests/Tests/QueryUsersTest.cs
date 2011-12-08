using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class QueryUsersTest : Test
    {
        public QueryUsersTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            QueryUserModel qum = new QueryUserModel();
            qum.Username = random.Next(1, 100)+"";
            qum.FirstName = random.Next(1, 100) + "";
            qum.LastName = random.Next(1, 100) + "";
            qum.Email = random.Next(1, 100) + "";

            IEnumerable<UserProfileModel> results = accountServices.QueryUsers(qum);
            Console.WriteLine("Results of user search:");

            foreach (UserProfileModel userProfile in results)
            {
                Console.WriteLine("\t{0} {1}\n", userProfile.FirstName, userProfile.LastName);
            }

            return true;
        }
    }
}
