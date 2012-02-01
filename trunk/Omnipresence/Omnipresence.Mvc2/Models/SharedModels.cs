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
        public int UnreadMessages { get; set; }

        public override string ToString()
        {
            String returnvalue = "You have";

            if (FriendRequests <= 0) returnvalue += " no pending requests";
            else if (FriendRequests == 1) returnvalue += " 1 pending friend request";
            else returnvalue += " " + FriendRequests + " pending friend requests";

            if (UnreadMessages == 1) returnvalue += " and 1 unread message";
            else if (UnreadMessages > 1) returnvalue += " and " + UnreadMessages + " unread messages";

            returnvalue += ".";

            return returnvalue;
        }
    }
}