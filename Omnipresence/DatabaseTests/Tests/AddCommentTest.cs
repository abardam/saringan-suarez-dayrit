using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class AddCommentTest : Test
    {
        private EventServices eventServices;

        public AddCommentTest(string name)
        {
            Name = name;
            eventServices = new EventServices();
        }

        public override bool Execute()
        {
            return eventServices.AddComment(new AddCommentModel { Comment = "OHOHOHOHOHO " + Name + " " + DateTime.Now.ToString(), EventId = 1, UserProfileId = 1 });
        }
    }
}
