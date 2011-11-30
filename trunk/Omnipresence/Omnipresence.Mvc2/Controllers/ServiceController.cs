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
                return Json(null);
            }
        }
    }
}
