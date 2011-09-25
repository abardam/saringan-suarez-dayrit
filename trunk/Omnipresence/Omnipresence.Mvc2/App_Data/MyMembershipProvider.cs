//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.Mvc;
//using System.Web.Security;
//using System.Collections.Specialized;
//using Omnipresence.Processing;
//using Omnipresence.DataAccess.Core;

//public class OmniMembershipProvider : MembershipProvider
//{
//    private string _ApplicationName;
//    private bool _EnablePasswordReset;
//    private bool _EnablePasswordRetrieval = false;
//    private bool _RequiresQuestionAndAnswer = false;
//    private bool _RequiresUniqueEmail = true;
//    private int _MaxInvalidPasswordAttempts;
//    private int _PasswordAttemptWindow;
//    private int _MinRequiredPasswordLength;
//    private int _MinRequiredNonalphanumericCharacters;
//    private string _PasswordStrengthRegularExpression;
//    private MembershipPasswordFormat _PasswordFormat = MembershipPasswordFormat.Hashed;
//    private AccountServices accountServices = new AccountServices();

//    public override void Initialize(string name, NameValueCollection config)
//    {
//        if (config == null)
//        {
//            throw new ArgumentNullException("config");
//        }

//        if (name == null || name.Length == 0)
//        {
//            name = "OmniMembershipProvider";
//        }

//        if (String.IsNullOrEmpty(config["description"]))
//        {
//            config.Remove("description");
//            config.Add("description", "Custom Membership Provider");
//        }

//        base.Initialize(name, config);

//        _ApplicationName = GetConfigValue(config["applicationName"], System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath);
//        _MaxInvalidPasswordAttempts = Convert.ToInt32(GetConfigValue(config["maxInvalidPasswordAttempts"], "5"));
//        _PasswordAttemptWindow = Convert.ToInt32(GetConfigValue(config["passwordAttemptWindow"], "10"));
//        _MinRequiredNonalphanumericCharacters = Convert.ToInt32(GetConfigValue(config["minRequiredNonalphanumericCharacters"], "1"));
//        _MinRequiredPasswordLength = Convert.ToInt32(GetConfigValue(config["minRequiredPasswordLength"], "6"));
//        _EnablePasswordReset = Convert.ToBoolean(GetConfigValue(config["enablePasswordReset"], "true"));
//        _PasswordStrengthRegularExpression = Convert.ToString(GetConfigValue(config["passwordStrengthRegularExpression"], ""));

//        accountServices = new AccountServices();
//    }

//    public override string ApplicationName
//    {
//        get { return _ApplicationName; }
//        set { _ApplicationName = value; }
//    }

//    public override bool ChangePassword(string username, string oldPassword, string newPassword)
//    {
//        User user = accountServices.GetUserByUserName(username);

//        if (user.Password == oldPassword)
//        {
//            user.Password = newPassword;
//            return true;
//        }
//        else
//        {
//            return false;
//        }
//    }

//    public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
//    {
//        return false;
//    }

//    public override bool EnablePasswordReset
//    {
//        get { return _EnablePasswordReset; }
//    }

//    public override bool EnablePasswordRetrieval
//    {
//        get { return _EnablePasswordRetrieval; }
//    }

//    public override int MaxInvalidPasswordAttempts
//    {
//        get { return _MaxInvalidPasswordAttempts; }
//    }

//    public override int MinRequiredNonAlphanumericCharacters
//    {
//        get { return _MinRequiredNonalphanumericCharacters; }
//    }

//    public override int MinRequiredPasswordLength
//    {
//        get { return _MinRequiredPasswordLength; }
//    }

//    public override int PasswordAttemptWindow
//    {
//        get { return _PasswordAttemptWindow; }
//    }

//    public override MembershipPasswordFormat PasswordFormat
//    {
//        get { return _PasswordFormat; }
//    }

//    public override string PasswordStrengthRegularExpression
//    {
//        get { return _PasswordStrengthRegularExpression; }
//    }

//    public override bool RequiresQuestionAndAnswer
//    {
//        get { return _RequiresQuestionAndAnswer; }
//    }

//    public override bool RequiresUniqueEmail
//    {
//        get { return _RequiresUniqueEmail; }
//    }

//    public override bool ValidateUser(string username, string password)
//    {
//        User user = accountServices.GetUserByUserName(username);

//        return user != null ? user.Password == password : false;
//    }

//    private string GetConfigValue(string configValue, string defaultValue)
//    {
//        if (string.IsNullOrEmpty(configValue))
//        {
//            return defaultValue;
//        }

//        return configValue;
//    }

//    public MembershipUser GetUser(string username)
//    {
//        User dbuser = accountServices.GetUserByUserName(username);

//        if (dbuser != null)
//        {
//            string _username = dbuser.Username;
//            int _providerUserKey = dbuser.UserId;
//            string _email = dbuser.Email;
//            string _passwordQuestion = "";
//            string _comment = dbuser.Comments;
//            bool _isApproved = dbuser.IsActivated;
//            bool _isLockedOut = dbuser.IsLockedOut;
//            DateTime _creationDate = dbuser.CreatedDate;
//            DateTime _lastLoginDate = dbuser.LastLoginDate;
//            DateTime _lastActivityDate = DateTime.Now;
//            DateTime _lastPasswordChangedDate = DateTime.Now;
//            DateTime _lastLockedOutDate = dbuser.LastLockedOutDate;

//            MembershipUser user = new MembershipUser("OmniMembershipProvider",
//                                                        _username,
//                                                        _providerUserKey,
//                                                        _email,
//                                                        _passwordQuestion,
//                                                        _comment,
//                                                        _isApproved,
//                                                        _isLockedOut,
//                                                        _creationDate,
//                                                        _lastLoginDate,
//                                                        _lastActivityDate,
//                                                        _lastPasswordChangedDate,
//                                                        _lastLockedOutDate);

//            return user;
//        }
//        else
//        {
//            return null;
//        }
//    }

//    public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
//    {
//        User user = new User();

//        user.UserName = username;
//        user.Email = email;
//        user.Password = password;
//        user.PasswordSalt = "1234";
//        user.CreatedDate = DateTime.Now;
//        user.IsActivated = false;
//        user.IsLockedOut = false;
//        user.LastLockedOutDate = DateTime.Now;
//        user.LastLoginDate = DateTime.Now;

//        status = accountServices.AddUser(user) ? MembershipCreateStatus.Success : MembershipCreateStatus.UserRejected;

//        return GetUser(username);
//    }

//    public override bool DeleteUser(string username, bool deleteAllRelatedData)
//    {
//        return accountServices.DeleteUser(accountServices.GetUserByUserName(username));
//    }

//    public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
//    {
//        throw new NotImplementedException();
//    }

//    public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
//    {
//        throw new NotImplementedException();
//    }

//    public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
//    {
//        throw new NotImplementedException();
//    }

//    public override int GetNumberOfUsersOnline()
//    {
//        throw new NotImplementedException();
//    }

//    public override string GetPassword(string username, string answer)
//    {
//        throw new NotImplementedException();
//    }

//    public override MembershipUser GetUser(string username, bool userIsOnline)
//    {
//        throw new NotImplementedException();
//    }

//    public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
//    {
//        throw new NotImplementedException();
//    }

//    public override string GetUserNameByEmail(string email)
//    {
//        return accountServices.GetUserByEmail(email).Username;
//    }

//    public override string ResetPassword(string username, string answer)
//    {
//        User user = accountServices.GetUserByUserName(username);

//        if (user != null)
//        {
//            user.Password = "123456";
//            return user.Password;
//        }
//        else
//        {
//            return "";
//        }
//    }

//    public override bool UnlockUser(string username)
//    {
//        User user = accountServices.GetUserByUserName(username);
//        if (user != null)
//        {
//            user.IsLockedOut = false;
//            return true;
//        }
//        else
//        {
//            return false;
//        }
//    }

//    public override void UpdateUser(MembershipUser user)
//    {
//        throw new NotImplementedException();
//    }
//}
