using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing.Models
{
    public class SearchModel
    {
        public string SearchString { get; set; }
        public DateTime Date { get; set; }
        public int PageNumber { get; set; }
        public int NumberOfResults { get; set; }
    }
    public class SearchResults
    {
        public List<UserProfileModel> UserProfileSearchResults { get; set; }
        public List<EventModel> EventSearchResults { get; set; }
    }
}
