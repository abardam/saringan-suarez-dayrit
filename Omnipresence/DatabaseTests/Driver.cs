using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace DatabaseTests
{
    class Driver
    {
        static void Main(string[] args)
        {
            List<Test> testSuite = new List<Test>();
            testSuite.Add(new CreateUserTest("Account Creation Test"));
            testSuite.Add(new CreateEventTest("Event Creation Test"));
            testSuite.Add(new VoteEventTest("Event Voting Test"));

            int numSuccess = 0;
            Stopwatch stopwatch;

            foreach (Test test in testSuite)
            {
                Console.WriteLine(test.Name + " started");
                stopwatch = new Stopwatch();
                stopwatch.Start();
                bool success = test.Execute();
                stopwatch.Stop();

                Console.WriteLine("{0} {1} in {2} ms", test.Name, success ? "succeeded" : "failed", stopwatch.ElapsedMilliseconds);
                Console.WriteLine("++++++++++++++++++++++++");

                if (success)
                {
                    numSuccess++;
                }
            }

            Console.WriteLine("Tests Have Been Executed!");
            Console.WriteLine("Total Tests: " + testSuite.Count);
            Console.WriteLine("Total Passed: " + numSuccess);
            Console.WriteLine("Total Failed: " + (testSuite.Count - numSuccess));

            Console.ReadKey();
        }
    }
}
