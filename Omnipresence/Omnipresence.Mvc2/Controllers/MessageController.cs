using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;
using Omnipresence.Mvc2.Models;

namespace Omnipresence.Mvc2.Controllers
{
    public class MessageController : Controller
    {
        //
        // GET: /Message/
        private AccountServices accountServices;
        private EventServices eventServices;

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            eventServices = EventServices.GetInstance();
            accountServices = AccountServices.GetInstance();
            base.Initialize(requestContext);
        }

        [Authorize]
        public ActionResult Index(int id=0)
        {

            if (id == 0) //meaning list all messages
            {
                IQueryable<MessageModel> list = eventServices.GetMessages(new GetMessagesModel
                {
                    UserProfileID = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId,
                    GetUnreadOnly = false
                });

                List<MessageViewModel> returnValue = new List<MessageViewModel>();

                foreach (MessageModel mm in list)
                {
                    UserProfileModel sender = accountServices.GetUserProfileByUserProfileId(mm.SenderProfileID);

                    returnValue.Add(new MessageViewModel
                    {
                        EventID = mm.EventID!=null?(int)mm.EventID:-1,
                        EventName = eventServices.GetEventById(mm.EventID != null ? (int)mm.EventID : -1).Title,
                        Message = mm.Message,
                        MessageID = mm.MessageID,
                        SenderName = sender.FirstName + " " + sender.LastName,
                        SenderProfileID = mm.SenderProfileID
                    });
                }

                return View(returnValue.AsQueryable());
            }

            return null;
        }

        [Authorize]
        public ActionResult Send(int replyToProfileId = -1)
        {
            ShareEventViewModel sevm = new ShareEventViewModel();
            sevm.EventID = -1;
            int profId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId;
            sevm.SharerID = profId;
            sevm.FriendList = accountServices.GetAllFriends(new GetFriendsModel
            {
                UserProfileId = profId
            });
            sevm.SharedUserProfileIDList = "";

            UserProfileModel friend = accountServices.GetUserProfileByUserProfileId(replyToProfileId);

            if(friend!=null){
                sevm.SharedUserProfileIDList += ""+ friend.UserProfileId;
                sevm.SharedIDList += (friend.FirstName + " " + friend.LastName);
            }

            return View(sevm);
        }

    }
}
