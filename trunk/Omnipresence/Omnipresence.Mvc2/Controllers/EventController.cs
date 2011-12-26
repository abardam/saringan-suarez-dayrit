using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;
using System.Data;

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

            IEnumerable<CommentModel> tempie = commentServices.GetAllCommentsByEventId(model.EventId);
            List<CommentViewModel> commentList = new List<CommentViewModel>();

            DateTime now = DateTime.Now;

            int userProfileId = accountServices.GetUserByUsername(User.Identity.Name).UserProfile.UserProfileId;

            foreach(CommentModel cm in tempie){
                UserProfileModel upm = accountServices.GetUserProfileById(cm.UserProfileId);
                
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
                        if (now.Hour == cm.Timestamp.Hour)
                        {
                            cvm.TimeString = (now.Minute - cm.Timestamp.Minute) + " minutes ago";
                        }
                        else if (now.Hour == cm.Timestamp.Hour + 1 && (now.Minute + 60 - cm.Timestamp.Minute) < 60)
                        {
                            cvm.TimeString = (now.Minute + 60 - cm.Timestamp.Minute) + " minutes ago";
                        }
                        else
                        {
                            cvm.TimeString = cm.Timestamp.ToShortTimeString();
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
            CreateEventViewModel model = new CreateEventViewModel();
            model.Title = "";
            model.CreateTime = DateTime.Now;
            model.DeleteTime = DateTime.Now;
            model.StartTime = DateTime.Now;
            model.EndTime = DateTime.Now;
            return View(model);
        }

        [HttpPost]
        public ActionResult New(CreateEventViewModel model)
        {
            CreateEventModel cem = new CreateEventModel();
            cem.Address = model.Address;
            cem.CategoryString = model.CategoryString;
            cem.Description = model.Description;
            cem.EndTime = model.EndTime;
            cem.Latitude = model.Latitude;
            cem.Longitude = model.Longitude;
            cem.StartTime = model.StartTime;
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

                return View(model);
            }
            return Redirect("/");
        }

        public ActionResult Edit(int id)
        {
            EventModel em = eventServices.GetEventById(id);

            return View(em);
        }

    }
    
}
