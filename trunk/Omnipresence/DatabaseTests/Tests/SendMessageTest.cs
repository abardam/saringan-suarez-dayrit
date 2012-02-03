using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public class SendMessageTest : Test
    {
        public override bool Execute()
        {
            int total = accountServices.GetAllUserProfiles().Count();
            int totale = eventServices.GetAllEvents().Count();

            int s,r,e;
            do {
                s = random.Next(total);
                r = random.Next(total);
                e = random.Next(totale);
            } while (s==r);

            MessageModel newMessage = new MessageModel
            {
                Message = "New Random Message",
                ReceipientProfileID = r,
                SenderProfileID = s,
                EventID = e
            };

            return eventServices.SendMessage(newMessage);
        }
    }
}
