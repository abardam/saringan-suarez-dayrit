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
            Gender gender, string emailAddress, string alternateEmailAddress, int reputation, string description, Country country, 
            int timezone, UserAccountType userAccountType)
        {
            UserAccount userAccount = new UserAccount();
            userAccount.Username = username;
            userAccount.Password = password;
            userAccount.Birthdate = birthdate;
            userAccount.FirstName = firstName;
            userAccount.LastName = lastName;
            userAccount.Gender = gender;
            userAccount.EmailAddress = emailAddress;
            userAccount.AlternateEmailAddress = alternateEmailAddress;
            userAccount.Reputation = reputation;
            userAccount.Description = description;
            userAccount.Country = country;
            userAccount.Timezone = timezone;
            userAccount.UserAccountType = userAccountType;

            using (CoreContainer coreContainer = new CoreContainer())
            {
                coreContainer.UserAccounts.AddObject(userAccount);
                coreContainer.SaveChanges();
            }
        }

        public IQueryable<UserAccount> GetUserAccounts()
        {
            using (CoreContainer coreContainer = new CoreContainer())
            {
                return coreContainer.UserAccounts.AsQueryable();
            }
        }

        public void DeleteUserAccount(UserAccount userAccount)
        {
            using (CoreContainer coreContainer = new CoreContainer())
            {
                coreContainer.UserAccounts.DeleteObject(userAccount);
                coreContainer.SaveChanges();
            }
        }

        public UserAccount GetUserAccountByEmail(string email)
        {
            using (CoreContainer coreContainer = new CoreContainer())
            {
                return coreContainer.UserAccounts.Where(account => account.EmailAddress == email).FirstOrDefault();
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
