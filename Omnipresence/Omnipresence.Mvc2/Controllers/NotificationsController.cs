using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;
using Omnipresence.Mvc2.Models;

namespace Omnipresence.Mvc2.Controllers
{
    public class NotificationsController : Controller
    {
        private AccountServices accountServices = AccountServices.GetInstance();
        //
        // GET: /Notification/

        public ActionResult Index()
        {
            GetFriendRequestsModel gfrm = new GetFriendRequestsModel();
            gfrm.UserProfileId = accountServices.GetUserByUsername(User.Identity.Name).UserId;
            IQueryable<UserProfileModel> iq = accountServices.GetFriendRequests(gfrm);
            NotificationModel nm = new NotificationModel();
            nm.FriendRequestNotifications = new List<FriendRequestViewModel>();
            List<UserProfileModel> lupm = iq.ToList<UserProfileModel>();
            foreach (UserProfileModel upm in lupm)
            {
                FriendRequestViewModel frm = new FriendRequestViewModel();
                frm.UserProfileId = upm.UserProfileId;
                frm.FullName = upm.FirstName + " " + upm.LastName;
                nm.FriendRequestNotifications.Add(frm);
            }

            IQueryable<MessageModel> messageList = EventServices.GetInstance().GetMessages(new GetMessagesModel
            {
                GetUnreadOnly = true,
                UserProfileID = gfrm.UserProfileId
            });

            List<MessageViewModel> messageViewList = new List<MessageViewModel>();

            foreach (MessageModel mm in messageList)
            {
                UserProfileModel sender = accountServices.GetUserProfileByUserProfileId(mm.SenderProfileID);

                messageViewList.Add(new MessageViewModel
                {
                    EventID = mm.EventID,
                    EventName = EventServices.GetInstance().GetEventById(mm.EventID).Title,
                    Message = mm.Message,
                    MessageID = mm.MessageID,
                    SenderName = sender.FirstName + " " + sender.LastName,
                    SenderProfileID = mm.SenderProfileID
                });
            }

            nm.UnreadMessages = messageViewList;

            return View(nm);
        }

    }
}
