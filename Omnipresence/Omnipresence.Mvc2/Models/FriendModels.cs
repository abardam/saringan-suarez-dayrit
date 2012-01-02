using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Omnipresence.Processing;
namespace Omnipresence.Mvc2.Models
{
    public class FriendsViewModel
    {
        public IEnumerable<ProfileIdModel> Friends { get; set; }
        public string Username { get; set; }
    }

    public class FriendRequestViewModel
    {
        public int UserProfileId { get; set; }
        public string FullName { get; set; }
    }
}