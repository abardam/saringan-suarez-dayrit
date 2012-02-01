<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.NotificationModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Notifications</h1>
        <% bool printedFriendRequest = false; %>
        <%foreach (var friendRequest in Model.FriendRequestNotifications)
          {
               %>
               <% if (!printedFriendRequest)
                  {
                      printedFriendRequest = true; %>
                      <h2>Friend requests</h2>
                      <%} %>

               <p><%= friendRequest.FullName%> (<a href="/Friends/Add/<%=friendRequest.UserProfileId %>">Confirm.</a> Reject.) </p>
               <%} %>
        <% bool printedUnreadMessages = false; %>
        <%foreach (var unreadMessage in Model.UnreadMessages)
          {
               %>
               <% if (!printedUnreadMessages)
                  {
                      printedUnreadMessages = true; %>
                      <h2>Unread messages</h2>
                      <%} %>

               <p><%= unreadMessage.SenderName%>: <%= unreadMessage.Message  %> </p>
               <%} %>
    <p>
        <a href="/">Back</a>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

