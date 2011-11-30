using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;
using System.Security.Cryptography;

namespace Omnipresence.Processing
{
    public class ApiServices:IDisposable
    {
        #region [FIELDS]

        private OmnipresenceEntities db;
        private static ApiServices instance;
        private const int API_CALL_LIMIT = 100000;

        #endregion

        #region [CONSTRUCTOR]

        private ApiServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public static ApiServices GetInstance()
        {
            if (instance == null)
            {
                instance = new ApiServices();
            }

            return instance;
        }

        #endregion

        #region [CRUD]

        public bool CreateApiUser(CreateApiUserModel caum)
        {
            ApiUser apiUser = new ApiUser();
            apiUser.ApiKey = caum.ApiKey;
            apiUser.Email = caum.Email;
            apiUser.AppName = caum.AppName;
            apiUser.LastCallDate = DateTime.Now;
            apiUser.ApiCallCount = 0;

            db.AddToApiUsers(apiUser);
            db.SaveChanges();

            return true;
        }

        #endregion

        #region [UTILITY METHODS]

        //Source: http://madskristensen.net/post/Generate-unique-strings-and-numbers-in-C.aspx
        //Author: Mads Kristensen
        //Date: Nov. 30, 2011
        public string GenerateApiKey()
        {
            long i = 1;
            byte[] guid = Guid.NewGuid().ToByteArray();

            foreach (byte b in guid)
            {
                i *= ((int)b + 1);
            }

            string apiKey = string.Format("{0:x}", i - DateTime.Now.Ticks);
            return apiKey;
        }

        public bool IsValidKey(string key)
        {
            ApiUser apiUser = db.ApiUsers.Where(u => u.ApiKey == key).FirstOrDefault();

            if (apiUser != null && apiUser.ApiCallCount <= API_CALL_LIMIT)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public void IncrementKeyUsage(string key)
        {
            ApiUser apiUser = db.ApiUsers.Where(u => u.ApiKey == key).FirstOrDefault();
            apiUser.ApiCallCount++;
            db.SaveChanges();
        }

        #endregion

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
