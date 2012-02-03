using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class VoteEventTest : Test
    {
        public VoteEventTest(string name)
        {
            Name = name;
        }

        private int JAAAAY;

        public override bool Execute()
        {
            int totalUsers = accountServices.GetAllUserProfiles().Count();
            JAAAAY = random.Next(1, totalUsers);
            bool upvote = TestUpvoteEvent();
            bool downvote = TestDownvoteEvent();

            return upvote && downvote;
        }

        public bool TestUpvoteEvent()
        {
            EventModel e = eventServices.GetAllEvents().FirstOrDefault();

            if (e != null)
            {
                VoteEventModel voteEventModel = new VoteEventModel();
                voteEventModel.EventId = e.EventId;
                //voteEventModel.UserProfileId = accountServices.GetAllUserProfiles().ToList()[]\
                voteEventModel.UserProfileId = JAAAAY;
                //CHeck for null later

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
                voteEventModel.UserProfileId = JAAAAY;

                return eventServices.Vote(voteEventModel);
            }
            else
            {
                return false;
            }
        }
    }
}
