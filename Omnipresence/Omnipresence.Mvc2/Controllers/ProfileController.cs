using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;

namespace Omnipresence.Mvc2.Controllers
{
    public class ProfileController : Controller
    {
        public ProfileViewModel GetProfile(int id)
        {
            // TODO: This is still empty model
            ProfileViewModel model = new ProfileViewModel { AvatarUrl = "viewprofile.png", Birthdate = DateTime.Now, Description = "Super bad-ass", FirstName = "Adrian", GenderText = "Male", LastName = "Fazinsky", Reputation = 10 };
            return model;
        }
        public ActionResult Index()
        {
            ViewData["Name"] = User.Identity.Name;

            return View();
        }

        //
        // GET: /Profile/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Profile/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
