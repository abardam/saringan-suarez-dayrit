using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.Processing;

namespace DatabaseTests
{
    public abstract class Test
    {
        public string Name { get; set; }

        public abstract bool Execute();

        protected static Random random = new Random();
        protected AccountServices accountServices = AccountServices.GetInstance();
        protected EventServices eventServices = EventServices.GetInstance();
        protected ApiServices apiServices = ApiServices.GetInstance();
    }
}
