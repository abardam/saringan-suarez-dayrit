using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Omnipresence.Processing
{
    public class CategoryModel
    {
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string IconPath { get; set; }
    }

    public class CreateCategoryModel
    {
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string IconPath { get; set; }
    }
}
