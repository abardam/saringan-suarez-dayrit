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
        public ProfileModel GetProfile(int id)
        {
            // TODO: This is still empty model
            ProfileModel model = new ProfileModel{ AvatarUrl="", Birthdate=DateTime.Now, Description="Description", FirstName="First Name", GenderText="Gender", LastName="LastName", Reputation=10, Timezone=0 };
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
