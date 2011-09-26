using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;

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
        public ActionResult NewEvent()
        {
            return PartialView();
        }
        [HttpPost]
        public ActionResult NewEvent(NewEventModel model)
        {
            // TODO: insert latlng logic
            return PartialView("NewEvent",model);
        }
    }
}
