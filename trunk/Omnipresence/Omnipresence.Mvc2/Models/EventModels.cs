using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Omnipresence.Processing;
namespace Omnipresence.Mvc2.Models
{
    public class EventViewModel
    {
        public int EventId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string CategoryString { get; set; }
        public bool IsPrivate { get; set; }
        public string Address { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public bool IsActive { get; set; }
        public DateTime LastModified { get; set; }
        public DateTime Created { get; set; }
        public int Rating { get; set; }
        public int CreatedById { get; set; }
    }

    public class EditEventViewModel
    {
        public string Title { get; set; }
        public int CreatedBy { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Address { get; set; }
        public int Duration { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime DeleteTime { get; set; }
    }

    public class CreateEventViewModel
    {
        public string Title { get; set; }
        public int CreatedBy { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int Duration { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime DeleteTime { get; set; }
        public string CategoryString { get; set; }
        public string Address { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }

    public class EventCommentViewModel
    {
        public int EventId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string CategoryString { get; set; }
        public bool IsPrivate { get; set; }
        public string Address { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public bool IsActive { get; set; }
        public DateTime LastModified { get; set; }
        public DateTime Created { get; set; }
        public int Rating { get; set; }
        public int CreatedById { get; set; }
        public IEnumerable<CommentViewModel> CommentList { get; set; }
        public string NewComment { get; set; }
    }

    public class CommentViewModel
    {
        public int CommentId { get; set; }
        public int EventId { get; set; }
        public string CommenterName { get; set; }
        public int UserProfileId { get; set; }
        public string CommentText { get; set; }
        public DateTime Timestamp { get; set; }
        public string TimeString { get; set; }
        public bool UserIsAuthor { get; set; }
    }

    public class SearchEventViewModel
    {
        public string SearchString { get; set; }
    }
    public class SearchResultModel
    {
        public string SearchString { get; set; }
        public List<ProfileViewModel> UserResult { get; set; }
    }


}
