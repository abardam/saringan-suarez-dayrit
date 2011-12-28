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

        public ActionResult Index(int id = 0)
        {
            UserProfileModel profile;
            //TODO: Actual model
            if (id == 0)
            {
                profile = accountServices.GetUserProfileByUsername(User.Identity.Name);
                
            }
            else
            {
                profile = accountServices.GetUserProfileById(id);
            }
            
            if (profile == null) return RedirectToAction("Index", "Home");

            
            ProfileViewModel pvm = new ProfileViewModel
            {
                Birthdate = profile.Birthdate,
                Description = profile.Description,
                FirstName = profile.FirstName,
                GenderText = profile.IsFemale ? "Female" : "Male",
                LastName = profile.LastName,
                Reputation = profile.Reputation,
                ViewingOwn = false,
                ViewingFriend = false,
                UserProfileId = id,
                FriendRequested = false,
                ThisDudeHasSentAFriendRequestToYou = false
            };

            if (!User.Identity.Name.Equals(""))
            {
                int viewerId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId;

                pvm.ViewingOwn = id == 0 || id.Equals(viewerId);


                if (!pvm.ViewingOwn)
                {
                    IEnumerable<UserProfileModel> lupm = accountServices.GetAcceptedFriends(new GetFriendsModel { UserProfileId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId });

                    foreach (UserProfileModel upm in lupm)
                    {
                        if (upm.UserProfileId == profile.UserProfileId)
                        {
                            pvm.ViewingFriend = true;
                            break;
                        }
                    }
                    if (!pvm.ViewingFriend)
                    {
                        GetFriendRequestsModel gfrm1 = new GetFriendRequestsModel { UserProfileId = viewerId };

                        IQueryable<UserProfileModel> lupm1 = accountServices.GetFriendRequests(gfrm1);

                        foreach (UserProfileModel upm in lupm1)
                        {
                            if (upm.UserProfileId == profile.UserProfileId)
                            {
                                pvm.ThisDudeHasSentAFriendRequestToYou = true;
                                break;
                            }
                        }

                        if (!pvm.ThisDudeHasSentAFriendRequestToYou)
                        {
                            GetFriendRequestsModel gfrm = new GetFriendRequestsModel();
                            gfrm.UserProfileId = profile.UserProfileId;
                            IQueryable<UserProfileModel> lupm2 = accountServices.GetFriendRequests(gfrm);

                            foreach (UserProfileModel upm in lupm2)
                            {
                                if (upm.UserProfileId == viewerId)
                                {
                                    pvm.FriendRequested = true;
                                    break;
                                }
                            }
                        }
                    }
                }
            }

            


            return View(pvm);
        }

        //
        // GET: /Profile/Edit/5

        public ActionResult Edit()
        {
            List<string> genderList = new List<string>();
            genderList.Add("Male");
            genderList.Add("Female");
            SelectList list = new SelectList(genderList);
            ViewData["gender"] = list;

            string username = User.Identity.Name;
            UserProfileModel up = accountServices.GetUserProfileByUsername(username);
            EditProfileViewModel u = new EditProfileViewModel();
            u.Description = up.Description;
            u.FirstName = up.FirstName;
            u.LastName = up.LastName;
            u.GenderText = up.IsFemale ? "Female" : "Male";
            u.Reputation = up.Reputation;
            u.BirthdateDay = up.Birthdate.Day;
            u.BirthdateMonth = up.Birthdate.ToString("MMMM");
            u.BirthdateYear = up.Birthdate.Year;


            int[] dayA = new int[31];

            for (int i = 0; i < 31; i++)
            {
                dayA[i] = i + 1;
            }

            int[] yearA = new int[100];

            for (int i = 0; i < 100; i++)
            {
                yearA[i] = DateTime.Now.Year - i;
            }

            SelectList daySL = new SelectList(dayA);
            ViewData["days"] = daySL;

            SelectList yearSL = new SelectList(yearA);
            ViewData["years"] = yearSL;

            return View(u);
        }

        [HttpPost]
        public ActionResult Edit(EditProfileViewModel model)
        {
            if (!ModelState.IsValid)
            {
                //do some stuff here
                ViewData["Message"] = "Edit profile unsuccessful";
                return Edit();
            }

            String username = User.Identity.Name;
            UserProfileModel p = accountServices.GetUserProfileByUsername(username);
            p.Birthdate = model.Birthdate;
            p.Description = model.Description;

            if (p.Description == null) { p.Description = ""; }

            p.LastName = model.LastName;
            p.FirstName = model.FirstName;
            p.IsFemale = model.GenderText.Equals("Female");

            DateTime newDT = DateTime.Parse(model.BirthdateMonth + "/" + model.BirthdateDay + "/" + model.BirthdateYear);

            p.Birthdate = newDT;
            //return PartialView("ProfileUserControl", model);
            if (accountServices.UpdateUserProfile(p))
            {
                ViewData["Message"] = "Edit profile successful";
            }
            else
            {
                ViewData["Message"] = "Edit profile unsuccessful";
            }
            return Edit();
        }



        //
        // POST: /Profile/Edit/5
        /*
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
        }*/
    }
}
