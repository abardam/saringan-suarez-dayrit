using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Omnipresence.Mvc2.Controllers
{
    public class EventController : Controller
    {
        //
        // GET: /Event/

        public ActionResult Index()
        {
            return View();
        }

        //public PartialViewResult NewEvent()
        //{
        //    return PartialView("/Sidebar/NewEventUserControl");
        //}
    }
}
