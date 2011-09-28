using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;
using OmniWebService;

namespace ProcessingTests
{
    class Program
    {
        static void Main(string[] args)
        {
            TestSuite tests = new TestSuite();
            tests.Begin();
            Console.WriteLine("Tests Succeeded");

            Console.ReadKey();
        }
    }

    public class TestSuite
    {
        private OmniService.OmniServiceClient service;

        public TestSuite()
        {
            service = new OmniService.OmniServiceClient();
        }

        public void Begin()
        {
            AddEventTest();
        }

        private bool AddEventTest()
        {
            string title = "Code Camp";
            string description = "A test event made by Emanuel Saringan";
            string categoryString = "Disaster";

            DateTime created = DateTime.Now;
            DateTime lastModified = DateTime.Now;
            DateTime startTime = DateTime.Now;
            DateTime endTime = DateTime.Now;

            string locationName = "A Test Title";
            double latitude = 20.12;
            double longitude = 21.19;

            int rating = 0;
            string visibilityTypeString = "private";

            return service.AddEvent(title, description, categoryString, created, lastModified, startTime, endTime, locationName, latitude, longitude,rating, visibilityTypeString);
        }

        private IQueryable<Event> GetEventsTest()
        {
            return (IQueryable<Event>)service.GetEvents();
        }
    }
}
