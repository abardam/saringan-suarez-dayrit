<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.IndexSidebarViewModel>" %>

<% if (Request.IsAuthenticated) { %>
                    <% if (Model!=null) { %>
                        <img src="<%: Model.AvatarUrl %>" alt="<%: Model.Name %>" />
                <h1>
                    <%: Html.ActionLink(Model.Name, "Profile", "Profile", new { id = Page.User.Identity.Name }, null) %></h1>
                       <!-- <%: Html.ActionLink(Model.Notifications.ToString(), "Notifications") %>
                    <p><%: Html.ActionLink("view your profile","Index","Profile") %></p>-->
                    <p><%: Html.ActionLink("friends","Friends","Friends") %>
                    <% if (Model.Notifications.FriendRequests > 1) { %>
                    <%:Html.ActionLink(" (" + Model.Notifications.FriendRequests + " pending)", "Notifications", "Home")%><%} %>
                    <% else if (Model.Notifications.FriendRequests == 1) { %>
                    <%:Html.ActionLink(" (" + Model.Notifications.FriendRequests + " pending)", "Notifications", "Home")%><%} %></p>
                    
                    <% if(Model.Notifications.UnreadMessages > 1) { %>
                    <p><%: Html.ActionLink("messages ("+Model.Notifications.UnreadMessages+" unread)","Index","Message") %></p>
                    
                    <%}else{ %>
                    <p><%: Html.ActionLink("messages","Index","Message") %></p>
                    <%} %>
                    <p><%: Html.ActionLink("logout","LogOff","Account") %></p>
                    <%}else{ %>
                    <p>An error has occurred.</p><!-- will this actually happen? -->
                    <%} %>
<% } else { %>
<p>Welcome, Guest. To continue, please <%: Html.ActionLink("login","LogOn","Account") %> or <%: Html.ActionLink("register","Register","Account") %>.</p>
<% } %>