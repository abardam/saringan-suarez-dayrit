using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class GetMessagesTest : Test
    {
        static int index = 1;
        public override bool Execute()
        {
            int total = accountServices.GetAllUserProfiles().Count();
            if (index > total) index = 1;
            GetMessagesModel queryModel = new GetMessagesModel
            {
                GetUnreadOnly = false,
                NumberOfResults = 10,
                PageNumber = 1,
                UserProfileID = index++
            };

            var b = eventServices.GetMessages(queryModel);
            Console.WriteLine("\tTotal Messages for " + queryModel.UserProfileID + ": " + b.Count());
            return true;
        }
    }
}
