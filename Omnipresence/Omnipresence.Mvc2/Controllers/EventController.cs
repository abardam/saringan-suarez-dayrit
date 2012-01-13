using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;
using System.Data;
using System.Web.Routing;

namespace Omnipresence.Mvc2.Controllers
{
    public class EventController : Controller
    {
        //
        // GET: /Event/

        private AccountServices accountServices;
        private EventServices eventServices;
        private CommentServices commentServices;

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            eventServices = EventServices.GetInstance();
            accountServices = AccountServices.GetInstance();
            commentServices = CommentServices.GetInstance();
            base.Initialize(requestContext);
        }
        [Authorize]
        public ActionResult Index(int id = 0)
        {
            EventModel model = eventServices.GetEventById(id);
            if (model == null) return RedirectToAction("Index", "Home");


            EventCommentViewModel ecvm = new EventCommentViewModel
            {
                Address = model.Location.Address,
                Latitude = model.Location.Latitude,
                Longitude = model.Location.Longitude,
                EventId = model.EventId,
                StartTime = model.StartTime,
                EndTime = model.EndTime,
                Title = model.Title,
                Description = model.Description,
                Created = model.Created,
                CreatedById = model.CreatedById,
                IsActive = model.IsActive,
                IsPrivate = model.IsPrivate,
                LastModified = model.LastModified,
                Rating = model.Rating,
                NewComment = ""/*,
                CategoryString = model.Category.Description*/
            };

            ecvm.CreatedByUser = false;
            UserProfileModel profile = accountServices.GetUserProfileByUsername(User.Identity.Name);
            if (profile != null)
            {
                if (ecvm.CreatedById == profile.UserProfileId)
                {
                    ecvm.CreatedByUser = true;
                }
            }

            IEnumerable<CommentModel> tempie = commentServices.GetAllCommentsByEventId(model.EventId);
            List<CommentViewModel> commentList = new List<CommentViewModel>();

            DateTime now = DateTime.Now;

            int userProfileId = accountServices.GetUserByUsername(User.Identity.Name).UserProfile.UserProfileId;

            foreach (CommentModel cm in tempie)
            {
                UserProfileModel upm = accountServices.GetUserProfileByUserProfileId(cm.UserProfileId);

                CommentViewModel cvm = new CommentViewModel
                {
                    CommenterName = upm.FirstName + " " + upm.LastName,
                    CommentId = cm.CommentId,
                    CommentText = cm.CommentText,
                    EventId = cm.EventId,
                    Timestamp = cm.Timestamp,
                    UserProfileId = cm.UserProfileId,
                    UserIsAuthor = cm.UserProfileId == userProfileId
                };

                if (now.Month == cm.Timestamp.Month)
                {
                    if (now.Day == cm.Timestamp.Day)
                    {
                        int mins;
                        if (now.Hour == cm.Timestamp.Hour)
                        {
                            mins = (now.Minute - cm.Timestamp.Minute);
                        }
                        else if (now.Hour == cm.Timestamp.Hour + 1 && (now.Minute + 60 - cm.Timestamp.Minute) < 60)
                        {
                            mins = (now.Minute + 60 - cm.Timestamp.Minute);
                        }
                        else
                        {
                            mins = -1;
                        }

                        if (mins == 0)
                        {
                            cvm.TimeString = "Just now";
                        }
                        else if (mins == 1)
                        {
                            cvm.TimeString = "1 minute ago";
                        }
                        else if (mins == -1)
                        {
                            cvm.TimeString = cm.Timestamp.ToShortTimeString();
                        }
                        else
                        {
                            cvm.TimeString = mins + " minutes ago";
                        }


                    }
                    else
                    {
                        cvm.TimeString = cm.Timestamp.ToShortDateString();
                    }
                }
                else
                {
                    cvm.TimeString = cm.Timestamp.ToShortDateString();
                }

                commentList.Add(cvm);
            }

            ecvm.CommentList = commentList;



            return View(ecvm);
        }

        [Authorize]
        [HttpPost]
        public ActionResult Index(int id, EventCommentViewModel model)
        {
            CreateCommentModel ccm = new CreateCommentModel
            {
                Comment = model.NewComment,
                EventId = id,
                UserProfileId = AccountServices.GetInstance().GetUserByUsername(User.Identity.Name).UserProfile.UserProfileId
            };
            commentServices.CreateComment(ccm);
            return Index(id);
        }

        public ActionResult New()
        {
            UserModel um = accountServices.GetUserByUsername(User.Identity.Name);

            CreateEventViewModel model = new CreateEventViewModel();
            model.Title = "";
            model.CreateTime = DateTime.Now;
            model.DeleteTime = DateTime.Now;

            ProfileController.SetViewDataForDate(ViewData);
            ProfileController.SetViewDataForTime(ViewData);
            return View(model);
        }

        [HttpPost]
        public ActionResult New(CreateEventViewModel model)
        {
            UserModel um = accountServices.GetUserByUsername(User.Identity.Name);
            CreateEventModel cem = new CreateEventModel();
            cem.Address = model.Address;
            cem.CategoryString = model.CategoryString;
            cem.Description = model.Description;
            cem.EndTime = DateTime.Parse(model.EndMonth + "/" + model.EndDay + "/" + model.EndYear + " " + model.EndHour + ":" + model.EndMinute + " " + model.EndAMPM);
            cem.Latitude = model.Latitude;
            cem.Longitude = model.Longitude;
            cem.StartTime = DateTime.Parse(model.StartMonth + "/" + model.StartDay + "/" + model.StartYear + " " + model.StartHour + ":" + model.StartMinute + " " + model.StartAMPM);
            cem.Title = model.Title;
            string username = User.Identity.Name;
            cem.UserProfileId = accountServices.GetUserProfileByUsername(username).UserProfileId;
            try
            {
                eventServices.CreateEvent(cem);
            }
            catch (ConstraintException e)
            {
                ViewData["message"] = e.Message;

                if (e.Data.Contains("Entity"))
                {
                    ViewData["message"] = e.Data["Entity"] + " cannot be left blank!";
                }

                ProfileController.SetViewDataForDate(ViewData);
                ProfileController.SetViewDataForTime(ViewData);
                return View(model);
            }
            return Redirect("/");
        }

        public ActionResult Edit(int id)
        {
            EventModel em = eventServices.GetEventById(id);
            UserProfileModel profile = accountServices.GetUserProfileByUsername(User.Identity.Name);
            if (profile != null && em != null)
            {
                if (em.CreatedById == profile.UserProfileId)
                {
                    return View(em);
                }
            }

            return RedirectToAction("Index", "Home");
        }
        // TODO: Wala pang httppost

        public ActionResult All()
        {
            return View(generateIndexViewModel(eventServices.GetAllEvents().Take(10)));
        }

        public ActionResult Hot(int id = 0)
        {
            return View(generateIndexViewModel(eventServices.GetHotEvents(id)));
        }

        public ActionResult Top(int id = 0)
        {
            return View(generateIndexViewModel(eventServices.GetTopEvents(id)));
        }
        [Authorize]
        public ActionResult Subscriptions(int id = 0)
        {
            return View(generateIndexViewModel(
                eventServices.GetSubscriptionEvents(accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId, id)
                ));
        }
        private IndexViewModel generateIndexViewModel(IEnumerable<EventModel> events)
        {
            UserProfileModel profile = accountServices.GetUserProfileByUsername(User.Identity.Name);
            NotificationsShortList notifications = profile != null ? new NotificationsShortList { FriendRequests = accountServices.GetFriendRequests(new GetFriendRequestsModel { UserProfileId = profile.UserProfileId }).Count() } : null;
            if (profile == null) profile = new UserProfileModel { Avatar = "", FirstName = "", LastName = "" };
            IndexSidebarViewModel sidebar = new IndexSidebarViewModel { AvatarUrl = profile.Avatar, Name = profile.FirstName + " " + profile.LastName, Notifications = notifications, Username = User.Identity.Name };
            return (new IndexViewModel { DisplayName = sidebar.Name, Events = events, Sidebar = sidebar });
        }

    }

}
