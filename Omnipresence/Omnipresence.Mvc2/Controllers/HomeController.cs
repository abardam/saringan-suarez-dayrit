using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;
using Omnipresence.DataAccess;
using Omnipresence.Mvc2.Models;

namespace Omnipresence.Mvc2.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        private EventServices service;
        private AccountServices accountServices = AccountServices.GetInstance();
        private EventServices getEventService()
        {
            if (service == null) service = EventServices.GetInstance();
            return service;
        }

        public ActionResult Index()
        {
            IEnumerable<EventModel> events = getEventService().GetAllEvents().Reverse().Take(10);
            return View(events);
        }
        public ActionResult About()
        {
            return View();
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
