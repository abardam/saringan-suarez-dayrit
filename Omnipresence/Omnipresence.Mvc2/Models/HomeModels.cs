using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Models
{
    public class IndexViewModel
    {
        public string DisplayName { get; set; }
        public IEnumerable<Omnipresence.Processing.EventModel> Events { get; set; }
        public IndexSidebarViewModel Sidebar { get; set; }
    }
    public class NotificationsViewModel
    {
        public string Message { get; set; }
        public IEnumerable<UserProfileModel> PendingFriendRequests { get; set; }
        public IEnumerable<MessageViewModel> UnreadMessages { get; set; }
        // TODO: Add stuff when there are other notifications.
    }
}