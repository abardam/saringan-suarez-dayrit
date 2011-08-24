using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewData["Message"] = "World Map";

            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        [HttpPost]
        public ActionResult About(string comm, int markerNum)
        {
            return null;
        }

        [HttpPost]
        public ActionResult Query(EventQueryModel model)
        {
            if (ModelState.IsValid)
            {
                IEnumerable<EventViewModelMicro> displayModels;
                using (EventServices service = new EventServices()) {
                    displayModels = service.EventQuery(model);
                }
                return Json(displayModels);
            }
            else
            {
                string errorMessage = "<div class=\"validation-summary-errors\">The following errors occurred:<ul>";
                foreach (var key in ModelState.Keys)
                {
                    var error = ModelState[key].Errors.FirstOrDefault();
                    if (error != null)
                    {
                        errorMessage += "<li class=\"field-validation-error\">" + error.ErrorMessage + "</li>";
                    }
                }
                errorMessage += "</ul>";
                return Json(new PersonViewModel { Message = errorMessage });
            }
        }
    }
}
