﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Omnipresence.Processing;

namespace Omnipresence.Mvc2.Models
{
    #region Models
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

    public class ChangePasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Current password")]
        public string OldPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [DisplayName("New password")]
        public string NewPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Confirm new password")]
        public string ConfirmPassword { get; set; }
    }

    public class LogOnModel
    {
        [Required]
        [DisplayName("User name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Password")]
        public string Password { get; set; }

        [DisplayName("Remember me?")]
        public bool RememberMe { get; set; }
    }

    public class RegisterModel
    {
        [Required]
        [DisplayName("User Name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.EmailAddress)]
        [DisplayName("Email Address")]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Password")]
        public string Password { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Confirm Password")]
        public string ConfirmPassword { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [DisplayName("First Name")]
        public string FirstName { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [DisplayName("Last Name")]
        public string LastName { get; set; }

        [Required]
        [DisplayName("Birthdate")]
        public DateTime Birthdate { get; set; }
    }
    #endregion

    //#region Services
    //// The FormsAuthentication type is sealed and contains static members, so it is difficult to
    //// unit test code that calls its members. The interface and helper class below demonstrate
    //// how to create an abstract wrapper around such a type in order to make the AccountController
    //// code unit testable.

    //public interface IMembershipService
    //{
    //    int MinPasswordLength { get; }

    //    bool ValidateUser(string userName, string password);
    //    MembershipCreateStatus CreateUser(string userName, string password, string email);
    //    bool ChangePassword(string userName, string oldPassword, string newPassword);
    //}

    //public class AccountMembershipService : IMembershipService
    //{
    //    private readonly OmniMembershipProvider _provider;

    //    public AccountMembershipService()
    //        : this(null)
    //    {
    //    }

    //    public AccountMembershipService(OmniMembershipProvider provider)
    //    {
    //        _provider = provider ?? new OmniMembershipProvider();
    //    }

    //    public int MinPasswordLength
    //    {
    //        get
    //        {
    //            return _provider.MinRequiredPasswordLength;
    //        }
    //    }

    //    public bool ValidateUser(string userName, string password)
    //    {
    //        if (String.IsNullOrEmpty(userName)) throw new ArgumentException("Value cannot be null or empty.", "userName");
    //        if (String.IsNullOrEmpty(password)) throw new ArgumentException("Value cannot be null or empty.", "password");

    //        return _provider.ValidateUser(userName, password);
    //    }

    //    public MembershipCreateStatus CreateUser(string userName, string password, string email)
    //    {
    //        if (String.IsNullOrEmpty(userName)) throw new ArgumentException("Value cannot be null or empty.", "userName");
    //        if (String.IsNullOrEmpty(password)) throw new ArgumentException("Value cannot be null or empty.", "password");
    //        if (String.IsNullOrEmpty(email)) throw new ArgumentException("Value cannot be null or empty.", "email");

    //        MembershipCreateStatus status;
    //        _provider.CreateUser(userName, password, email, null, null, true, null, out status);
    //        return status;
    //    }

    //    public bool ChangePassword(string userName, string oldPassword, string newPassword)
    //    {
    //        if (String.IsNullOrEmpty(userName)) throw new ArgumentException("Value cannot be null or empty.", "userName");
    //        if (String.IsNullOrEmpty(oldPassword)) throw new ArgumentException("Value cannot be null or empty.", "oldPassword");
    //        if (String.IsNullOrEmpty(newPassword)) throw new ArgumentException("Value cannot be null or empty.", "newPassword");

    //        // The underlying ChangePassword() will throw an exception rather
    //        // than return false in certain failure scenarios.
    //        try
    //        {
    //            MembershipUser currentUser = _provider.GetUser(userName, true);
    //            return currentUser.ChangePassword(oldPassword, newPassword);
    //        }
    //        catch (ArgumentException)
    //        {
    //            return false;
    //        }
    //        catch (MembershipPasswordException)
    //        {
    //            return false;
    //        }
    //    }
    //}
    //#endregion

    public interface IFormsAuthenticationService
    {
        void SignIn(string userName, bool createPersistentCookie);
        void SignOut();
    }

    public class FormsAuthenticationService : IFormsAuthenticationService
    {
        public void SignIn(string userName, bool createPersistentCookie)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentException("Value cannot be null or empty.", "userName");

            FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }

        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }

    //#region Validation

    public static class AccountValidation
    {
        public static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A username for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
    }
}