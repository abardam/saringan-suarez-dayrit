using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class ApiUserModel
    {
        public int ApiUserId { get; set; }
        public string ApiKey { get; set; }
        public int ApiCallCount { get; set; }
        public DateTime LastCallDate { get; set; }
        public string AppName { get; set; }
        public string Email { get; set; }
    }

    public class CreateApiUserModel
    {
        public string ApiKey { get; set; }
        public string Email { get; set; }
        public string AppName { get; set; }
    }

    public class DeleteApiUserModel
    {
        public int ApiUserId { get; set; }
    }
}
