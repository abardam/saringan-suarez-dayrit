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

        public static Random random = new Random();
        protected static AccountServices accountServices = new AccountServices();
        protected static EventServices eventServices = new EventServices();
    }
}
