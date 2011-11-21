using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DatabaseTests
{
    public abstract class Test
    {
        public string Name { get; set; }

        public abstract bool Execute();
    }
}
