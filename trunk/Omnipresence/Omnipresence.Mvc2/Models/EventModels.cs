using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Omnipresence.Mvc2.Models
{
    public class EditEventModel
    {
        // TODO: Update this using actual new event content (NewEventViewModel)
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
    public class NewEventModel
    {
        // TODO: Update this using actual new event content (NewEventViewModel)
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
    public class SearchEventModel
    {
    }
}
