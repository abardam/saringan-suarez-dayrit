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

            IEnumerable<MediaItemModel> medias = MediaServices.GetInstance().GetMediaItemsByEvent(model.EventId);
            List<String> mediasFilesnames = new List<String>();

            foreach(MediaItemModel mim in medias){
                //mediasFilesnames.Add(HttpContext.Server.MapPath("~/Uploads/Images/" + mim.FileName));
                mediasFilesnames.Add(mim.FileName);
            }

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
                NewComment = "",
                MediaFileNameList = mediasFilesnames.AsEnumerable()/*,
                CategoryString = model.Category.Description*/,
                CreatorUsername = accountServices.GetUserByUserProfileId(model.CreatedById).Username
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
            ProfileController.SetViewDataForDate(ViewData);
            ProfileController.SetViewDataForTime(ViewData);
            EventModel em = eventServices.GetEventById(id);
            EditEventViewModel cem = new EditEventViewModel
            {
                EventId = id,
                Address = em.Location.Address,
                CategoryString = em.Category != null ? em.Category.Description : "",
                Description = em.Description,
                EndTime = em.EndTime,
                Latitude = em.Location.Latitude,
                Longitude = em.Location.Longitude,
                StartTime = em.StartTime,
                Title = em.Title,
                CreatedBy = em.CreatedById,
                CreateTime = em.Created,
                StartDay = em.StartTime.Day,
                StartMinute = em.StartTime.Minute.ToString(),
                StartYear = em.StartTime.Year,
                EndDay = em.EndTime.Day,
                EndMinute = em.EndTime.Minute.ToString(),
                EndYear = em.EndTime.Year
            };

            cem.StartMonth = cem.Months.ToArray()[em.StartTime.Month - 1].Value;
            cem.EndMonth = cem.Months.ToArray()[em.EndTime.Month - 1].Value;

            if (em.StartTime.Hour > 12)
            {
                cem.StartAMPM = "PM";
                cem.StartHour = em.StartTime.Hour - 12;
            }
            else
            {
                cem.StartAMPM = "AM";
                cem.StartHour = em.StartTime.Hour;
            }

            if (em.EndTime.Hour > 12)
            {
                cem.EndAMPM = "PM";
                cem.EndHour = em.EndTime.Hour - 12;
            }
            else
            {
                cem.EndAMPM = "AM";
                cem.EndHour = em.EndTime.Hour;
            }
            UserProfileModel profile = accountServices.GetUserProfileByUsername(User.Identity.Name);
            if (profile != null && em != null)
            {
                if (em.CreatedById == profile.UserProfileId)
                {
                    return View(cem);
                }
            }

            return RedirectToAction("Index", "Home");
        }
        // TODO: Wala pang httppost

        // ito na.

        [HttpPost]
        public ActionResult Edit(EditEventViewModel model)
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

                eventServices.UpdateEvent(new UpdateEventModel
                {
                    Description = cem.Description,
                    EndTime = cem.EndTime,
                    EventId = model.EventId,
                    IsPrivate = cem.IsPrivate,
                    Address = model.Address,
                    Latitude = model.Latitude,
                    Longitude = model.Longitude,
                    StartTime = cem.StartTime,
                    Title = cem.Title,
                });
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
            return Redirect("/e/" + model.EventId);
        }


        public ActionResult All(String SearchString="", bool DateSearch=false)
        {
            IndexViewModel ivm;

            if (SearchString == null)
            {
                ivm = generateIndexViewModel(eventServices.GetAllEvents().Take(10));
            }
            else
            {
                ivm = generateIndexViewModel(eventServices.QueryEvents(new QueryEventModel
                        {
                            Description = SearchString,
                            Title = SearchString,
                            DateSearch = false
                        }));
            }
            return View(ivm);
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
            NotificationsShortList notifications = profile != null ? new NotificationsShortList {
                UnreadMessages = eventServices.GetMessages(new GetMessagesModel{
                    GetUnreadOnly = true,
                    UserProfileID = profile.UserProfileId}).Count(),
                FriendRequests = accountServices.GetFriendRequests(new GetFriendRequestsModel { UserProfileId = profile.UserProfileId }).Count() } : null;
            if (profile == null) profile = new UserProfileModel { Avatar = "", FirstName = "", LastName = "" };
            IndexSidebarViewModel sidebar = new IndexSidebarViewModel { AvatarUrl = profile.Avatar, Name = profile.FirstName + " " + profile.LastName, Notifications = notifications, Username = User.Identity.Name };
            return (new IndexViewModel { DisplayName = sidebar.Name, Events = events, Sidebar = sidebar });
        }
        [Authorize]
        public ActionResult VoteUp(int id = 0)
        {
            if (id != 0)
            {
                int profId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId;
                eventServices.Vote(new VoteEventModel { UserProfileId = profId, EventId = id, IsDownvote = false });
                return RedirectToAction("Index", new { id = id });
                // TODO: UPDATE IFORHDFHRLIUV|UHDRAWI
            }
            return RedirectToAction("Index", "Home");
        }
        [Authorize]
        public ActionResult VoteDown(int id = 0)
        {
            if (id != 0)
            {
                int profId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId;
                eventServices.Vote(new VoteEventModel { UserProfileId = profId, EventId = id, IsDownvote = true });
                return RedirectToAction("Index", new { id = id });
                // TODO: UPDATE IFORHDFHRLIUV|UHDRAWI
            }
            return RedirectToAction("Index", "Home");
        }

        [Authorize]
        public ActionResult Share(int id = 0)
        {
            if (id != 0)
            {
                ShareEventViewModel sevm = new ShareEventViewModel();
                sevm.EventID = id;
                int profId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId;
                sevm.SharerID = profId;
                sevm.FriendList = accountServices.GetAllFriends(new GetFriendsModel
                {
                    UserProfileId = profId
                });
                sevm.SharedUserProfileIDList = "";
                return View(sevm);
            }

            return RedirectToAction("Index", "Home"); //error ito dapat
        }

        [HttpPost]
        public ActionResult Share(ShareEventViewModel model)
        {
            string[] userProfileIDstring = model.SharedUserProfileIDList.Split(',');
            HashSet<int> userProfileIDs = new HashSet<int>();

            foreach(String s in userProfileIDstring){
                if(!s.Equals(""))
                    userProfileIDs.Add(Int32.Parse(s));
            }

            List<int> userIDs = new List<int>();

            foreach(int i in userProfileIDs){
                userIDs.Add(accountServices.GetUserByUserProfileId(i).UserId);
            }


            eventServices.Share(new ShareEventModel
            {
                EventID = model.EventID,
                Message = model.Message,
                SharerProfileId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId,
                SharedProfileIDList = userIDs
            });

            return RedirectToAction("Index", new { id = model.EventID });
        }


        public ActionResult UploadMedia(int id=0)
        {
            return View(new UploadViewModel
            {
                EventID = id
            });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UploadMedia(HttpPostedFileBase uploadFile, UploadViewModel model)
        {
            

            if (uploadFile.ContentLength > 0 && uploadFile.ContentType.Contains("image"))
            {
                byte[] randomArray = new byte[50];
                new Random().NextBytes(randomArray);

                String fileName = model.EventID + "_";

                foreach (byte b in randomArray)
                {
                    fileName += b;
                }

                uploadFile.SaveAs(Server.MapPath("../../Uploads/Images/"+fileName));

                MediaServices.GetInstance().CreateMediaItem(new CreateMediaItemModel
                {
                    EventId = model.EventID,
                    FileName = fileName,
                    FilePath = Server.MapPath("../../Uploads/Images/")
                });
            }
            return View(model);
        }

    }

}
