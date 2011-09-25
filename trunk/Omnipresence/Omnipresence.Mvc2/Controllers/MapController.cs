using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    public class MapController : Controller
    {
        private EventServices eventServices;

        protected override void Initialize(RequestContext requestContext)
        {
            eventServices = new EventServices();
            base.Initialize(requestContext);
        }

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetEvents(string title, string description, DateTime startTime, DateTime endTime, string visibilityTypeString, string locationName, double latitude, double longitude)
        {
            return Json(eventServices.QueryEvents(title, description, startTime, endTime, visibilityTypeString, locationName, latitude, longitude));
        }
    }
}
