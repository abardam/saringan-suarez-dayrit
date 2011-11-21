using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public enum CreateAccountStatus
    {
        Success = 0,
        InvalidUserName = 1,
        InvalidPassword = 2,
        InvalidQuestion = 3,
        InvalidAnswer = 4,
        InvalidEmail = 5,
        DuplicateUserName = 6,
        DuplicateEmail = 7,
        UserRejected = 8,
        InvalidProviderUserKey = 9,
        DuplicateProviderUserKey = 10,
        ProviderError = 11,
    }

    public enum CreateEventStatus
    {
        Success = 0,
        InvalidTitle = 1,
        InvalidDescription = 2,
    }
}
