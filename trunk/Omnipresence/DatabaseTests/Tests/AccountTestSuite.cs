using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class AccountTestSuite : TestSuite
    {
        private AccountServices accountServices;
        private static AccountTestSuite instance;

        private AccountTestSuite()
        {
            accountServices = new AccountServices();
        }

        public static AccountTestSuite GetInstance()
        {
            if (instance == null)
            {
                instance = new AccountTestSuite();
            }

            return instance;
        }

        public override void BeginTests()
        {
        }
    }
}
