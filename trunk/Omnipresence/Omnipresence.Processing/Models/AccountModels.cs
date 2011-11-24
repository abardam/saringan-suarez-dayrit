using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class UserModel
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string PasswordSalt { get; set; }
        public string Email { get; set; }
        public string AlternateEmail { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsActivated { get; set; }
        public bool IsLockedOut { get; set; }
        public DateTime LastLockedOutDate { get; set; }
        public UserProfile UserProfile { get; set; }
        public DateTime LastLoginDate { get; set; }
        public string SecurityQuestion { get; set; }
        public string SecurityAnswer { get; set; }
    }

    public class CreateUserModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }

    public class DeleteUserModel
    {
        public int UserId { get; set; }
    }

    public class UserProfileModel
    {
        public int UserProfileId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Description { get; set; }
        public DateTime Birthdate { get; set; }
        public bool IsFemale { get; set; }
        public int Reputation { get; set; }
        public byte[] Avatar { get; set; }
        public System.Data.Objects.DataClasses.EntityCollection<Friendship> AcceptedFriendships { get; set; }
        public System.Data.Objects.DataClasses.EntityCollection<Friendship> RequestedFriendships { get; set; }
        public System.Data.Objects.DataClasses.EntityCollection<Comment> Comments { get; set; }
    }

    public class CreateUserProfileModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthdate { get; set; }
        public bool IsFemale { get; set; }
        public string Description { get; set; }
    }

    public class DeleteUserProfileModel
    {
        public int UserProfileId { get; set; }
    }

    public class UpdatePasswordModel
    {
        public string Username { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }

    public class ValidateUserModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class MakeFriendsModel
    {
        public int AdderUserProfileId { get; set; }
        public int AddedUserProfileId { get; set; }
    }
}
