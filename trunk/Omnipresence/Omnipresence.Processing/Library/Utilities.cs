using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class Utilities
    {
        private Utilities()
        {
        }

        public static UserModel UserToUserModel(User user)
        {
            if (user != null)
            {
                UserModel userModel = new UserModel();
                userModel.UserId = user.UserId;
                userModel.Username = user.Username;
                userModel.Password = user.Password;
                userModel.Email = user.Email;
                userModel.CreatedDate = user.CreatedDate;
                userModel.IsActivated = user.IsActivated;
                userModel.IsLockedOut = user.IsLockedOut;
                userModel.LastLoginDate = user.LastLoginDate;
                userModel.LastLockedOutDate = user.LastLockedOutDate;
                userModel.UserProfile = user.UserProfile;

                return userModel;
            }
            else
            {
                return null;
            }
        }

        //public static User UserModelToUser(UserModel userModel)
        //{
        //    if (userModel != null)
        //    {
        //        User user = new User();
        //        user.Username = userModel.Username;
        //        user.Password = userModel.Password;
        //        user.PasswordSalt = userModel.PasswordSalt;
        //        user.Email = userModel.Email;
        //        user.AlternateEmail = userModel.AlternateEmail;
        //        user.SecurityQuestion = userModel.SecurityQuestion;
        //        user.SecurityAnswer = userModel.SecurityAnswer;
        //        user.CreatedDate = userModel.CreatedDate;
        //        user.IsActivated = userModel.IsActivated;
        //        user.IsLockedOut = userModel.IsLockedOut;
        //        user.LastLoginDate = user.LastLoginDate;
        //        user.UserProfile = userModel.UserProfile;

        //        return user;
        //    }
        //    else
        //    {
        //        return null;
        //    }
        //}

        public static EventModel EventToEventModel(Event evt)
        {
            if (evt != null)
            {
                EventModel evtModel = new EventModel();
                evtModel.EventId = evt.EventId;
                evtModel.Title = evt.Title;
                evtModel.Description = evt.Description;
                evtModel.StartTime = evt.StartTime;
                evtModel.EndTime = evt.EndTime;
                evtModel.Category = evt.Category;
                evtModel.VisibilityType = evt.VisibilityType;
                evtModel.Location = evt.Location;
                evtModel.IsActive = evt.IsActive;
                evtModel.LastModified = evt.LastModified;
                evtModel.Created = evt.Created;
                evtModel.Rating = evt.Rating;

                return evtModel;
            }
            else
            {
                return null;
            }
        }

        //public static Event EventModelToEvent(EventModel eventModel)
        //{
        //    if (eventModel != null)
        //    {
        //        Event newEvent = new Event();
        //        newEvent.Title = eventModel.Title;
        //        newEvent.Description = eventModel.Description;
        //        newEvent.StartTime = eventModel.StartTime;
        //        newEvent.EndTime = eventModel.EndTime;
        //        newEvent.Category = eventModel.Category;
        //        newEvent.VisibilityType = eventModel.VisibilityType;
        //        newEvent.Location = eventModel.Location;
        //        newEvent.IsActive = eventModel.IsActive;
        //        newEvent.LastModified = eventModel.LastModified;
        //        newEvent.Created = eventModel.Created;
        //        newEvent.Rating = eventModel.Rating;

        //        return newEvent;
        //    }
        //    else
        //    {
        //        return null;
        //    }
        //}

        public static UserProfileModel UserProfileToUserProfileModel(UserProfile userProfile)
        {
            UserProfileModel userProfileModel = new UserProfileModel();
            userProfileModel.UserProfileId = userProfile.UserProfileId;
            userProfileModel.FirstName = userProfile.FirstName;
            userProfileModel.LastName = userProfile.LastName;
            userProfileModel.IsFemale = userProfile.IsFemale;
            userProfileModel.Description = userProfile.Description;
            userProfileModel.AcceptedFriendships = userProfile.AcceptedFriendships;
            userProfileModel.RequestedFriendships = userProfile.RequestedFriendships;
            userProfileModel.Birthdate = userProfile.Birthdate;
            userProfileModel.Comments = userProfile.Comments;
            userProfileModel.Reputation = userProfile.Reputation;
            userProfileModel.Avatar = userProfile.Avatar;
            
            return userProfileModel;
        }
    }
}
