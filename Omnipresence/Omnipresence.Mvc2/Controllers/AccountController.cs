﻿using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Mvc2.Controllers
{
    [HandleError]
    public class AccountController : Controller
    {
        private AccountServices accountServices;
        public IFormsAuthenticationService FormsService { get; set; }
        //public IMembershipService MembershipService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            //if (MembershipService == null) { MembershipService = new AccountMembershipService(); }
            accountServices = AccountServices.GetInstance();

            base.Initialize(requestContext);
        }

        public ActionResult LogOn()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                ValidateUserModel vum = new ValidateUserModel();
                vum.Password = model.Password;
                vum.Username = model.UserName;
                if (accountServices.ValidateUser(vum))
                {
                    FormsService.SignIn(model.UserName, model.RememberMe);

                    if (!String.IsNullOrEmpty(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }
            }

            return View(model);
        }

        public ActionResult LogOff()
        {
            FormsService.SignOut();

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Register()
        {
            List<string> genderList = new List<string>();
            genderList.Add("Male");
            genderList.Add("Female");
            SelectList list = new SelectList(genderList);
            ViewData["gender"] = list;

            int[] dayA = new int[31];

            for (int i = 0; i < 31; i++)
            {
                dayA[i] = i + 1;
            }

            int[] yearA = new int[100];

            for (int i = 0; i < 100; i++)
            {
                yearA[i] = DateTime.Now.Year - i;
            }

            SelectList daySL = new SelectList(dayA);
            ViewData["days"] = daySL;

            SelectList yearSL = new SelectList(yearA);
            ViewData["years"] = yearSL;

            ViewData["PasswordLength"] = 6;
            return View(new RegisterModel());
        }

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (AddUser(model)) return RedirectToAction("Index", "Home");

            List<string> genderList = new List<string>();
            genderList.Add("Male");
            genderList.Add("Female");
            SelectList list = new SelectList(genderList);
            ViewData["gender"] = list;
            ViewData["PasswordLength"] = 6;


            int[] dayA = new int[31];

            for (int i = 0; i < 31; i++)
            {
                dayA[i] = i + 1;
            }

            int[] yearA = new int[100];

            for (int i = 0; i < 100; i++)
            {
                yearA[i] = DateTime.Now.Year - i;
            }

            SelectList daySL = new SelectList(dayA);
            ViewData["days"] = daySL;

            SelectList yearSL = new SelectList(yearA);
            ViewData["years"] = yearSL;


            return View(model);
        }
        //TODO: Transfer this to services
        public bool AddUser(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                CreateUserModel cum = new CreateUserModel();
                cum.Username = model.UserName.Trim();
                cum.Password = model.Password.Trim();
                cum.Email = model.Email.Trim();
                CreateUserProfileModel cupm = new CreateUserProfileModel();
                cupm.FirstName = model.FirstName.Trim();
                cupm.LastName = model.LastName.Trim();
                cupm.Description = "";
                cupm.IsFemale = model.GenderText.Equals("Female");

                DateTime newDT = DateTime.Parse(model.BirthdateMonth + "/" + model.BirthdateDay + "/" + model.BirthdateYear);

                cupm.Birthdate = newDT;

                if (accountServices.CreateUser(cum, cupm))
                {
                    return true;
                }
                else
                {
                    ModelState.AddModelError("", AccountValidation.ErrorCodeToString(MembershipCreateStatus.UserRejected));
                }
            }
            return false;
        }

        [Authorize]
        public ActionResult ChangePassword()
        {
            ViewData["PasswordLength"] = 6;
            return View();
        }

        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {
                UpdatePasswordModel upm = new UpdatePasswordModel();
                upm.NewPassword = model.NewPassword;
                upm.OldPassword = model.OldPassword;
                upm.Username = User.Identity.Name;
                if (accountServices.UpdatePassword(upm))
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            ViewData["PasswordLength"] = 6;
            return View(model);
        }

        public ActionResult ChangePasswordSuccess()
        {
            return View();
        }
    }
}
