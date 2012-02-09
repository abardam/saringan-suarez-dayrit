using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class CreateCategoriesTest : Test
    {
        public CreateCategoriesTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            CreateCategoryModel ccm = new CreateCategoryModel();
            ccm.Name = "Party";
            ccm.Description = "This is A Party Event Description";
            ccm.IconPath = "/Content/Images/party.png";
            categoryServices.CreateCategory(ccm);

            ccm.Name = "Disaster";
            ccm.Description = "This is A Disaster Event Description";
            ccm.IconPath = "/Content/Images/disaster.png";
            categoryServices.CreateCategory(ccm);

            ccm.Name = "Traffic";
            ccm.Description = "This is A Traffic Event Description";
            ccm.IconPath = "/Content/Images/traffic.png";
            categoryServices.CreateCategory(ccm);

            return true;
        }
    }
}
