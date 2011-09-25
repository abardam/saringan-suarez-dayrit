using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Omnipresence.Mvc2.Models
{
    public class ProfileModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthdate { get; set; }
        public string Description { get; set; }
        public string AvatarUrl { get; set; }
        public int Reputation { get; set; }
        public int Timezone { get; set; }
        public string GenderText { get; set; }
    }
}
