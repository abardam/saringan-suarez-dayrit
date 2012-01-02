using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Models
{
    public class ProfileViewModel
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public int UserProfileId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthdate { get; set; }
        public string Description { get; set; }
        public string AvatarUrl { get; set; }
        public int Reputation { get; set; }
        public string GenderText { get; set; }
        public Boolean ViewingOwn { get; set; }
        public Boolean ViewingFriend { get; set; }
        public IEnumerable<ProfileIdModel> Friends { get; set; }
        public IEnumerable<EventModel> UserEvents { get; set; }

        public ProfileSidebarViewModel Sidebar { get; set; }
        public Boolean FriendRequested { get; set; }
        public Boolean ThisDudeHasSentAFriendRequestToYou { get; set; }
    }
    public class EditProfileViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthdate { get; set; }
        public string Description { get; set; }
        public string AvatarUrl { get; set; }
        public int Reputation { get; set; }
        public string GenderText { get; set; }


        public int BirthdateDay { get; set; }
        public string BirthdateMonth { get; set; }
        public IEnumerable<SelectListItem> Months
        {
            get
            {
                return DateTimeFormatInfo
                       .InvariantInfo
                       .MonthNames
                       .Select((monthName, index) => new SelectListItem
                       {
                           Value = (index + 1).ToString(),
                           Text = monthName
                       });
            }
        }
        public int BirthdateYear { get; set; }
    }

    public class NotificationModel
    {
        public List<FriendRequestViewModel> FriendRequestNotifications { get; set; }
        //add others
    }
}
