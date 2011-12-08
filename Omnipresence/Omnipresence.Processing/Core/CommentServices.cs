using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class CommentServices : IDisposable
    {
        #region [FIELDS]

        private OmnipresenceEntities db;
        private static CommentServices instance;

        #endregion

        #region [CONSTRUCTOR]

        private CommentServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public static CommentServices GetInstance()
        {
            if (instance == null)
            {
                instance = new CommentServices();
            }

            return instance;
        }

        #endregion

        #region [CRUD]

        public bool CreateComment(CreateCommentModel createCommentModel)
        {
            Comment comment = new Comment();
            comment.CommentText = createCommentModel.Comment;
            comment.Timestamp = DateTime.Now;

            Event evt = db.Events.Where(ev => ev.EventId == createCommentModel.EventId).FirstOrDefault();
            UserProfile userProfile = db.UserProfiles.Where(up => up.UserProfileId == createCommentModel.UserProfileId).FirstOrDefault();

            comment.Event = evt;
            comment.UserProfile = userProfile;

            if (comment.Event != null && comment.UserProfile != null)
            {
                db.AddToComments(comment);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdateComment(CommentModel updateCommentModel)
        {
            Comment comment = db.Comments.Where(c => c.CommentId == updateCommentModel.CommentId).FirstOrDefault();

            if (comment != null)
            {
                comment.CommentText = updateCommentModel.CommentText;
                comment.Timestamp = DateTime.Now;
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool DeleteComment(DeleteCommentModel dcm)
        {
            Comment comment = db.Comments.Where(c => c.CommentId == dcm.CommentId).FirstOrDefault();

            if (comment != null)
            {
                db.DeleteObject(comment);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region [SEARCH]

        public CommentModel GetCommentById(int id)
        {
            Comment comment = db.Comments.Where(c => c.CommentId == id).FirstOrDefault();
            return Utilities.CommentToCommentModel(comment);
        }

        public IQueryable<CommentModel> GetAllCommentsByUserProfileId(int id)
        {
            List<CommentModel> commentModels = new List<CommentModel>();
            IQueryable<Comment> comments = db.Comments.Where(c => c.UserProfileId == id);

            foreach (Comment comment in comments)
            {
                commentModels.Add(Utilities.CommentToCommentModel(comment));
            }

            return commentModels.AsQueryable();
        }

        public IQueryable<CommentModel> GetAllCommentsByEventId(int id)
        {
            List<CommentModel> commentModels = new List<CommentModel>();
            IQueryable<Comment> comments = db.Comments.Where(c => c.EventId == id);

            foreach (Comment comment in comments)
            {
                commentModels.Add(Utilities.CommentToCommentModel(comment));
            }

            return commentModels.AsQueryable();
        }

        public IQueryable<CommentModel> GetAllComments()
        {
            List<CommentModel> commentModels = new List<CommentModel>();
            IQueryable<Comment> comments = db.Comments;

            foreach (Comment comment in comments)
            {
                commentModels.Add(Utilities.CommentToCommentModel(comment));
            }

            return commentModels.AsQueryable();
        }

        #endregion

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
