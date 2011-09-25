using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Omnipresence.Mvc2.ViewModels
{
    public class LoginViewModel
    {
        // TODO: Confirm actual LOGIN information, and update this (LoginViewModel)
        public string UserName { get; set; }
        public string Password { get; set; }
    }
    public class NewAccountViewModel
    {
        // TODO: Confirm actual REGISTRATION information, and update this (NewAccountViewModel)
        public string EmailAddress { get; set; }
        public string Password { get; set; }
    }
    public class ShortAccountViewModel
    {
        public string PictureThumbnail { get; set; }
        public string DisplayName { get; set; }
        public string UserName { get; set; }
        public string Title { get; set; }
        public int UserId { get; set; }
    }
    public class ProfileViewModel
    {
        // TODO: Update to include actual profile information
        public string Username { get; set; }
    }
}