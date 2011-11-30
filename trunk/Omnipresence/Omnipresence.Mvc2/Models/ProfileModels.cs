using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Omnipresence.DataAccess.Core;
using System.Web.Mvc;
using System.Globalization;

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
        public string GenderText { get; set; }
    }

    public class EditProfileModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthdate { get; set; }
        public string Description { get; set; }
        public string AvatarUrl { get; set; }
        public int Reputation { get; set; }
        public string GenderText { get; set; }


        public int BirthdateDay { get; set; }
        public string BirthdateMonth { get; set; }
        public IEnumerable<SelectListItem> Months
        {
            get
            {
                return DateTimeFormatInfo
                       .InvariantInfo
                       .MonthNames
                       .Select((monthName, index) => new SelectListItem
                       {
                           Value = (index + 1).ToString(),
                           Text = monthName
                       });
            }
        }
        public int BirthdateYear { get; set; }
    }
}
