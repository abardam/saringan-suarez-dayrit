using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class GetAllCommentsByUserProfileIdTest : Test
    {
        public GetAllCommentsByUserProfileIdTest(string name)
        {
            Name = name;
        }

        public override bool Execute()
        {
            int userProfileId = random.Next(1, accountServices.GetAllUserProfiles().Count());

            IQueryable<CommentModel> comments = commentServices.GetAllCommentsByUserProfileId(userProfileId);

            Console.WriteLine("Comments posted by {0}", userProfileId);

            foreach (CommentModel comment in comments)
            {
                Console.WriteLine("\tComment Text: {0}\n\tTimestamp: {1}", comment.CommentText, comment.Timestamp);
            }

            return true;
        }
    }
}
