﻿using System;
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

        public override bool Execute()
        {
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