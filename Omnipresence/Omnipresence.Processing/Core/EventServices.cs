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
        #region [FIELDS]
        private OmnipresenceEntities db;
        #endregion

        #region [CONSTRUCTOR]
        public EventServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        #endregion

        #region [CRUD]

        public EventModel CreateEvent(CreateEventModel createEventModel)
        {
            EventModel eventModel = new EventModel();
            eventModel.Title = createEventModel.Title;
            eventModel.Description = createEventModel.Description;
            eventModel.StartTime = createEventModel.StartTime;
            eventModel.EndTime = createEventModel.EndTime;
            eventModel.Category = GetCategory(createEventModel.CategoryString);
            eventModel.VisibilityType = GetVisibilityType(createEventModel.VisibilityTypeString);
            eventModel.Location = CreateLocation(createEventModel.Latitude, createEventModel.Longitude, createEventModel.LocationName);

            eventModel.IsActive = true;
            eventModel.LastModified = DateTime.Now;
            eventModel.Created = System.DateTime.Now;
            eventModel.Rating = 0;

            return eventModel;
        }

        public bool AddEvent(EventModel eventModel)
        {
            Event newEvent = new Event();
            newEvent.Title = eventModel.Title;
            newEvent.Description = eventModel.Description;
            newEvent.StartTime = eventModel.StartTime;
            newEvent.EndTime = eventModel.EndTime;
            newEvent.Category = eventModel.Category;
            newEvent.VisibilityType = eventModel.VisibilityType;
            newEvent.Location = eventModel.Location;
            newEvent.IsActive = eventModel.IsActive;
            newEvent.LastModified = eventModel.LastModified;
            newEvent.Created = eventModel.Created;
            newEvent.Rating = eventModel.Rating;

            db.AddToEvents(newEvent);
            db.SaveChanges();

            return true;
        }

        public bool DeleteEvent(DeleteEventModel deleteEventModel)
        {
            Event evt = db.Events.Where(ev => ev.EventId == deleteEventModel.EventId).FirstOrDefault();

            if (evt != null)
            {
                db.Events.DeleteObject(evt);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool AddComment(AddCommentModel addCommentModel)
        {
            Comment comment = new Comment();
            comment.CommentText = addCommentModel.Comment;
            comment.Timestamp = DateTime.Now;

            Event evt = db.Events.Where(ev => ev.EventId == addCommentModel.EventId).SingleOrDefault();
            UserProfile userProfile = db.UserProfiles.Where(up => up.UserProfileId == addCommentModel.UserProfileId).FirstOrDefault();

            comment.Event = evt;
            comment.UserProfile = userProfile;

            db.AddToComments(comment);
            db.SaveChanges();

            return true;
        }

        public bool Vote(VoteEventModel voteEventModel)
        {
            Event curEvent = db.Events.Where(ev => (ev.EventId == voteEventModel.EventId)).FirstOrDefault();

            if (curEvent != null)
            {
                if (voteEventModel.IsDownvote)
                {
                    curEvent.Rating--;
                }
                else
                {
                    curEvent.Rating++;
                }

                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region [UTILITY METHODS]
        private Location CreateLocation(double latitude, double longitude, string name)
        {
            Location location = new Location();
            location.Latitude = latitude;
            location.Longitude = longitude;
            location.Name = name;

            return location;
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

        #endregion

        #region [SEARCH]
        public IQueryable<EventModel> GetAllEvents()
        {
            List<EventModel> eventModels = new List<EventModel>();
            ObjectSet<Event> events = db.Events;

            foreach (Event evt in events)
            {
                eventModels.Add(Utilities.EventToEventModel(evt));
            }

            return eventModels.AsQueryable();
        }

        public IEnumerable<EventModel> QueryEvents(QueryEventModel queryModel)
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

            IEnumerable<Event> result = titleMatches.Intersect(descriptionMatches.Intersect(startTimeMatches.Intersect(endTimeMatches)).Intersect(locationMatches));

            List<EventModel> eventModels = new List<EventModel>();
            EventModel evtModel = null;

            foreach (Event evt in result)
            {
                evtModel = Utilities.EventToEventModel(evt);
                eventModels.Add(evtModel);
            }

            return eventModels.AsQueryable();
        }

        private bool AreWithinRadius(Location a, Location b, double radius)
        {
            double x1 = a.Latitude;
            double y1 = a.Longitude;

            double x2 = b.Latitude;
            double y2 = b.Longitude;

            return Math.Sqrt((y1 - x1) * (y1 - x1) + (y2 - x2) * (y2 - x2)) <= radius;
        }

        #endregion

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
