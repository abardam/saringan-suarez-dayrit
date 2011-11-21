using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class EventTestSuite : TestSuite
    {
        private EventServices eventServices;
        private static EventTestSuite instance;

        private EventTestSuite()
        {
            eventServices = new EventServices();
        }

        public static EventTestSuite GetInstance()
        {
            if (instance == null)
            {
                instance = new EventTestSuite();
            }

            return instance;
        }

        public override void BeginTests()
        {
            Console.WriteLine(TestCreateEvent());
            Console.WriteLine(TestAddEvent());
        }

        public bool TestCreateEvent()
        {
            CreateEventModel c = new CreateEventModel();
            c.Title = "Test Event";
            c.Description = "This is a test event";
            c.StartTime = DateTime.Now;
            c.EndTime = DateTime.Now;
            c.CategoryString = "Party";
            c.VisibilityTypeString = "public";
            c.Latitude = 10.0;
            c.Longitude = 120.0;
            c.LocationName = "Ateneo";

            EventModel m = eventServices.CreateEvent(c);

            if(m != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool TestAddEvent()
        {
            EventModel e = eventServices.GetAllEvents().FirstOrDefault();

            if (e != null)
            {
                return eventServices.AddEvent(e);
            }
            else
            {
                return false;
            }
        }

        public bool TestUpvoteEvent()
        {
            EventModel e = eventServices.GetAllEvents().FirstOrDefault();

            if (e != null)
            {
                VoteEventModel voteEventModel = new VoteEventModel();
                voteEventModel.EventId = e.EventId;

                return eventServices.Vote(voteEventModel);
            }
            else
            {
                return false;
            }
        }

        public bool TestDownvoteEvent()
        {
            EventModel e = eventServices.GetAllEvents().FirstOrDefault();

            if (e != null)
            {
                VoteEventModel voteEventModel = new VoteEventModel();
                voteEventModel.EventId = e.EventId;
                voteEventModel.IsDownvote = true;

                return eventServices.Vote(voteEventModel);
            }
            else
            {
                return false;
            }
        }
    }
}
