using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;
using Omnipresence.DataAccess.Core; // TODO: REMOVE ACCESS TO THIS

namespace Omnipresence.Mvc2.Controllers
{
    public class SidebarController : Controller
    {
        private AccountServices accountServices;
        public IFormsAuthenticationService FormsService { get; set; }
        //public IMembershipService MembershipService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            //if (MembershipService == null) { MembershipService = new AccountMembershipService(); }
            accountServices = new AccountServices();

            base.Initialize(requestContext);
        }

        public ActionResult Index()
        {
            //TODO: Actual model
            IndexViewModel vm = new IndexViewModel();
            return PartialView("IndexUserControl",vm);
        }
        public ActionResult Profile(int id)
        {
            //TODO: Actual model
            ProfileModel model = new ProfileModel { AvatarUrl = "/Content/Images/viewprofile.png", Birthdate = DateTime.Now, Description = "Super bad-ass", FirstName = "Adrian", GenderText = "Male", LastName = "Fazinsky", Reputation = 10, Timezone = 0 };
            return PartialView("ProfileUserControl", model);
        }
        // TODO: CHANGE EVENT OBJECT TYPE IN EVENTSERVICES
        public ActionResult NewEvent()
        {
            return PartialView("NewEventUserControl");
        }
        [HttpPost]
        public ActionResult NewEvent(NewEventModel model)
        {
            // TODO: insert latlng logic
            return PartialView("NewEventUserControl",model);
        }
        public ActionResult EditEvent(int id)
        {
            // TODO: insert logic
            EditEventModel model = new EditEventModel{ CreatedBy = 1, CreateTime = DateTime.Now, DeleteTime = DateTime.Now, Description = "Description", Duration = 10, EndTime = DateTime.Now, Name= "Name", StartTime = DateTime.Now};
            return PartialView("EditEvent", model);
        }
        [HttpPost]
        public ActionResult EditEvent(EditEventModel model)
        {
            // TODO: insert logic
            return PartialView("EditEvent", model);
        }
        public ActionResult Login()
        {
            return PartialView("LoginUserControl");
        }
        [HttpPost]
        public ActionResult Login(LogOnModel model)
        {
            if (ModelState.IsValid)
            {
                if (accountServices.ValidateUser(model.UserName, model.Password))
                {
                    FormsService.SignIn(model.UserName, model.RememberMe);

                    return RedirectToAction("Index","Home");
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }
            }

            return PartialView("LoginUserControl",model);
        }
        public ActionResult Register()
        {
            ViewData["PasswordLength"] = 6;
            return PartialView("RegisterUserControl");
        }
        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (AddUser(model)) return RedirectToAction("Index", "Home");

            ViewData["PasswordLength"] = 6;
            return PartialView("RegisterUserControl",model);
        }
        //TODO: Transfer this to services
        public bool AddUser(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                User user = accountServices.CreateUser(model.UserName.Trim(), model.Password.Trim(), model.Email.Trim(), model.FirstName.Trim(), model.LastName.Trim(), model.Birthdate);

                if (user != null)
                {
                    accountServices.AddUser(user);
                    FormsService.SignIn(user.Username, false);
                    return true;
                }
                else
                {
                    ModelState.AddModelError("", AccountValidation.ErrorCodeToString(MembershipCreateStatus.UserRejected));
                }
            }
            return false;
        }
        public ActionResult LogOff()
        {
            FormsService.SignOut();
            return RedirectToAction("Index","Home");
        }
        public ActionResult Search()
        {
            SearchEventModel model = new SearchEventModel();
            return PartialView("SearchUserControl", model);
        }
    }
}
