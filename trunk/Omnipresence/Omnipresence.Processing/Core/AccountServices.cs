using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class AccountServices:IDisposable
    {
        public bool AddUser(User user)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities("metadata=res://*/Core.Core.csdl|res://*/Core.Core.ssdl|res://*/Core.Core.msl;provider=System.Data.SqlClient;provider connection string=\"Data Source=F205-PC;Initial Catalog=Omnipresence;Integrated Security=True;MultipleActiveResultSets=True\""))
            {
                db.Users.AddObject(user);
                db.SaveChanges();
            }

            return true;
        }

        public bool CreateUserAccount(string username, string password, string email, string firstName, string lastName, DateTime birthdate)
        {
            User user = new User();
            user.UserName = username;
            user.Password = password;
            user.Email = email;

            UserProfile userProfile = new UserProfile();
            userProfile.FirstName = firstName;
            userProfile.LastName = lastName;
            userProfile.Birthdate = birthdate;

            user.UserProfile = userProfile;

            using (OmnipresenceEntities db = new OmnipresenceEntities("metadata=res://*/Core.Core.csdl|res://*/Core.Core.ssdl|res://*/Core.Core.msl;provider=System.Data.SqlClient;provider connection string=\"Data Source=F205-PC;Initial Catalog=Omnipresence;Integrated Security=True;MultipleActiveResultSets=True\""))
            {
                db.Users.AddObject(user);
                db.SaveChanges();
            }

            return true;
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
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                db.Users.DeleteObject(user);
                db.SaveChanges();
            }

            return true;
        }

        public User GetUserByEmail(string email)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                return db.Users.Where(account => account.Email == email).FirstOrDefault();
            }
        }

        public User GetUserByUserName(string username)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                User acc = db.Users.Where(account => account.UserName.ToLower() == username.ToLower()).FirstOrDefault();
                return acc != null ? acc : null;
            }
        }

        public void Dispose()
        {
            //throw new NotImplementedException();
        }
    }
}
