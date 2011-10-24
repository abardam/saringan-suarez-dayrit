using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class NewEventModel
    {
        public string Title{get;set;}
        public string Description{get;set;}
        public DateTime StartTime{get;set;}
        public DateTime EndTime{get;set;}
        public string CategoryString{get;set;}
        public string VisibilityTypeString{get;set;}
        public double Latitude{get;set;}
        public double Longitude{get;set;}
        public string LocationName{get;set;}
    }
}
