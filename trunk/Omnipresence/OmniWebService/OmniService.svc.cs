using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using Omnipresence.DataAccess.Core;
using Omnipresence.Processing;

namespace OmniWebService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    public class OmniService : IOmniService
    {
        private EventServices eventServices;
        private AccountServices accountServices;

        public OmniService()
        {
            eventServices = new EventServices();
            accountServices = new AccountServices();
        }

        public bool AddEvent(string title, 
            string description, 
            string categoryString, 
            DateTime created, 
            DateTime lastModified, 
            DateTime startTime, 
            DateTime endTime, 
            string locationName,
            double latitude, 
            double longitude,
            int rating,
            string visibilityTypeString)
        {
            Event e = eventServices.CreateEvent(title, description, startTime, endTime, rating, categoryString, visibilityTypeString, latitude, longitude, locationName);
            eventServices.AddEvent(e);
            
            return true;
        }

        public bool AddUser(string username, string password, string email, string firstName, string lastName, DateTime birthdate)
        {
            User user = accountServices.CreateUser(username, password, email, firstName, lastName, birthdate);
            accountServices.AddUser(user);

            return true;
        }
    }
}
