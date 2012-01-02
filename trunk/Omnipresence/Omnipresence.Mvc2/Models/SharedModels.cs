using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Omnipresence.Mvc2.Models
{
    public class ProfileSidebarViewModel
    {
        public int FriendCount { get; set; }
        public int Reputation { get; set; }
        public string Name { get; set; }
        public string AvatarUrl { get; set; }
        public string Username { get; set; }
    }
    public class IndexSidebarViewModel
    {
        public string Name { get; set; }
        public string Username { get; set; }
        public string AvatarUrl { get; set; }
        public NotificationsShortList Notifications { get; set; }
    }
    public class NotificationsShortList
    {
        public int FriendRequests { get; set; }

        public override string ToString()
        {
            if (FriendRequests <= 0) return "You have no pending requests.";
            else if (FriendRequests == 1) return "You have 1 pending friend request.";
            else return "You have " + FriendRequests + " pending friend requests.";
        }
    }
}