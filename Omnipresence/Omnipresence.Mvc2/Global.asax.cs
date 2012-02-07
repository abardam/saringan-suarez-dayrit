using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Omnipresence.Mvc2
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "PrettyProfileRoute",
                "profile/{id}",
                new { id = "", controller = "Profile", action = "Profile" }
                );
            routes.MapRoute(
                "PrettyEventRoute",
                "event/{id}",
                new { id = 0, controller = "Event", action = "Index" }
                );
            routes.MapRoute(
                "PrettyFriendsRoute",
                "profile/{id}/friends",
                new { id = "", controller = "Friends", action = "Friends" }
                );
            routes.MapRoute(
                "PrettyNotificationsRoute",
                "notifications",
                new { id = "", controller = "Home", action = "Notifications" }
                );
            routes.MapRoute(
                "PrettyMessagesRoute",
                "messages",
                new { id = "", controller = "Message", action = "Index" }
                );
            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }
    }
}