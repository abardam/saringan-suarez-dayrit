using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateEventTest : Test
    {
        private CategoryModel[] categoryModels = CategoryServices.GetInstance().GetAllCategories().ToArray();

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
            c.CategoryString = categoryModels[random.Next(0, categoryModels.Length -1)].Name;
            c.IsPrivate = false;
            c.Latitude = 3.9 + (15.1*random.NextDouble()); // min : 18.812718 3.973861
            c.Longitude = 117 + (14*random.NextDouble()); // min: 117.13623 ,130.12207
            c.LocationName = "Ateneo";
            c.Address = "Katipunan Avenue";
            c.UserProfileId = random.Next(1, accountServices.GetAllUserProfiles().Count());

            return eventServices.CreateEvent(c);
        }
    }
}
