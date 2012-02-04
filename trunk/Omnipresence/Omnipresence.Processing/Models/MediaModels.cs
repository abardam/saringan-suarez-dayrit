using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class CreateMediaItemModel
    {
        public string FileName { get; set; }
        public string FilePath { get; set; }
        public int EventId { get; set; }
    }
    public class MediaItemModel
    {
        public string FileName { get; set; }
        public string FilePath { get; set; }
        public int EventId { get; set; }
    }
}
