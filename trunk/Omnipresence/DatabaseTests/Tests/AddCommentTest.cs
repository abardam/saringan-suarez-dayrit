using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests.Tests
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
            throw new NotImplementedException();
        }
    }
}
