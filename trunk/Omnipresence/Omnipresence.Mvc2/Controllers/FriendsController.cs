using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    public class FriendsController : Controller
    {
        private AccountServices accountServices = AccountServices.GetInstance();
        public ActionResult Index()
        {
            return View(accountServices.GetAllFriends(new GetFriendsModel
            {
                UserProfileId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId
            }));
        }

        public ActionResult Add(int id)
        {
            //this bit of code confirms the friend request, if the other dude has sent one.
            int viewerId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId;

            GetFriendRequestsModel gfrm1 = new GetFriendRequestsModel { UserProfileId = viewerId };

            IQueryable<UserProfileModel> lupm1 = accountServices.GetFriendRequests(gfrm1);

            foreach (UserProfileModel upm in lupm1)
            {
                if (upm.UserProfileId == id)
                {
                    //added!
                    accountServices.ConfirmFriendRequest(new Processing.FriendRequestModel { AdderUserProfileId = id, AddedUserProfileId = viewerId });
                    return Redirect("/Profile/Index/"+id);
                }
            }


            //otherwise gagawa siya ng bagong friend request
            CreateFriendRequestModel cfrm = new CreateFriendRequestModel();
            cfrm.AdderUserProfileId = accountServices.GetUserByUsername(User.Identity.Name).UserId;
            cfrm.AddedUserProfileId = id;

            accountServices.CreateFriendRequest(cfrm);

            return Redirect("/Profile/Index/"+id);
        }

        public ActionResult Delete()
        {
            return View();
        }
    }
}
