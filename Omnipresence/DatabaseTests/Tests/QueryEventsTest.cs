using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class QueryEventsTest : Test
    {
        public QueryEventsTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            QueryEventModel qem = new QueryEventModel();
            qem.Title = random.Next(1, 100)+"";
            qem.Description = random.Next(1, 100) + "";

            IEnumerable<EventModel> results = eventServices.QueryEvents(qem);
            Console.WriteLine("Results of event search:");

            foreach (EventModel evt in results)
            {
                Console.WriteLine("\t{0} {1}\n", evt.Title, evt.Description);
            }

            return true;
        }
    }
}
