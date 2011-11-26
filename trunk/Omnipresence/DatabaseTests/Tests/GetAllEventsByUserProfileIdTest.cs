using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class GetAllEventsByUserProfileIdTest : Test
    {
        public GetAllEventsByUserProfileIdTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int userProfileId = random.Next(1, accountServices.GetAllUserProfiles().Count());

            IQueryable<EventModel> events = eventServices.GetAllEventsByUserProfileId(userProfileId);

            Console.WriteLine("Events created by {0}", userProfileId);

            foreach (EventModel evt in events)
            {
                Console.WriteLine("\tTitle: {0}\n\tDescription: {1}\n\tRating {2}", evt.Title, evt.Description, evt.Rating);
            }

            return true;
        }
    }
}
