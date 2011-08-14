using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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

        public ActionResult Profile()
        {
            ViewData["Name"] = "Emanuel Saringan";

            return View();
        }

        public ActionResult Friends()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}
