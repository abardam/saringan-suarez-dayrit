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
        public void CreateUserAccount(string username, string password, DateTime birthdate, string firstName, string lastName, 
            bool gender, string emailAddress, Country country, int timezone, UserAccountType userAccountType)
        {
            UserAccount userAccount = new UserAccount();
            userAccount.Username = username;
            userAccount.Password = password;
            userAccount.Birthdate = birthdate;
            userAccount.FirstName = firstName;
            userAccount.LastName = lastName;
            userAccount.Gender = gender;
            userAccount.EmailAddress = emailAddress;
            userAccount.Country = country;
            userAccount.Timezone = timezone;
            userAccount.UserAccountType = userAccountType;

            using (OmnipresenceEntities db = new OmnipresenceEntities("metadata=res://*/Core.Core.csdl|res://*/Core.Core.ssdl|res://*/Core.Core.msl;provider=System.Data.SqlClient;provider connection string=\"Data Source=F205-PC;Initial Catalog=Omnipresence;Integrated Security=True;MultipleActiveResultSets=True\""))
            {
                db.UserAccounts.AddObject(userAccount);
                db.SaveChanges();
            }
        }

        public IQueryable<UserAccount> GetUserAccounts()
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                return db.UserAccounts.AsQueryable();
            }
        }

        public void DeleteUserAccount(UserAccount userAccount)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                db.UserAccounts.DeleteObject(userAccount);
                db.SaveChanges();
            }
        }

        public UserAccount GetUserAccountByEmail(string email)
        {
            using (OmnipresenceEntities db = new OmnipresenceEntities())
            {
                return db.UserAccounts.Where(account => account.EmailAddress == email).FirstOrDefault();
            }
        }

        public void Dispose()
        {
            //throw new NotImplementedException();
        }
    }
}
