using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Controllers
{
    public class CommentController : Controller
    {
        //
        // GET: /Comment/

        CommentServices commentServices = CommentServices.GetInstance();

        public ActionResult Index()
        {
            return View();
        }

        [Authorize]
        public ActionResult Delete(int id)
        {

            CommentModel cm = commentServices.GetCommentById(id);

            if (AccountServices.GetInstance().GetUserByUsername(User.Identity.Name).UserProfile.UserProfileId == cm.UserProfileId)
            {
                commentServices.DeleteComment(new DeleteCommentModel
                {
                    CommentId = id
                });
            }

            return RedirectToAction("Index", "Event", new { id = cm.EventId });
        }

    }
}
