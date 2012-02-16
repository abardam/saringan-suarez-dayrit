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
        private static int MESSAGE_PREVIEW_LENGTH = 20;

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            eventServices = EventServices.GetInstance();
            accountServices = AccountServices.GetInstance();
            base.Initialize(requestContext);
        }

        [Authorize]
        public ActionResult Index()
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

                MessageViewModel mvm = new MessageViewModel
                {
                    EventID = mm.EventID != null ? (int)mm.EventID : -1,
                    
                    Message = mm.Message,
                    MessageID = mm.MessageID,
                    SenderName = sender.FirstName + " " + sender.LastName,
                    SenderProfileID = mm.SenderProfileID,
                    Read = mm.Read
                };

                if (mvm.Message.Length > MESSAGE_PREVIEW_LENGTH)
                {
                    mvm.Message = mvm.Message.Substring(0, MESSAGE_PREVIEW_LENGTH) + "...";
                }

                EventModel em = eventServices.GetEventById(mm.EventID != null ? (int)mm.EventID : -1);

                if (em != null)
                {
                    mvm.EventName = em.Title;
                }

                returnValue.Add(mvm);

                
            }

            return View(returnValue.AsQueryable());
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

            if (friend != null)
            {
                sevm.SharedUserProfileIDList += "" + friend.UserProfileId;
                sevm.SharedIDList += (friend.FirstName + " " + friend.LastName);
            }

            return View(sevm);
        }

        [HttpPost]
        public ActionResult Send(ShareEventViewModel model)
        {
            string[] userProfileIDstring = model.SharedUserProfileIDList.Split(',');
            HashSet<int> userProfileIDs = new HashSet<int>();

            foreach (String s in userProfileIDstring)
            {
                if (!s.Equals(""))
                    userProfileIDs.Add(Int32.Parse(s));
            }

            List<int> userIDs = new List<int>();

            foreach (int i in userProfileIDs)
            {
                userIDs.Add(accountServices.GetUserByUserProfileId(i).UserId);
            }


            eventServices.Share(new ShareEventModel
            {
                EventID = model.EventID,
                Message = model.Message,
                SharerProfileId = accountServices.GetUserProfileByUsername(User.Identity.Name).UserProfileId,
                SharedProfileIDList = userIDs
            });

            return RedirectToAction("Index");
        }


        [Authorize]
        public ActionResult ViewMessage(String id = "00000000-0000-0000-0000-000000000000")
        {
            
            MessageModel mm = eventServices.GetMessage(new GetMessageModel
            {
                MessageID = new Guid(id)
            });
            UserProfileModel sender = accountServices.GetUserProfileByUserProfileId(mm.SenderProfileID);
            MessageViewModel mvm = new MessageViewModel
            {
                EventID = mm.EventID != null ? (int)mm.EventID : -1,

                Message = mm.Message,
                MessageID = mm.MessageID,
                SenderName = sender.FirstName + " " + sender.LastName,
                SenderProfileID = mm.SenderProfileID
            };

            EventModel em = eventServices.GetEventById(mm.EventID != null ? (int)mm.EventID : -1);

            if (em != null)
            {
                mvm.EventName = em.Title;
            }

            try
            {
                eventServices.MarkAsRead(mm.MessageID, true);
            }
            catch (Exception e)
            {
                //temp
            }

            return View(mvm);
        }


    }
}
