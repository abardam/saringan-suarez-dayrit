using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class GetAllCommentsByEventIdTest : Test
    {
        public GetAllCommentsByEventIdTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int eventId = random.Next(1, eventServices.GetAllEvents().Count());

            IQueryable<CommentModel> comments = commentServices.GetAllCommentsByEventId(eventId);

            Console.WriteLine("Comments posted about {0}", eventId);

            foreach (CommentModel comment in comments)
            {
                Console.WriteLine("\tComment Text: {0}\n\tTimestamp: {1}", comment.CommentText, comment.Timestamp);
            }

            return true;
        }
    }
}
