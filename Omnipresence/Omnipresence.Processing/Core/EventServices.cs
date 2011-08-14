using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class EventServices
    {
        public void CreateEvent(string name, string desc, DateTime start, DateTime end, Int32 reputation, Int32 duration, 
                                EventCategory category, VisibilityType visibility, UserAccount creator)
        {
            Event newEvent = new Event();
            newEvent.Name = name;
            newEvent.Description = desc;
            newEvent.StartTime = start.TimeOfDay;
            newEvent.EndTime = end.TimeOfDay;
            newEvent.Reputation = reputation;
            newEvent.Duration = duration;
            newEvent.EventCategory = category;
            newEvent.VisibilityType = visibility;
            newEvent.UserAccount = creator;
            newEvent.CreationTime = System.DateTime.Now;

            using (CoreContainer coreContainer = new CoreContainer())
            {
                coreContainer.AddToEvents(newEvent);
                coreContainer.SaveChanges();
            }
        }

        public IQueryable<Event> GetEvents()
        {
            using (CoreContainer coreContainer = new CoreContainer())
            {
                return coreContainer.Events.AsQueryable();
            }
        }

        public void DeleteEvent(Event e)
        {
            using (CoreContainer coreContainer = new CoreContainer())
            {
                coreContainer.Events.DeleteObject(e);
                coreContainer.SaveChanges();
            }
        }
    }
}
