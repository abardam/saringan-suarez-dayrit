using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class EventViewModelMicro
    {
        public int EventId { get; set; }
        public string Type { get; set; }
        public string Name { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }
}
