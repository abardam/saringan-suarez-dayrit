using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    public class ServiceController : Controller
    {
        private AccountServices accountServices;
        private EventServices eventServices;
        private ApiServices apiServices;

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            accountServices = AccountServices.GetInstance();
            eventServices = EventServices.GetInstance();
            apiServices = ApiServices.GetInstance();

            base.Initialize(requestContext);
        }

        public JsonResult GetUserProfile(string key, string username)
        {
            if (apiServices.IsValidKey(key))
            {
                UserProfileModel upm = accountServices.GetUserProfileByUsername(username);
                ProfileViewModel pvm = new ProfileViewModel();
                pvm.FirstName = upm.FirstName;
                pvm.LastName = upm.LastName;
                pvm.Description = upm.Description;
                pvm.Reputation = upm.Reputation;
                pvm.Birthdate = upm.Birthdate;
                pvm.GenderText = upm.IsFemale ? "Female" : "Male";

                apiServices.IncrementKeyUsage(key);

                return Json(pvm, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetEventsByUser(string key, string username)
        {
            if (apiServices.IsValidKey(key))
            {
                UserProfileModel userProfileModel = accountServices.GetUserProfileByUsername(username);
                List<EventModel> events = eventServices.GetAllEventsByUserProfileId(userProfileModel.UserProfileId).ToList();

                EventViewModel[] result = new EventViewModel[events.Count];
                EventViewModel evm;

                for (int i = 0; i < events.Count; i++)
                {
                    evm = new EventViewModel();
                    evm.EventId = events[i].EventId;
                    evm.Title = events[i].Title;
                    evm.Description = events[i].Description;
                    evm.StartTime = events[i].StartTime;
                    evm.EndTime = events[i].EndTime;
                    evm.IsActive = events[i].IsActive;
                    evm.IsPrivate = events[i].IsPrivate;
                    evm.Rating = events[i].Rating;
                    evm.CreatedById = events[i].CreatedById;
                    //evm.Address = events[i].Address;
                    //evm.Latitude = events[i].Latitude;
                    //evm.Longitude = events[i].Longitude;

                    result[i] = evm;
                }

                apiServices.IncrementKeyUsage(key);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetCommentsByUser(string key, string username)
        {
            if (apiServices.IsValidKey(key))
            {
                UserProfileModel userProfileModel = accountServices.GetUserProfileByUsername(username);
                List<CommentModel> comments = eventServices.GetAllCommentsByUserProfileId(userProfileModel.UserProfileId).ToList();

                CommentViewModel[] result = new CommentViewModel[comments.Count];
                CommentViewModel cvm;

                for (int i = 0; i < comments.Count; i++)
                {
                    cvm = new CommentViewModel();
                    cvm.CommentId = comments[i].CommentId;
                    cvm.EventId = comments[i].EventId;
                    cvm.UserProfileId = comments[i].UserProfileId;
                    cvm.CommentText = comments[i].CommentText;
                    cvm.Timestamp = comments[i].Timestamp;
                    result[i] = cvm;
                }

                apiServices.IncrementKeyUsage(key);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetCommentsByEvent(string key, int id)
        {
            if (apiServices.IsValidKey(key))
            {
                EventModel ev = eventServices.GetEventById(id);
                List<CommentModel> comments = eventServices.GetAllCommentsByEventId(ev.EventId).ToList();

                CommentViewModel[] result = new CommentViewModel[comments.Count];
                CommentViewModel cvm;

                for (int i = 0; i < comments.Count; i++)
                {
                    cvm = new CommentViewModel();
                    cvm.CommentId = comments[i].CommentId;
                    cvm.EventId = comments[i].EventId;
                    cvm.UserProfileId = comments[i].UserProfileId;
                    cvm.CommentText = comments[i].CommentText;
                    cvm.Timestamp = comments[i].Timestamp;
                    result[i] = cvm;
                }

                apiServices.IncrementKeyUsage(key);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetFriends(string key, string username)
        {
            if (apiServices.IsValidKey(key))
            {
                UserProfileModel userProfile = accountServices.GetUserProfileByUsername(username);
                GetFriendsModel gfm = new GetFriendsModel();
                gfm.UserProfileId = userProfile.UserProfileId;
                List<UserProfileModel> friends = accountServices.GetAllFriends(gfm).ToList();
                
                ProfileViewModel[] result = new ProfileViewModel[friends.Count];
                ProfileViewModel pvm;

                for (int i = 0; i < friends.Count; i++)
                {
                    pvm = new ProfileViewModel();
                    pvm.FirstName = friends[i].FirstName;
                    pvm.LastName = friends[i].LastName;
                    pvm.Description = friends[i].Description;
                    pvm.Reputation = friends[i].Reputation;
                    pvm.Birthdate = friends[i].Birthdate;
                    pvm.GenderText = friends[i].IsFemale ? "Female" : "Male";

                    result[i] = pvm;
                }

                apiServices.IncrementKeyUsage(key);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
