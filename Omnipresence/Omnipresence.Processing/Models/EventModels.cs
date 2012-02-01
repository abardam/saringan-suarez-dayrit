using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class EventModel
    {
        public int EventId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public Category Category { get; set; }
        public bool IsPrivate { get; set; }
        public Location Location { get; set; }
        public bool IsActive { get; set; }
        public DateTime LastModified { get; set; }
        public DateTime Created { get; set; }
        public int Rating { get; set; }
        public int CreatedById { get; set; }
        public bool IsLikedByUser { get; set; }
    }

    public class CreateEventModel
    {
        public int UserProfileId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string CategoryString { get; set; }
        public bool IsPrivate { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string LocationName { get; set; }
        public string Address { get; set; }
    }
    
    public class UpdateEventModel
    {
        public int EventId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public Category Category { get; set; }
        public bool IsPrivate { get; set; }
        public string Address { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public bool IsActive { get; set; }
        public int Rating { get; set; }
    }
    
    public class DeleteEventModel
    {
        public int EventId { get; set; }
    }

    public class VoteEventModel
    {
        public int EventId { get; set; }
        public int UserProfileId { get; set; }
        public bool IsDownvote { get; set; }
    }
    
    public class QueryEventModel
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public Location Location { get; set; }
    }

    public class ShareEventModel
    {
        public int SharerProfileId { get; set; }
        public List<int> SharedProfileIDList { get; set; }
        public int EventID { get; set; }
        public String Message { get; set; }
    }

    public class MessageModel
    {
        public int SenderProfileID { get; set; }
        public int ReceipientProfileID { get; set; }
        public String Message { get; set; }
        public int EventID { get; set; } //if ever
    }

    public class GetMessagesModel
    {
        public int UserProfileID { get; set; }
    }


    public static class EventValidation
    {
        public static string ErrorCodeToString(CreateEventStatus createStatus)
        {
            switch (createStatus)
            {
                case CreateEventStatus.InvalidTitle:
                    return "The title you entered is invalid.";
                case CreateEventStatus.InvalidDescription:
                    return "The description you entered is invalid";
                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
    }

}
