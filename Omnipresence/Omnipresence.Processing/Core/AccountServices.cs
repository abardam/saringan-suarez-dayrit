using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;
// TODO: CHANGE ALL RETURN VALUES TO OBJECT TYPES RELEVANT ONLY TO THIS PROJECT, PROCESSING

namespace Omnipresence.Processing
{
    public class AccountServices:IDisposable
    {
        private OmnipresenceEntities db;

        public AccountServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public void AddUser(User user)
        {
            db.AddToUsers(user);
            db.SaveChanges();
        }

        public User CreateUser(string username, string password, string email, string firstName, string lastName, DateTime birthdate)
        {
            User user = GetUserByUserName(username);

            if (user != null)
            {
                return null;
            }

            user = new User();
            user.Username = username;
            user.Password = password;
            user.Email = email;
            user.PasswordSalt = "1234";
            user.LastLoginDate = DateTime.Now;
            user.CreatedDate = DateTime.Now;
            user.IsActivated = true;
            user.IsLockedOut = false;
            user.LastLockedOutDate = DateTime.Now;

            UserProfile userProfile = CreateUserProfile(firstName, lastName, birthdate, "male", 0, "", 0);
            user.UserProfile = userProfile;

            return user;
        }

        public UserProfile CreateUserProfile(string firstName, string lastName, DateTime birthdate, string genderString, int reputation, string description, int timezone)
        {
            Gender gender = GetGender(genderString);
            return CreateUserProfile(firstName, lastName, birthdate, gender, reputation, description, timezone);
        }

        private UserProfile CreateUserProfile(string firstName, string lastName, DateTime birthdate, Gender gender, int reputation, string description, int timezone)
        {
            UserProfile userProfile = new UserProfile();
            userProfile.FirstName = firstName;
            userProfile.LastName = lastName;
            userProfile.Birthdate = birthdate;
            userProfile.Gender = gender;
            userProfile.Reputation = reputation;
            userProfile.Timezone = timezone;
            userProfile.Description = description;

            return userProfile;
        }

        public IQueryable<User> GetUserAccounts()
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                return db.Users.AsQueryable();
            }
        }

        public bool DeleteUser(User user)
        {
            db.Users.DeleteObject(user);
            db.SaveChanges();

            return true;
        }

        public User GetUserByEmail(string email)
        {
            User user = db.Users.Where(account => account.Email == email).FirstOrDefault();
            return user != null ? user : null;
        }

        public User GetUserByUserName(string username)
        {
            User user = db.Users.Where(account => account.Username.ToLower() == username.ToLower()).FirstOrDefault();
            return user != null ? user : null;
        }

        public bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            User user = db.Users.Where(x => x.Username == username).FirstOrDefault();

            if (user != null)
            {
                if (user.Password == oldPassword)
                {
                    user.Password = newPassword;
                    db.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public bool ValidateUser(string username, string password)
        {
            User user = GetUserByUserName(username);

            if (user != null)
            {
                return user.Password == password;
            }
            else
            {
                return false;
            }
        }

        private Gender GetGender(string genderString)
        {
            if (genderString.Equals("male", StringComparison.CurrentCultureIgnoreCase) || genderString.Equals("female", StringComparison.CurrentCultureIgnoreCase))
            {
                Gender gender = db.Genders.Where(x => x.GenderText.Equals(genderString, StringComparison.CurrentCultureIgnoreCase)).SingleOrDefault();
                return gender;
            }
            else
            {
                return null;
            }
        }

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
