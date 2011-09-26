using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
// TODO: MODIFY THIS WHEN PROCESSING ALREADY IMPLEMENTS USERACCOUNTMODEL
using Omnipresence.Processing;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Mvc2.Controllers
{
    public class SidebarController : Controller
    {
        public ActionResult Index()
        {
            //TODO: Actual model
            IndexViewModel vm = new IndexViewModel();
            return PartialView("IndexUserControl",vm);
        }
        public ActionResult Profile(int id)
        {
            //TODO: Actual model
            ProfileModel model;
            using (ProfileController x = new ProfileController())
            {
                model = x.GetProfile(id);
            }
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
            return RedirectToAction("LogOn", "Account", model);
        }
        public ActionResult Register()
        {
            ViewData["PasswordLength"] = 6;
            return PartialView("RegisterUserControl");
        }
        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            AccountController x = new AccountController();
            if (x.AddUser(model)) return RedirectToAction("Index", "Home");

            ViewData["PasswordLength"] = 6;
            return PartialView("RegisterUserControl", model);
        }
    }
}
