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
        #region [FIELDS]

        private OmnipresenceEntities db;
        private static AccountServices instance;

        #endregion

        #region [CONSTRUCTOR]

        private AccountServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public static AccountServices GetInstance()
        {
            if (instance == null)
            {
                instance = new AccountServices();
            }

            return instance;
        }

        #endregion

        #region [CRUD]

        public bool CreateUser(CreateUserModel userModel, CreateUserProfileModel userProfileModel)
        {
            User user = new User();
            user.Username = userModel.Username;
            user.Password = userModel.Password;
            user.Email = userModel.Email;

            user.PasswordSalt = "abc123";
            user.AlternateEmail = "";
            user.LastModifiedDate = DateTime.Now;
            user.LastLoginDate = DateTime.Now;
            user.CreatedDate = DateTime.Now;
            user.IsActivated = true;
            user.IsLockedOut = false;
            user.LastLockedOutDate = DateTime.Now;
            user.SecurityQuestion = "";
            user.SecurityAnswer = "";

            UserProfile userProfile = new UserProfile();
            userProfile.FirstName = userProfileModel.FirstName;
            userProfile.LastName = userProfileModel.LastName;
            userProfile.Birthdate = userProfileModel.Birthdate;
            userProfile.IsFemale = userProfileModel.IsFemale;
            userProfile.Description = userProfileModel.Description;

            userProfile.Reputation = 0;

            user.UserProfile = userProfile;

            db.AddToUsers(user);
            db.SaveChanges();

            return true;
        }

        public bool UpdateUser(UserModel userModel)
        {
            User user = db.Users.Where(u => u.UserId == userModel.UserId).FirstOrDefault();

            if(user != null)
            {
                user.Username = userModel.Username;
                user.Password = userModel.Password;
                user.PasswordSalt = userModel.PasswordSalt;
                user.Email = userModel.Email;
                user.AlternateEmail = userModel.AlternateEmail;
                user.SecurityQuestion = userModel.SecurityQuestion;
                user.SecurityAnswer = userModel.SecurityAnswer;
                user.CreatedDate = userModel.CreatedDate;
                user.IsActivated = userModel.IsActivated;
                user.IsLockedOut = userModel.IsLockedOut;
                user.LastLoginDate = user.LastLoginDate;
                user.UserProfile = userModel.UserProfile;
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool DeleteUser(DeleteUserModel deleteUserModel)
        {
            User user = db.Users.Where(u => u.UserId == deleteUserModel.UserId).FirstOrDefault();

            if (user != null)
            {
                db.Users.DeleteObject(user);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdateUserProfile(UserProfileModel userProfileModel)
        {
            UserProfile userProfile = db.UserProfiles.Where(u => u.UserProfileId == userProfileModel.UserProfileId).FirstOrDefault();

            if (userProfile != null)
            {
                userProfile.FirstName = userProfileModel.FirstName;
                userProfile.LastName = userProfileModel.LastName;
                userProfile.Birthdate = userProfileModel.Birthdate;
                userProfile.IsFemale = userProfileModel.IsFemale;
                userProfile.Description = userProfileModel.Description;
                userProfile.Reputation = userProfileModel.Reputation;
                userProfile.Avatar = userProfileModel.Avatar;
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool DeleteUserProfile(DeleteUserProfileModel deleteUserProfileModel)
        {
            UserProfile userProfile = db.UserProfiles.Where(u => u.UserProfileId == deleteUserProfileModel.UserProfileId).FirstOrDefault();

            if (userProfile != null)
            {
                db.UserProfiles.DeleteObject(userProfile);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region [SEARCH]

        public UserModel GetUserById(int id)
        {
            User user = db.Users.Where(account => account.UserId == id).FirstOrDefault();
            UserModel userModel = Utilities.UserToUserModel(user);

            return userModel;
        }

        public UserModel GetUserByEmail(string email)
        {
            User user = db.Users.Where(account => account.Email == email).FirstOrDefault();
            UserModel userModel = Utilities.UserToUserModel(user);

            return userModel;
        }

        public UserModel GetUserByUsername(string username)
        {
            User user = db.Users.Where(account => account.Username.ToLower() == username.ToLower()).FirstOrDefault();
            UserModel userModel = Utilities.UserToUserModel(user);

            return userModel;
        }

        public IQueryable<UserModel> GetAllUsers()
        {
            List<UserModel> userModels = new List<UserModel>();
            IQueryable<User> users = db.Users;

            foreach (User user in users)
            {
                userModels.Add(Utilities.UserToUserModel(user));
            }

            return userModels.AsQueryable();
        }

        public UserProfileModel GetUserProfileById(int id)
        {
            UserModel userModel = GetUserById(id);

            if (userModel != null)
            {
                return Utilities.UserProfileToUserProfileModel(userModel.UserProfile);
            }
            else
            {
                return null;
            }
        }

        public UserProfileModel GetUserProfileByEmail(string email)
        {
            UserModel userModel = GetUserByEmail(email);

            if (userModel != null)
            {
                return Utilities.UserProfileToUserProfileModel(userModel.UserProfile);
            }
            else
            {
                return null;
            }
        }

        public UserProfileModel GetUserProfileByUsername(string username)
        {
            UserModel userModel = GetUserByUsername(username);

            if (userModel != null)
            {
                return Utilities.UserProfileToUserProfileModel(userModel.UserProfile);
            }
            else
            {
                return null;
            }
        }

        public IQueryable<UserProfileModel> GetAllUserProfiles()
        {
            IQueryable<UserProfile> userProfiles = db.UserProfiles;
            List<UserProfileModel> userProfileModels = new List<UserProfileModel>();

            foreach (UserProfile up in userProfiles)
            {
                userProfileModels.Add(Utilities.UserProfileToUserProfileModel(up));
            }

            return userProfileModels.AsQueryable();
        }

        public IQueryable<UserProfileModel> GetAllFriends(GetFriendsModel gafm)
        {
            UserProfile userProfile = db.UserProfiles.Where(u => u.UserProfileId == gafm.UserProfileId).FirstOrDefault();
            var acceptedFriends = userProfile.AcceptedFriendships;
            var requestedFriends = userProfile.RequestedFriendships;

            List<UserProfile> friends = new List<UserProfile>();

            foreach (Friendship item in acceptedFriends)
            {
                friends.Add(item.AddingParty);
            }

            foreach (Friendship item in requestedFriends)
            {
                friends.Add(item.AddedParty);
            }

            List<UserProfileModel> userProfileModels = new List<UserProfileModel>();

            foreach (UserProfile up in friends)
            {
                userProfileModels.Add(Utilities.UserProfileToUserProfileModel(up));
            }

            return userProfileModels.AsQueryable();
        }

        public IQueryable<UserProfileModel> GetRequestedFriends(GetFriendsModel gafm)
        {
            UserProfile userProfile = db.UserProfiles.Where(u => u.UserProfileId == gafm.UserProfileId).FirstOrDefault();
            var requestedFriends = userProfile.RequestedFriendships;

            List<UserProfile> friends = new List<UserProfile>();

            foreach (Friendship item in requestedFriends)
            {
                friends.Add(item.AddedParty);
            }

            List<UserProfileModel> userProfileModels = new List<UserProfileModel>();

            foreach (UserProfile up in friends)
            {
                userProfileModels.Add(Utilities.UserProfileToUserProfileModel(up));
            }

            return userProfileModels.AsQueryable();
        }

        public IQueryable<UserProfileModel> GetAcceptedFriends(GetFriendsModel gafm)
        {
            UserProfile userProfile = db.UserProfiles.Where(u => u.UserProfileId == gafm.UserProfileId).FirstOrDefault();
            var acceptedFriends = userProfile.AcceptedFriendships;

            List<UserProfile> friends = new List<UserProfile>();

            foreach (Friendship item in acceptedFriends)
            {
                friends.Add(item.AddingParty);
            }

            List<UserProfileModel> userProfileModels = new List<UserProfileModel>();

            foreach (UserProfile up in friends)
            {
                userProfileModels.Add(Utilities.UserProfileToUserProfileModel(up));
            }

            return userProfileModels.AsQueryable();
        }

        #endregion

        public bool UpdatePassword(UpdatePasswordModel changePasswordModel)
        {
            User user = db.Users.Where(x => x.Username == changePasswordModel.Username).FirstOrDefault();

            if (user != null)
            {
                if (user.Password == changePasswordModel.OldPassword)
                {
                    user.Password = changePasswordModel.NewPassword;
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

        public bool ValidateUser(ValidateUserModel validateUserModel)
        {
            UserModel userModel = GetUserByUsername(validateUserModel.Username);

            if (userModel != null)
            {
                return userModel.Password == validateUserModel.Password;
            }
            else
            {
                return false;
            }
        }

        public bool MakeFriends(MakeFriendsModel makeFriendsModel)
        {
            UserProfile requester = db.UserProfiles.Where(up => up.UserProfileId == makeFriendsModel.AdderUserProfileId).FirstOrDefault();
            UserProfile accepter = db.UserProfiles.Where(up => up.UserProfileId == makeFriendsModel.AddedUserProfileId).FirstOrDefault();
            
            if ((requester != null && accepter != null) && (requester != accepter))
            {
                if (!Utilities.AreFriends(requester, accepter))
                {
                    Friendship friendship = new Friendship();
                    friendship.AddingParty = requester;
                    friendship.AddedParty = accepter;

                    db.AddToFriendships(friendship);
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

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
