using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class EventServices : IDisposable
    {
        private OmnipresenceEntities db;

        public EventServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public bool AddEvent(Event e)
        {
            db.AddToEvents(e);
            db.SaveChanges();

            return true;
        }

        // TODO: Delete this duplicate method
        public Event CreateEvent(string title, string description, DateTime startTime, DateTime endTime, int rating, string categoryString, string visibilityTypeString, double latitude, double longitude, string locationName)
        {
            Category category = GetCategory(categoryString);
            VisibilityType visibilityType = GetVisibilityType(visibilityTypeString);

            Location location = CreateLocation(latitude, longitude, locationName, "");

            return CreateEvent(title, description, startTime, endTime, rating, category, visibilityType, location);
        }

        public Event CreateEvent(NewEventModel temp)
        {
            Category category = GetCategory(temp.CategoryString);
            VisibilityType visibilityType = GetVisibilityType(temp.VisibilityTypeString);

            Location location = CreateLocation(temp.Latitude, temp.Longitude, temp.LocationName, "");

            return CreateEvent(temp.Title, temp.Description, temp.StartTime, temp.EndTime, 0, category, visibilityType, location);
        }
        // TODO: MODIFY TO USE ANOTHER MODEL INSTEAD OF MANY PARAMETERS
        private Event CreateEvent(string title, string description, DateTime startTime, DateTime endTime, int rating, Category category, VisibilityType visibilityType, Location location)
        {
            Event newEvent = new Event();
            newEvent.Title = title;
            newEvent.Description = description;
            newEvent.StartTime = startTime;
            newEvent.EndTime = endTime;
            newEvent.Rating = rating;

            newEvent.Category = category;
            newEvent.VisibilityType = visibilityType;
            newEvent.IsActive = true;
            newEvent.Location = location;

            newEvent.LastModified = DateTime.Now;
            newEvent.Created = System.DateTime.Now;

            return newEvent;
        }

        private Location CreateLocation(double latitude, double longitude, string name, string countryString)
        {
            Country country = GetCountry(countryString);
            return CreateLocation(latitude, longitude, name, country);
        }
        
        private Location CreateLocation(double latitude, double longitude, string name, Country country)
        {
            Location location = new Location();
            location.Latitude = latitude;
            location.Longitude = longitude;
            location.Name = name;
            location.Country = country;

            return location;
        }

        public IQueryable<Event> GetEvents()
        {
            return db.Events.AsQueryable();
        }

        public Event GetEventById(int id)
        {
            return db.Events.Where(x => x.EventId == id).SingleOrDefault();
        }

        public void DeleteEvent(Event e)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                db.Events.DeleteObject(e);
                db.SaveChanges();
            }
        }

        public IEnumerable<Event> QueryEvents(string title, string description, DateTime startTime, DateTime endTime, string visibilityTypeString, string locationName, double? latitude, double? longitude)
        {
            #region OLD QUERY CODE
            //IEnumerable<EventViewModelMicro> r;
            //    r = from p in db.Events
            //        select new EventViewModelMicro()
            //        {
            //            EventId = p.EventId,
            //            Name = p.Title,
            //            End = p.EndTime.Value,
            //            Start = p.StartTime.Value,
            //            Latitude = p.Location.Latitude,
            //            Longitude = p.Location.Longitude,
            //            Type = p.Category.Name
            //        };
            //    if (model.Type != "")
            //    {
            //        r = r.Where(x => x.Type == model.Type);
            //    }
            //    if (model.Tags.Count() > 0)
            //    {
            //        // TODO: Actual string search schtuff
            //    }
            //    if (model.SearchString != "")
            //    {
            //        // TODO: Actual string search schtuff
            //    }// TODO: CITY USER FRIENDS SUBSCRIPTIONS ETC WALA NAHHHHFUFHBUIRGUORGVIO
            //return r;
            #endregion

            EventQueryModel queryModel = new EventQueryModel();
            queryModel.Title = title;
            queryModel.Description = description;
            queryModel.StartTime = startTime;
            queryModel.EndTime = endTime;
            queryModel.Location = CreateLocation(latitude.Value, longitude.Value, locationName, "");
            queryModel.VisibilityType = GetVisibilityType(visibilityTypeString);

            return QueryEvents(queryModel);
        }

        public IEnumerable<Event> QueryEvents(EventQueryModel queryModel)
        {
            IEnumerable<Event> titleMatches;
            titleMatches = db.Events.Where(x => queryModel.Title != null ? x.Title.Equals(queryModel.Title, StringComparison.CurrentCultureIgnoreCase) : true);

            IEnumerable<Event> descriptionMatches;
            descriptionMatches = db.Events.Where(x => queryModel.Description != null ? x.Description.Contains(queryModel.Description) : true);

            IEnumerable<Event> startTimeMatches;
            startTimeMatches = db.Events.Where(x => queryModel.StartTime != null ? x.StartTime >= queryModel.StartTime : true);

            IEnumerable<Event> endTimeMatches;
            endTimeMatches = db.Events.Where(x => queryModel.EndTime != null ? x.EndTime <= queryModel.EndTime : true);

            IEnumerable<Event> locationMatches;
            locationMatches = db.Events.Where(x => x.Location != null ? AreWithinRadius(x.Location, queryModel.Location, 0.1) : true);

            IEnumerable<Event> visibilityTypeMatches;
            visibilityTypeMatches = db.Events.Where(x => queryModel.VisibilityType == x.VisibilityType);

            IEnumerable<Event> result = titleMatches.Intersect(descriptionMatches.Intersect(startTimeMatches.Intersect(endTimeMatches)).Intersect(locationMatches.Intersect(visibilityTypeMatches)));

            return result;
        }

        private bool AreWithinRadius(Location a, Location b, double radius)
        {
            double x1 = a.Latitude;
            double y1 = a.Longitude;

            double x2 = b.Latitude;
            double y2 = b.Longitude;

            return Math.Sqrt((y1 - x1) * (y1 - x1) + (y2 - x2) * (y2 - x2)) <= radius;
        }

        private VisibilityType GetVisibilityType(string visibilityTypeString)
        {
            VisibilityType visibilityType = db.VisibilityTypes.Where(x => x.Type.Equals(visibilityTypeString, StringComparison.CurrentCultureIgnoreCase)).FirstOrDefault();
            return visibilityType;
        }

        private Category GetCategory(string categoryString)
        {
            Category category = db.Categories.Where(x => x.Name.Equals(categoryString, StringComparison.CurrentCultureIgnoreCase)).FirstOrDefault();
            return category;
        }

        private Country GetCountry(string countryString)
        {
            Country country = db.Countries.Where(x => x.Name.Equals(countryString, StringComparison.CurrentCultureIgnoreCase)).SingleOrDefault();
            return country;
        }

        public bool AddComment(int eventId, string commentString)
        {
            Event e = GetEventById(eventId);
            Comment comment = new Comment();
            comment.Timestamp = DateTime.Now;
            comment.CommentText = commentString;

            return AddComment(e, comment);
        }

        private bool AddComment(Event e, Comment comment)
        {
            e.Comments.Add(comment);
            db.AddToComments(comment);

            db.SaveChanges();

            return true;
        }

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
