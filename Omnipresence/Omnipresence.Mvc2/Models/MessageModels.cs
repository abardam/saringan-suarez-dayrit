using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Omnipresence.Mvc2.Models
{
    public class MessageViewModel
    {
        public String SenderName { get; set; }
        public int SenderProfileID { get; set; }
        public String Message { get; set; }
        public Guid MessageID { get; set; }
        public int EventID { get; set; }
        public String EventName { get; set; }
        public bool Read { get; set; }
    }
}