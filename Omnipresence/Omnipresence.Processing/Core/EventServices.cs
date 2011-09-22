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
        public void CreateEvent(string name, string desc, DateTime start, DateTime end, Int32 reputation, Int32 duration, 
                                EventCategory category, VisibilityType visibility, User creator)
        {
            Event newEvent = new Event();
            newEvent.Name = name;
            newEvent.Description = desc;
            newEvent.StartTime = start;
            newEvent.EndTime = end;
            newEvent.Reputation = reputation;
            newEvent.Duration = duration;
            newEvent.EventCategory = category;
            newEvent.VisibilityType = visibility;
            //newEvent. = creator;
            newEvent.CreationTime = System.DateTime.Now;

            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                db.AddToEvents(newEvent);
                db.SaveChanges();
            }
        }

        public IQueryable<Event> GetEvents()
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                return db.Events.AsQueryable();
            }
        }

        public void DeleteEvent(Event e)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                db.Events.DeleteObject(e);
                db.SaveChanges();
            }
        }

        public IEnumerable<EventViewModelMicro> EventQuery(EventQueryModel model)
        {
            IEnumerable<EventViewModelMicro> r;
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                r = from p in db.Events
                    select new EventViewModelMicro() { EventId = p.EventId,
                    Name = p.Name, End = p.EndTime, Start = p.StartTime, Latitude = p.Location.Latitude, Longitude = p.Location.Longitude, Type = p.EventCategory.CategoryName };
                if (model.Type != "")
                {
                    r = r.Where(x => x.Type == model.Type);
                }
                if (model.Tags.Count() > 0)
                {
                    // TODO: Actual string search schtuff
                }
                if (model.SearchString != "")
                {
                    // TODO: Actual string search schtuff
                }// TODO: CITY USER FRIENDS SUBSCRIPTIONS ETC WALA NAHHHHFUFHBUIRGUORGVIO
            }
            return r;
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
