﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class AddCommentTest : Test
    {
        public AddCommentTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int numEvents = eventServices.GetAllEvents().Count();
            int numUserProfiles = accountServices.GetAllUserProfiles().Count();

            int eventId = random.Next(1, numEvents);
            int userProfileId = random.Next(1, numUserProfiles);

            AddCommentModel addCommentModel = new AddCommentModel();
            addCommentModel.EventId = eventId;
            addCommentModel.UserProfileId = userProfileId;
            addCommentModel.Comment = "OHOHOHO " + Name + " " + DateTime.Now.ToString();

            return eventServices.AddComment(addCommentModel);
        }
    }
}