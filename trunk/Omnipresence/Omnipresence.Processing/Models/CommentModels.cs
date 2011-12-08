using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class CommentModel
    {
        public int CommentId { get; set; }
        public int UserProfileId { get; set; }
        public int EventId { get; set; }
        public string CommentText { get; set; }
        public DateTime Timestamp { get; set; }
    }

    public class CreateCommentModel
    {
        public int UserProfileId { get; set; }
        public int EventId { get; set; }
        public string Comment { get; set; }
    }

    public class DeleteCommentModel
    {
        public int CommentId { get; set; }
    }
}
