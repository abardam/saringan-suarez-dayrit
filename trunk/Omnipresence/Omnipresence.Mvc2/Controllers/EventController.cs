using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    public class EventController : Controller
    {
        //
        // GET: /Event/

        private EventServices eventServices;
        
        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            eventServices = EventServices.GetInstance();
            base.Initialize(requestContext);
        }
        [Authorize]
        public ActionResult Index(int id = 0)
        {
            EventModel model = eventServices.GetEventById(id);
            if (model == null) return RedirectToAction("Index", "Home");
            return View(model);
        }

    }
    
}
