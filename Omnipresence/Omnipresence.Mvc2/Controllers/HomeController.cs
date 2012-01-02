using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;
using Omnipresence.Mvc2.Models;

namespace Omnipresence.Mvc2.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        private EventServices eventService;
        private AccountServices accountServices = AccountServices.GetInstance();
        private EventServices getEventService()
        {
            if (eventService == null) eventService = EventServices.GetInstance();
            return eventService;
        }
        private AccountServices accountService;
        private AccountServices getAccountService()
        {
            if (accountService == null) accountService = AccountServices.GetInstance();
            return accountService;
        }

        public ActionResult Index()
        {
            IEnumerable<EventModel> events = getEventService().GetAllEvents().Reverse().Take(10);
            UserProfileModel profile = getAccountService().GetUserProfileByUsername(User.Identity.Name);
            NotificationsShortList notifications = profile != null ? new NotificationsShortList{ FriendRequests = accountService.GetFriendRequests(new GetFriendRequestsModel{ UserProfileId = profile.UserProfileId}).Count() } : null;
            if (profile == null) profile = new UserProfileModel { Avatar = "", FirstName = "", LastName = "" };
            IndexSidebarViewModel sidebar = new IndexSidebarViewModel { AvatarUrl = profile.Avatar, Name = profile.FirstName + " " + profile.LastName, Notifications = notifications, Username = User.Identity.Name };
            return View(new IndexViewModel { DisplayName = sidebar.Name, Events = events, Sidebar = sidebar });
        }
        public ActionResult About()
        {
            return View();
        }

        [Authorize]
        public ActionResult Notifications(string message = "")
        {
            UserProfileModel user = getAccountService().GetUserProfileByUsername(User.Identity.Name);
            if (user == null) return RedirectToAction("Index", "Home");
            IEnumerable<UserProfileModel> pendingRequests = getAccountService().GetFriendRequests(new GetFriendRequestsModel { UserProfileId = user.UserProfileId });

            return View(new NotificationsViewModel { PendingFriendRequests = pendingRequests, Message = message });
        }

        public ActionResult Search()
        {
            SearchResultModel model = new SearchResultModel();
            model.SearchString = "";
            return View(model);
        }

        [HttpPost]
        public ActionResult Search(SearchResultModel model)
        {
            UserProfileModel upm = accountServices.GetUserProfileByUsername(model.SearchString);

            SearchResultModel srm = new SearchResultModel();
            srm.UserResult = new List<ProfileViewModel>();
            if (upm != null)
            {
                ProfileViewModel pm = new ProfileViewModel();
                pm.FirstName = upm.FirstName;
                pm.LastName = upm.LastName;
                pm.UserId = accountServices.GetUserByUsername(model.SearchString).UserId;
                pm.UserProfileId = upm.UserProfileId;
                pm.Username = getAccountService().GetUserByUserProfileId(upm.UserProfileId).Username;
                srm.UserResult.Add(pm);
            }
            //for now just searches for a user profile
            return View(srm);
        }
        /*
        [HttpPost]
        public ActionResult About(string comm, int markerNum)
        {
            return null;
        }
        */

        //[HttpPost]
        //public ActionResult Query(EventQueryModel model)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        IEnumerable<EventViewModelMicro> displayModels;
        //        using (EventServices service = new EventServices()) {
        //            displayModels = service.EventQuery(model);
        //        }
        //        return Json(displayModels);
        //    }
        //    else
        //    {
        //        string errorMessage = "<div class=\"validation-summary-errors\">The following errors occurred:<ul>";
        //        foreach (var key in ModelState.Keys)
        //        {
        //            var error = ModelState[key].Errors.FirstOrDefault();
        //            if (error != null)
        //            {
        //                errorMessage += "<li class=\"field-validation-error\">" + error.ErrorMessage + "</li>";
        //            }
        //        }
        //        errorMessage += "</ul>";
        //        //return Json(new PersonViewModel { Message = errorMessage });
        //        return null;
        //    }
        //}
    }
}
