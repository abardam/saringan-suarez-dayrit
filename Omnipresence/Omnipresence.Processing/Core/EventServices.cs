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
        private static EventServices instance;

        #endregion

        #region [CONSTRUCTOR]

        private EventServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public static EventServices GetInstance()
        {
            if (instance == null)
            {
                instance = new EventServices();
            }

            return instance;
        }

        #endregion

        #region [CRUD]

        public bool CreateEvent(CreateEventModel createEventModel)
        {
            Event newEvent = new Event();
            newEvent.Title = createEventModel.Title;
            newEvent.Description = createEventModel.Description;
            newEvent.StartTime = createEventModel.StartTime;
            newEvent.EndTime = createEventModel.EndTime;
            newEvent.IsPrivate = createEventModel.IsPrivate;

            newEvent.Category = GetCategory(createEventModel.CategoryString);
            newEvent.Location = CreateLocation(createEventModel.Latitude, createEventModel.Longitude, createEventModel.LocationName, createEventModel.Address);

            newEvent.IsActive = true;
            newEvent.LastModified = DateTime.Now;
            newEvent.Created = System.DateTime.Now;
            newEvent.Rating = 0;
            newEvent.CreatedBy = db.UserProfiles.Where(up => up.UserProfileId == createEventModel.UserProfileId).FirstOrDefault();

            if (newEvent.CreatedBy != null)
            {
                db.AddToEvents(newEvent);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdateEvent(UpdateEventModel uem)
        {
            Event evt = db.Events.Where(e => e.EventId == uem.EventId).FirstOrDefault();

            if (evt != null)
            {
                evt.Title = uem.Title;
                evt.Description = uem.Description;
                evt.StartTime = uem.StartTime;
                evt.Category = uem.Category;
                evt.IsPrivate = uem.IsPrivate;
                evt.Location = uem.Location;
                evt.IsActive = uem.IsActive;
                evt.Rating = uem.Rating;
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
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

        public bool CreateComment(CreateCommentModel createCommentModel)
        {
            Comment comment = new Comment();
            comment.CommentText = createCommentModel.Comment;
            comment.Timestamp = DateTime.Now;
            
            Event evt = db.Events.Where(ev => ev.EventId == createCommentModel.EventId).FirstOrDefault();
            UserProfile userProfile = db.UserProfiles.Where(up => up.UserProfileId == createCommentModel.UserProfileId).FirstOrDefault();

            comment.Event = evt;
            comment.UserProfile = userProfile;

            if (comment.Event != null && comment.UserProfile != null)
            {
                db.AddToComments(comment);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdateComment(CommentModel updateCommentModel)
        {
            Comment comment = db.Comments.Where(c => c.CommentId == updateCommentModel.CommentId).FirstOrDefault();

            if (comment != null)
            {
                comment.CommentText = updateCommentModel.CommentText;
                comment.Timestamp = DateTime.Now;
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool DeleteComment(DeleteCommentModel dcm)
        {
            Comment comment = db.Comments.Where(c => c.CommentId == dcm.CommentId).FirstOrDefault();

            if (comment != null)
            {
                db.DeleteObject(comment);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
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

                db.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region [UTILITY METHODS]

        private Location CreateLocation(double latitude, double longitude, string name, string address)
        {
            Location location = new Location();
            location.Latitude = latitude;
            location.Longitude = longitude;
            location.Name = name;
            location.Address = address;

            return location;
        }

        private Category GetCategory(string categoryString)
        {
            Category category = db.Categories.Where(x => x.Name.Equals(categoryString, StringComparison.CurrentCultureIgnoreCase)).FirstOrDefault();
            return category;
        }

        #endregion

        #region [SEARCH]

        public EventModel GetEventById(int id)
        {
            Event evt = db.Events.Where(e => e.EventId == id).FirstOrDefault();
            return Utilities.EventToEventModel(evt);
        }

        public IQueryable<EventModel> GetAllEventsByUserProfileId(int id)
        {
            List<EventModel> eventModels = new List<EventModel>();
            IQueryable<Event> events = db.Events.Where(e => e.CreatedById == id);

            foreach (Event evt in events)
            {
                eventModels.Add(Utilities.EventToEventModel(evt));
            }

            return eventModels.AsQueryable();
        }

        public IQueryable<EventModel> GetAllEvents()
        {
            List<EventModel> eventModels = new List<EventModel>();
            IQueryable<Event> events = db.Events;

            foreach (Event evt in events)
            {
                eventModels.Add(Utilities.EventToEventModel(evt));
            }

            return eventModels.AsQueryable();
        }

        public CommentModel GetCommentById(int id)
        {
            Comment comment = db.Comments.Where(c => c.CommentId == id).FirstOrDefault();
            return Utilities.CommentToCommentModel(comment);
        }

        public IQueryable<CommentModel> GetAllCommentsByUserProfileId(int id)
        {
            List<CommentModel> commentModels = new List<CommentModel>();
            IQueryable<Comment> comments = db.Comments.Where(c => c.UserProfileId == id);

            foreach (Comment comment in comments)
            {
                commentModels.Add(Utilities.CommentToCommentModel(comment));
            }

            return commentModels.AsQueryable();
        }

        public IQueryable<CommentModel> GetAllCommentsByEventId(int id)
        {
            List<CommentModel> commentModels = new List<CommentModel>();
            IQueryable<Comment> comments = db.Comments.Where(c => c.EventId == id);

            foreach (Comment comment in comments)
            {
                commentModels.Add(Utilities.CommentToCommentModel(comment));
            }

            return commentModels.AsQueryable();
        }

        public IQueryable<CommentModel> GetAllComments()
        {
            List<CommentModel> commentModels = new List<CommentModel>();
            IQueryable<Comment> comments = db.Comments;

            foreach (Comment comment in comments)
            {
                commentModels.Add(Utilities.CommentToCommentModel(comment));
            }

            return commentModels.AsQueryable();
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
            locationMatches = db.Events.Where(x => x.Location != null ? Utilities.AreWithinRadius(x.Location, queryModel.Location, 0.1) : true);

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

        #endregion

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
