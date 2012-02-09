using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using Omnipresence.DataAccess.Core;

namespace Omnipresence.Processing
{
    public class MediaServices : IDisposable
    {
        #region [FIELDS]

        private OmnipresenceEntities db;
        private static MediaServices instance;

        #endregion

        #region [CONSTRUCTOR]

        private MediaServices()
        {
            db = new OmnipresenceEntities();
            db.Connection.Open();
        }

        public static MediaServices GetInstance()
        {
            if (instance == null)
            {
                instance = new MediaServices();
            }

            return instance;
        }

        #endregion

        #region [CRUD]

        public IEnumerable<MediaItemModel> GetMediaItemsByEvent(int eventId)
        {
            List<MediaItemModel> retVal = new List<MediaItemModel>();
            if (eventId <1) return null;
            var temp = db.MediaItems.Where(x => x.EventId == eventId);
            foreach (MediaItem b in temp)
            {
                retVal.Add(new MediaItemModel { EventId = b.EventId, FileName = b.FileName, FilePath = b.FilePath, Type = MediaType.IMAGE, UploaderUsername = "user1" });
            }
            return retVal;
        }

        public bool CreateMediaItem(CreateMediaItemModel cmim)
        {
            if (cmim != null)
            {
                MediaItem mi = new MediaItem();
                mi.FileName = cmim.FileName;
                mi.FilePath = cmim.FilePath;

                Event evt = db.Events.Where(e => e.EventId == cmim.EventId).FirstOrDefault();

                evt.MediaItems.Add(mi);
                db.SaveChanges();

                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        public void Dispose()
        {
            db.Connection.Close();
        }
    }
}
