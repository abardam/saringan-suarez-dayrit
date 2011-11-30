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
                evtModel.IsPrivate = evt.IsPrivate;
                evtModel.Location = evt.Location;
                evtModel.IsActive = evt.IsActive;
                evtModel.LastModified = evt.LastModified;
                evtModel.Created = evt.Created;
                evtModel.Rating = evt.Rating;
                evtModel.CreatedById = evt.CreatedById;

                return evtModel;
            }
            else
            {
                return null;
            }
        }

        public static UserProfileModel UserProfileToUserProfileModel(UserProfile userProfile)
        {
            if (userProfile != null)
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
            else
            {
                return null;
            }
        }

        public static bool AreFriends(UserProfile a, UserProfile b)
        {
            IEnumerable<Friendship> test = a.RequestedFriendships.Where(x => x.AddedId == b.UserProfileId).Union(b.RequestedFriendships.Where(y => y.AddedId == a.UserProfileId));

            return test.Count() != 0;
        }

        public static bool AreWithinRadius(Location a, Location b, double radius)
        {
            double x1 = a.Latitude;
            double y1 = a.Longitude;

            double x2 = b.Latitude;
            double y2 = b.Longitude;

            return Math.Sqrt((y1 - x1) * (y1 - x1) + (y2 - x2) * (y2 - x2)) <= radius;
        }

        public static CommentModel CommentToCommentModel(Comment comment)
        {
            if (comment != null)
            {
                CommentModel commentModel = new CommentModel();

                commentModel.CommentId = comment.CommentId;
                commentModel.UserProfileId = comment.UserProfileId;
                commentModel.EventId = comment.EventId;
                commentModel.CommentText = comment.CommentText;
                commentModel.Timestamp = comment.Timestamp;

                return commentModel;
            }
            else
            {
                return null;
            }
        }

        public static ApiUserModel ApiUserToApiUserModel(ApiUser apiUser)
        {
            ApiUserModel apiUserModel = new ApiUserModel();
            apiUserModel.ApiUserId = apiUser.ApiUserId;
            apiUserModel.ApiKey = apiUser.ApiKey;
            apiUserModel.ApiCallCount = apiUser.ApiCallCount;
            apiUserModel.LastCallDate = apiUser.LastCallDate;
            apiUserModel.Email = apiUser.Email;
            apiUserModel.AppName = apiUser.AppName;

            return apiUserModel;
        }
    }
}
