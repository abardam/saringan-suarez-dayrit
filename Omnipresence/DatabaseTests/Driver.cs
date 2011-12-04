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

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new CreateUserTest("Account Creation Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new CreateEventTest("Event Creation Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new VoteEventTest("Event Voting Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new CreateCommentTest("Comment Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new AddFriendTest("Add Friend Test"));
            }

            for (int i = 0; i < 20; i++)
            {
                testSuite.Add(new GetAllFriendsTest("Get All Friends Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new AddFriendTest("Add Friend Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new GetAllCommentsByEventId("Get Comments By Event Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new GetAllCommentsByUserProfileIdTest("Get Comments By User Profile Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new GetAllEventsByUserProfileIdTest("Get Events By User Profile Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new CreateApiUserTest("Create API User Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new CreateFriendRequestTest("Create Friend Request Test"));
            }

            for (int i = 0; i < 100; i++)
            {
                testSuite.Add(new GetFriendRequestsTest("Create Friend Request Test"));
            }

            int numSuccess = 0;
            long totalRuntime = 0;
            Stopwatch stopwatch = Stopwatch.StartNew();

            foreach (Test test in testSuite)
            {
                Console.WriteLine(test.Name + " started");

                stopwatch.Restart();
                bool success = test.Execute();
                stopwatch.Stop();

                Console.WriteLine("{0} {1} in {2} ms", test.Name, success ? "succeeded" : "failed", stopwatch.ElapsedMilliseconds);
                Console.WriteLine("++++++++++++++++++++++++");

                totalRuntime += stopwatch.ElapsedMilliseconds;

                if (success)
                {
                    numSuccess++;
                }
            }

            Console.WriteLine("Tests Have Been Executed!");
            Console.WriteLine("Total Tests: " + testSuite.Count);
            Console.WriteLine("Total Passed: " + numSuccess);
            Console.WriteLine("Total Failed: " + (testSuite.Count - numSuccess));
            Console.WriteLine("Total Runtime: " + totalRuntime);

            //Console.ReadKey();
        }
    }
}
