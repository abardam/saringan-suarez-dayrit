using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class EventQueryModel
    {
        public string Type { get; set; }
        public IEnumerable<string> Tags { get; set; }
        public string SearchString { get; set; }
        public string City { get; set; }
        public int User { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
    }
}
