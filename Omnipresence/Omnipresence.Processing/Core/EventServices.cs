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
        #region CONSTANTS
        public const int MIN_RESULTS = 10;
        #endregion

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
                evt.EndTime = uem.EndTime;
                evt.Category = uem.Category;
                evt.IsPrivate = uem.IsPrivate;
                evt.IsActive = uem.IsActive;
                evt.Rating = uem.Rating;

                evt.Location = db.Locations.Where(x => x.LocationId == evt.LocationId).FirstOrDefault();
                evt.Location.Address = uem.Address;
                evt.Location.Latitude = uem.Latitude;
                evt.Location.Longitude = uem.Longitude;

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

        public bool MarkAsRead(Guid MessageId, bool isRead)
        {
            Mail mail = db.Mails.Where(p => p.MailId == MessageId).First();

            if (mail == null) return false;
            mail.Read = isRead;
            db.SaveChanges();
            return true;
        }

        public bool Share(ShareEventModel shareEventModel)
        {
            Event _event = db.Events.Where(ev => ev.EventId == shareEventModel.EventID).FirstOrDefault();
            UserProfile _profile = db.UserProfiles.Where(up => up.UserProfileId == shareEventModel.SharerProfileId).FirstOrDefault();
            IEnumerable<UserProfile> _recipients = db.UserProfiles.Where(rec => shareEventModel.SharedProfileIDList.Contains(rec.UserProfileId));
            if (_profile == null || _recipients.Count() <= 0) return false;

            foreach (UserProfile _recipient in _recipients)
            {
                MessageModel mm = new MessageModel
                {
                    Message = shareEventModel.Message,
                    SenderProfileID = shareEventModel.SharerProfileId,
                    ReceipientProfileID = _recipient.UserProfileId
                };

                
                if(_event!=null){
                    mm.EventID = shareEventModel.EventID;
                }

                _sendMessage(mm);


                /*db.Mails.AddObject(
                    new Mail
                    {
                        MailMessage = shareEventModel.Message,
                        FromUserProfile = _profile,
                        ReferredEvent = _event,
                        ToUserProfile = _recipient,
                        Read = false,
                        Starred = false
                    });*/
            }
            
            db.SaveChanges();

            return true;
        }

        public bool Vote(VoteEventModel voteEventModel)
        {
            if (voteEventModel.UserProfileId < 1 || voteEventModel.EventId < 1)
            {
                return false;
            }
            Event curEvent = db.Events.Where(ev => (ev.EventId == voteEventModel.EventId)).FirstOrDefault();
            UserProfile userProfile = db.UserProfiles.Where(up => up.UserProfileId == voteEventModel.UserProfileId).FirstOrDefault();
            EventVote eventVote = db.EventVotes.Where(e => e.EventId == curEvent.EventId && e.UserProfileId == userProfile.UserProfileId).FirstOrDefault();

            if (curEvent == null || userProfile == null) return false;
            if (eventVote == null)
            {
                if (voteEventModel.IsDownvote) curEvent.Rating--;
                else curEvent.Rating++;
                db.EventVotes.AddObject(
                    new EventVote
                    {
                        UserProfileId = userProfile.UserProfileId,
                        EventId = curEvent.EventId,
                        IsUpVote = !voteEventModel.IsDownvote
                    });
                db.SaveChanges();

                return true;
            }
            // New: added new functionality for upvote and downvote.
            if (eventVote.IsUpVote)
            {
                if (voteEventModel.IsDownvote)
                {
                    curEvent.Rating -= 2;
                }
                eventVote.IsUpVote = false;
            }
            else
            {
                if (!voteEventModel.IsDownvote)
                {
                    curEvent.Rating += 2;
                }
                eventVote.IsUpVote = true;
            }
            db.SaveChanges();
            return true;
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

        public IEnumerable<EventModel> QueryEvents(QueryEventModel queryModel)
        {
            IEnumerable<Event> titleMatches;
            titleMatches = db.Events.Where(x => queryModel.Title != null ? x.Title.Equals(queryModel.Title, StringComparison.CurrentCultureIgnoreCase) : true);

            IEnumerable<Event> descriptionMatches;
            descriptionMatches = db.Events.Where(x => queryModel.Description != null ? x.Description.Contains(queryModel.Description) : true);

            IEnumerable<Event> startTimeMatches = null;
            IEnumerable<Event> endTimeMatches = null;
            if (queryModel.DateSearch)
            {

                startTimeMatches = db.Events.Where(x => queryModel.StartTime != null ? x.StartTime >= queryModel.StartTime : true);

                endTimeMatches = db.Events.Where(x => queryModel.EndTime != null ? x.EndTime <= queryModel.EndTime : true);
            }
            //IEnumerable<Event> locationMatches;
            //locationMatches = db.Events.Where(x => x.Location != null ? Utilities.AreWithinRadius(x.Location, queryModel.Location, 0.1) : true);

            IEnumerable<Event> result = titleMatches;
            result = result.Union(descriptionMatches);
            if (startTimeMatches != null)
            {
                result = result.Union(startTimeMatches);
            }

            if (endTimeMatches != null)
            {
                result = result.Union(endTimeMatches);
            }

            List<EventModel> eventModels = new List<EventModel>();
            EventModel evtModel = null;

            foreach (Event evt in result)
            {
                evtModel = Utilities.EventToEventModel(evt);
                eventModels.Add(evtModel);
            }

            return eventModels.AsQueryable();
        }

        public IQueryable<EventModel> GetHotEvents(int page = 1, int itemsPerPage = 10)
        {
            List<EventModel> eventModels = new List<EventModel>();
            DateTime now = DateTime.Now.Subtract(new TimeSpan(4, 0, 0, 0));
            DateTime later = DateTime.Now.AddDays(4);
            IQueryable<Event> events = db.Events.Where(ev => ev.StartTime > now && ev.StartTime < later).OrderBy(x => x.Rating).Skip((page) * itemsPerPage).Take(itemsPerPage);

            foreach (Event evt in events)
            {
                eventModels.Add(Utilities.EventToEventModel(evt));
            }

            return eventModels.AsQueryable();
        }

        public IQueryable<EventModel> GetTopEvents(int page = 1, int itemsPerPage = 10)
        {
            List<EventModel> eventModels = new List<EventModel>();
            IQueryable<Event> events = db.Events.OrderBy(x => x.Rating).Skip((page) * itemsPerPage).Take(itemsPerPage);

            foreach (Event evt in events)
            {
                eventModels.Add(Utilities.EventToEventModel(evt));
            }

            return eventModels.AsQueryable();
        }

        public IQueryable<EventModel> GetSubscriptionEvents(int userProfileId, int page = 1, int itemsPerPage = 10)
        {
            List<EventModel> eventModels = new List<EventModel>();
            IQueryable<UserProfileModel> _friends = AccountServices.GetInstance().GetAllFriends(new GetFriendsModel { UserProfileId = userProfileId });

            DateTime now = DateTime.Now.Subtract(new TimeSpan(4, 0, 0, 0));
            DateTime later = DateTime.Now.AddDays(4);
            IQueryable<Event> events = db.Events.Where(ev => ev.StartTime > now && ev.StartTime < later);

            foreach (Event evt in events)
            {
                if (_friends.Where(x => x.UserProfileId == evt.CreatedById).Count() > 0)
                {
                    eventModels.Add(Utilities.EventToEventModel(evt));
                }
            }

            return eventModels.AsQueryable().Skip((page - 1) * itemsPerPage).Take(itemsPerPage);
        }

        public MessageModel GetMessage(GetMessageModel getMessageModel)
        {
            //TODO. the method.

            return new MessageModel
            {
                Message = "sup ho",
                ReceipientProfileID = 1,
                SenderProfileID = 2
            };
        }

        public IQueryable<MessageModel> GetMessages(GetMessagesModel getMessagesModel)
        {
            UserProfile _user = db.UserProfiles.Where(us => us.UserProfileId == getMessagesModel.UserProfileID).FirstOrDefault();
            if (_user == null) return null;
            if (getMessagesModel.NumberOfResults == 0) getMessagesModel.NumberOfResults = MIN_RESULTS;
            if (getMessagesModel.PageNumber < 1) getMessagesModel.PageNumber = 1;
            IEnumerable<Mail> query;

            if (getMessagesModel.GetUnreadOnly)
            {
                query = db.Mails.Where(mail => mail.ToUserProfile.UserProfileId == _user.UserProfileId && !mail.Read).OrderBy(sort => sort.DateSent).Skip((getMessagesModel.PageNumber - 1) * getMessagesModel.NumberOfResults).Take(getMessagesModel.NumberOfResults).ToList();
            }
            else
            {
                query = db.Mails.Where(mail => mail.ToUserProfile.UserProfileId == _user.UserProfileId).OrderBy(sort => sort.DateSent).Skip((getMessagesModel.PageNumber - 1) * getMessagesModel.NumberOfResults).Take(getMessagesModel.NumberOfResults).ToList();
            }

            List<MessageModel> retval = new List<MessageModel>();

            foreach (Mail g in query)
            {
                retval.Add(new MessageModel
                {
                    EventID = g.ReferredEvent == null ? (int?)null : g.ReferredEvent.EventId,
                    Message = g.MailMessage,
                    MessageID = g.MailId,
                    ReceipientProfileID = g.ToUserProfile.UserProfileId,
                    SenderProfileID = g.FromUserProfile.UserProfileId
                });
            }
            return retval.AsQueryable();
        }

        public bool SendMessage(MessageModel messageModel)
        {
            if (messageModel.ReceipientProfileID < 1 || messageModel.SenderProfileID < 1)
            {
                return false;
            }
            UserProfile _sender = db.UserProfiles.Where(x => x.UserProfileId == messageModel.SenderProfileID).FirstOrDefault();
            UserProfile _recipient = db.UserProfiles.Where(x => x.UserProfileId == messageModel.ReceipientProfileID).FirstOrDefault();

            if (_sender == null || _recipient == null)
            {
                return false;
            }

            Event _event = db.Events.Where(ev => ev.EventId == messageModel.EventID).FirstOrDefault();

            Mail newMail = new Mail
            {
                DateSent = DateTime.Now,
                FromUserProfile = _sender,
                MailMessage = messageModel.Message,
                Read = false,
                ReferredEvent = _event,
                Starred = false,
                ToUserProfile = _recipient
            };

            db.Mails.AddObject(newMail);
            db.SaveChanges();
            return true;
        }


        //same as above, pero walang db.save changes
        private bool _sendMessage(MessageModel messageModel)
        {
            if (messageModel.ReceipientProfileID < 1 || messageModel.SenderProfileID < 1)
            {
                return false;
            }
            UserProfile _sender = db.UserProfiles.Where(x => x.UserProfileId == messageModel.SenderProfileID).FirstOrDefault();
            UserProfile _recipient = db.UserProfiles.Where(x => x.UserProfileId == messageModel.ReceipientProfileID).FirstOrDefault();

            if (_sender == null || _recipient == null)
            {
                return false;
            }

            Event _event = db.Events.Where(ev => ev.EventId == messageModel.EventID).FirstOrDefault();

            Mail newMail = new Mail
            {
                DateSent = DateTime.Now,
                FromUserProfile = _sender,
                MailMessage = messageModel.Message,
                Read = false,
                ReferredEvent = _event,
                Starred = false,
                ToUserProfile = _recipient
            };

            db.Mails.AddObject(newMail);
            return true;
        }

        #endregion

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
