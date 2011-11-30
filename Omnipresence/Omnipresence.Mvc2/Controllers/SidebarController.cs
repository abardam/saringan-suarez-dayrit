using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Omnipresence.Mvc2.Models;
using Omnipresence.Processing;
using Omnipresence.DataAccess.Core; // TODO: REMOVE ACCESS TO THIS

namespace Omnipresence.Mvc2.Controllers
{
    public class SidebarController : Controller
    {
        private AccountServices accountServices;
        private EventServices eventServices;
        public IFormsAuthenticationService FormsService { get; set; }
        //public IMembershipService MembershipService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            //if (MembershipService == null) { MembershipService = new AccountMembershipService(); }
            accountServices = AccountServices.GetInstance();
            eventServices = EventServices.GetInstance();

            base.Initialize(requestContext);
        }

        public ActionResult Index()
        {
            //TODO: Actual model
            IndexViewModel vm = new IndexViewModel();
            return PartialView("IndexUserControl",vm);
        }

        public ActionResult Profile(String username)
        {
            UserProfileModel p = accountServices.GetUserProfileByUsername(username);
            
            DateTime Birthdate;
            if (p.Birthdate != null)
            {
                Birthdate = (DateTime)p.Birthdate;
            }
            else
            {
                Birthdate = DateTime.Now;
            }

            ProfileModel model = new ProfileModel {  
                Birthdate = Birthdate, 
                Description = p.Description, 
                FirstName = p.FirstName, 
                GenderText = p.IsFemale?"Female":"Male", 
                LastName = p.LastName, 
                Reputation = p.Reputation, 
                 };

            return PartialView("ProfileUserControl", model);
        }

        public ActionResult EditProfile()
        {
            List<string> genderList = new List<string>();
            genderList.Add("Male");
            genderList.Add("Female");
            SelectList list = new SelectList(genderList);
            ViewData["gender"] = list;

            string username = User.Identity.Name;
            UserProfileModel up = accountServices.GetUserProfileByUsername(username);
            EditProfileModel u = new EditProfileModel();
            u.Description = up.Description;
            u.FirstName = up.FirstName;
            u.LastName = up.LastName;
            u.GenderText = up.IsFemale ? "Female" : "Male";
            u.Reputation = up.Reputation;
            u.BirthdateDay = up.Birthdate.Day;
            u.BirthdateMonth = up.Birthdate.ToString("MMMM");
            u.BirthdateYear = up.Birthdate.Year;

            int[] dayA = new int[31];

            for (int i = 0; i < 31; i++)
            {
                dayA[i] = i + 1;
            }

            SelectList daySL = new SelectList(dayA);


            return PartialView("EditProfileUserControl", u);
        }

        [HttpPost]
        public ActionResult EditProfile(EditProfileModel model)
        {
            String username = User.Identity.Name;
            UserProfileModel p = accountServices.GetUserProfileByUsername(username);
            p.Birthdate = model.Birthdate;
            p.Description = model.Description;
            p.LastName = model.LastName;
            p.FirstName = model.FirstName;
            p.IsFemale = model.GenderText.Equals("Female");

            DateTime newDT = DateTime.Parse(model.BirthdateMonth + "/" + model.BirthdateDay + "/" + model.BirthdateYear);

            p.Birthdate = newDT;
            accountServices.UpdateUserProfile(p);
            //return PartialView("ProfileUserControl", model);
            return Profile(username);
        }

        // TODO: CHANGE EVENT OBJECT TYPE IN EVENTSERVICES
        public ActionResult NewEvent()
        {
            return PartialView("NewEventUserControl");
        }
        [HttpPost]
        public ActionResult NewEvent(NewEventModel model)
        {
            CreateEventModel cem = new CreateEventModel();
            cem.Address = model.Address;
            cem.CategoryString = model.CategoryString;
            cem.Description = model.Description;
            cem.EndTime = model.EndTime;
            cem.Latitude = model.Latitude;
            cem.Longitude = model.Longitude;
            cem.StartTime = model.StartTime;
            cem.Title = model.Title;
            string username = User.Identity.Name;
            cem.UserProfileId=accountServices.GetUserProfileByUsername(username).UserProfileId;
            eventServices.CreateEvent(cem);
            return Index();
        }
        public ActionResult EditEvent(int id)
        {
            // TODO: insert logic
            EditEventModel model = new EditEventModel{ CreatedBy = 1, CreateTime = DateTime.Now, DeleteTime = DateTime.Now, Description = "Description", Duration = 10, EndTime = DateTime.Now, Name= "Name", StartTime = DateTime.Now};
            return PartialView("EditEvent", model);
        }
        [HttpPost]
        public ActionResult EditEvent(EditEventModel model)
        {
            // TODO: insert logic
            return PartialView("EditEvent", model);
        }
        public ActionResult Login()
        {
            return PartialView("LoginUserControl");
        }
        [HttpPost]
        public ActionResult Login(LogOnModel model)
        {
            if (ModelState.IsValid)
            {
                ValidateUserModel vum = new ValidateUserModel();
                vum.Username = model.UserName;
                vum.Password = model.Password;

                if (accountServices.ValidateUser(vum))
                {
                    FormsService.SignIn(model.UserName, model.RememberMe);

                    return RedirectToAction("Index","Home");
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }
            }

            return PartialView("LoginUserControl",model);
        }
        public ActionResult Register()
        {
            ViewData["PasswordLength"] = 6;
            return PartialView("RegisterUserControl");
        }
        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (AddUser(model)) return RedirectToAction("Index", "Home");

            ViewData["PasswordLength"] = 6;
            return PartialView("RegisterUserControl",model);
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
                cupm.Birthdate = model.Birthdate;
                cupm.Description = "";
                cupm.IsFemale = false;

                if (accountServices.CreateUser(cum, cupm)) {
                    
                }
                else
                {
                    ModelState.AddModelError("", AccountValidation.ErrorCodeToString(MembershipCreateStatus.UserRejected));
                }
            }
            return false;
        }
        public ActionResult LogOff()
        {
            FormsService.SignOut();
            return RedirectToAction("Index","Home");
        }
        public ActionResult Search()
        {
            SearchEventModel model = new SearchEventModel();
            return PartialView("SearchUserControl", model);
        }
    }
}
