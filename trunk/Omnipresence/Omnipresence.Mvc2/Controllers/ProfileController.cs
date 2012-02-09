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
        public const int NUM_FRIENDS = 10;
        public const int NUM_EVENTS = 10;
        private AccountServices accountServices;

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            base.Initialize(requestContext);
            accountServices = AccountServices.GetInstance();
        }

        public ActionResult Index()
        {
            if (User.Identity.Name == "") return RedirectToAction("Index", "Home");
            ProfileViewModel profile = GetProfileViewModel(User.Identity.Name);
            if (profile == null) return RedirectToAction("Index", "Home");
            return RedirectToAction("Profile", new { id = profile.Username });
        }

        // id here is username
        public ActionResult Profile(string id = "")
        {
            if (id == "") return RedirectToAction("Index", "Home");
            ProfileViewModel model = GetProfileViewModel(id);
            if (model == null) return RedirectToAction("Index", "Home");
            return View(model);
        }

        public ActionResult ProfileById(int id = 0)
        {
            if (id == 0) return RedirectToAction("Index", "Home");
            UserModel temp = accountServices.GetUserByUserProfileId(id);
            return RedirectToAction("Profile", new { id = temp.Username });
        }

        private ProfileViewModel GetProfileViewModel(string username)
        {
            UserProfileModel profile = accountServices.GetUserProfileByUsername(username);
            if (profile == null) return null;

            ProfileViewModel model = new ProfileViewModel
            {
                AvatarUrl = profile.Avatar,
                Birthdate = profile.Birthdate,
                Description = profile.Description,
                FirstName = profile.FirstName,
                GenderText = profile.IsFemale ? "Female" : "Male",
                LastName = profile.LastName,
                Reputation = profile.Reputation,
                UserProfileId = profile.UserProfileId
            };

            model.Friends = accountServices.GetFriendsList(profile.UserProfileId, NUM_FRIENDS);
            model.UserEvents = EventServices.GetInstance().GetAllEventsByUserProfileId(profile.UserProfileId).Take(NUM_EVENTS);
            UserModel temp = accountServices.GetUserByUsername(username);
            model.Username = username;
            model.UserId = temp.UserId;

            model.ViewingFriend = accountServices.AreFriends(User.Identity.Name, username);
            model.ViewingOwn = User.Identity.Name == username;

            int numFriends = accountServices.GetAllFriends(new GetFriendsModel { UserProfileId = profile.UserProfileId }).Count();

            model.Sidebar = new ProfileSidebarViewModel { AvatarUrl = profile.Avatar, FriendCount = numFriends, Name = profile.FirstName + " " + profile.LastName, Reputation = profile.Reputation, Username = username };

            model.ThisDudeHasSentAFriendRequestToYou = (User.Identity.Name == "") ? false : accountServices.HasPendingFriendRequest(username, User.Identity.Name);
            model.FriendRequested = (User.Identity.Name == "") ? false : accountServices.HasPendingFriendRequest(User.Identity.Name, username);
            return model;
        }



        //
        // GET: /Profile/Edit/5

        public ActionResult Edit()
        {
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

            SetViewDataForDate(ViewData);

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


        [Authorize]
        public ActionResult ChangeDisplayPicture(int id = 0)
        {
            return View(new ChangeDisplayPictureModel
            {
                UserProfileID = id
            });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangeDisplayPicture(HttpPostedFileBase uploadFile, ChangeDisplayPictureModel model)
        {
            if (uploadFile == null) return View(model);

            if (uploadFile.ContentLength > 0 && uploadFile.ContentType.Contains("image"))
            {

                String fileName = model.UserProfileID + "_dp";


                uploadFile.SaveAs(Server.MapPath("../../Uploads/Display/" + fileName));

                accountServices.UpdateAvatar(new UpdateAvatarModel
                {
                    UserProfileID = model.UserProfileID,
                    FileName = fileName,
                    FilePath = "../../Uploads/Display/"
                });

                return RedirectToAction("Index");
            }
            return View(model);
        }

        public static void SetViewDataForTime(ViewDataDictionary ViewData)
        {
            int[] hourA = new int[12];
            for (int i = 1; i <= 12; i++)
            {
                hourA[i - 1] = i;
            }
            ViewData["hours"] = new SelectList(hourA);

            string[] minuteA = new string[60];
            for (int i = 0; i < 60; i++)
            {
                minuteA[i] = i.ToString("00");
            }
            ViewData["minutes"] = new SelectList(minuteA);

            List<string> ampmList = new List<string>();
            ampmList.Add("AM");
            ampmList.Add("PM");
            ViewData["ampm"] = new SelectList(ampmList);
        }

        public static void SetViewDataForDate(ViewDataDictionary ViewData)
        {
            List<string> genderList = new List<string>();
            genderList.Add("Male");
            genderList.Add("Female");
            SelectList list = new SelectList(genderList);
            ViewData["gender"] = list;

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


        }
    }
}
