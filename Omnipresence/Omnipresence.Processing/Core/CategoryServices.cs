using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class CategoryServices
    {
        #region [FIELDS]

        private OmnipresenceEntities db;
        private static CategoryServices instance;

        #endregion

        #region [CONSTRUCTOR]

        private CategoryServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public static CategoryServices GetInstance()
        {
            if (instance == null)
            {
                instance = new CategoryServices();
            }

            return instance;
        }

        #endregion

        public bool CreateCategory(CreateCategoryModel ccm)
        {
            Category c = new Category();
            c.Name = ccm.Name;
            c.Description = ccm.Description;
            c.IconPath = ccm.IconPath;

            db.Categories.AddObject(c);
            db.SaveChanges();

            return true;
        }

        public IQueryable<CategoryModel> GetAllCategories()
        {
            List<CategoryModel> categoryModels = new List<CategoryModel>();
            IQueryable categories = db.Categories;
            try
            {
                foreach (Category category in categories)
                {
                    categoryModels.Add(Utilities.CategoryToCategoryModel(category));
                }
            }
            catch (Exception e) { }

            return categoryModels.AsQueryable();
        }
    }
}
