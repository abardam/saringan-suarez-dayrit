using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests.Tests
{
    public class AddFriendTest : Test
    {
        private AccountServices accountServices;

        public AddFriendTest(string name)
        {
            Name = name;
            accountServices = new AccountServices();
        }

        public override bool Execute()
        {
            throw new NotImplementedException();
        }
    }
}
