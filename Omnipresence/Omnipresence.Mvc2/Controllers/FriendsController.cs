using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;
using Omnipresence.Mvc2.Models;

namespace Omnipresence.Mvc2.Controllers
{
    public class FriendsController : Controller
    {
        private AccountServices accountServices = AccountServices.GetInstance();

        [Authorize]
        public ActionResult Index()
        {
            return RedirectToAction("Friends", new { id = User.Identity.Name });
        }
        public ActionResult Friends(string id = "")
        {
            if (id.Equals(""))
            {
                id = User.Identity.Name;
            }

            AccountServices db = AccountServices.GetInstance();
            UserProfileModel profile = db.GetUserProfileByUsername(id);
            if (profile == null) return RedirectToAction("Index", "Home");
            IEnumerable<ProfileIdModel> friends = db.GetFriendsList(profile.UserProfileId);
            return View(new FriendsViewModel { Friends = friends, Username = id });
        }
        [Authorize]
        public ActionResult Add(int id)
        {
            UserModel user = accountServices.GetUserByUsername(User.Identity.Name);
            bool success = accountServices.CreateFriendRequest(new CreateFriendRequestModel
            {
                AddedUserProfileId = id,
                AdderUserProfileId = user.UserProfile.UserProfileId
            });
            return RedirectToAction("Profile", "Profile", new { id = id }); ;
        }

        [Authorize]
        public ActionResult Accept(int id = 0)
        {
            if (id == 0) RedirectToAction("Index", "Home");
            AccountServices db = AccountServices.GetInstance();
            int thisuser = db.GetUserProfileByUsername(User.Identity.Name).UserProfileId;

            if (!db.ConfirmFriendRequest(new FriendRequestModel { AddedUserProfileId = thisuser, AdderUserProfileId = id }))
            {
                return RedirectToAction("Notifications", "Home", new { message = "An error occurred." });
            }
            return RedirectToAction("Notifications", "Home", new { message = "Friend request confirmed." });
        }
        [Authorize]
        public ActionResult Decline(int id = 0)
        {

            if (id == 0) RedirectToAction("Index", "Home");
            AccountServices db = AccountServices.GetInstance();
            int thisuser = db.GetUserProfileByUsername(User.Identity.Name).UserProfileId;

            if (!db.DenyFriendRequest(new FriendRequestModel { AddedUserProfileId = thisuser, AdderUserProfileId = id }))
            {
                return RedirectToAction("Notifications", "Home", new { message = "An error occurred." });
            }
            return RedirectToAction("Notifications", "Home", new { message = "Friend request deleted." });
        }
    }
}
