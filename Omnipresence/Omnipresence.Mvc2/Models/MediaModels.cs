using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Models
{
    public class MediaPageViewModel
    {
        public List<MediaItemModel> Images;
        public List<MediaItemModel> Videos;
        public int EventID;
    }
}