using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    public class ProfileController : Controller
    {
        private AccountServices accountServices;

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            base.Initialize(requestContext);
            accountServices = AccountServices.GetInstance();
        }
        public ProfileViewModel GetProfile(int id)
        {
            // TODO: This is still empty model
            ProfileViewModel model = new ProfileViewModel { AvatarUrl = "viewprofile.png", Birthdate = DateTime.Now, Description = "Super bad-ass", FirstName = "Adrian", GenderText = "Male", LastName = "Fazinsky", Reputation = 10 };
            return model;
        }

        public ActionResult Index(int id = 0)
        {
            //TODO: Actual model
            if (id == 0)
            {
                UserProfileModel profile = accountServices.GetUserProfileByUsername(User.Identity.Name);
                if (profile == null) return RedirectToAction("Index", "Home");
                return View(profile);
            }
            else
            {
                UserProfileModel profile = accountServices.GetUserProfileById(id);
                if (profile != null) return View(profile);
                else return RedirectToAction("Index", "Home");
            }
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
