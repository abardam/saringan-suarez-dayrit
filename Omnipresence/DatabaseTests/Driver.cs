using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DatabaseTests
{
    class Driver
    {
        static void Main(string[] args)
        {
            AccountTestSuite accountTestSuite = AccountTestSuite.GetInstance();
            EventTestSuite eventTestSuite = EventTestSuite.GetInstance();

            accountTestSuite.BeginTests();
            eventTestSuite.BeginTests();

            Console.ReadKey();
        }
    }
}
