﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateEventTest : Test
    {
        public CreateEventTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            CreateEventModel c = new CreateEventModel();
            c.Title = "Test Event";
            c.Description = "This is a test event";
            c.StartTime = DateTime.Now;
            c.EndTime = DateTime.Now;
            c.CategoryString = "Party";
            c.IsPrivate = false;
            c.Latitude = 10.0;
            c.Longitude = 120.0;
            c.LocationName = "Ateneo";
            c.Address = "Katipunan Avenue";
            c.UserProfileId = random.Next(1, accountServices.GetAllUserProfiles().Count());

            return eventServices.CreateEvent(c);
        }
    }
}