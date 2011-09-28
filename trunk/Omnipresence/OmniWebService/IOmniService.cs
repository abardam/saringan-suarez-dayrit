using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace OmniWebService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IOmniService
    {
        [OperationContract]
        bool AddEvent(string title,
            string description,
            string categoryString,
            DateTime created,
            DateTime lastModified,
            DateTime startTime,
            DateTime endTime,
            string locationName,
            double latitude,
            double longitude,
            int rating,
            string visibilityTypeString);

        [OperationContract]
        IQueryable<Event> GetEvents();
    }
}
