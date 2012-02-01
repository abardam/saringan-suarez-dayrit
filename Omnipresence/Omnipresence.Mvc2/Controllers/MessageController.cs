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
                        EventID = mm.EventID,
                        EventName = eventServices.GetEventById(mm.EventID).Title,
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

    }
}
