<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.NotificationModel>" %>
<div class="control-container">
        <span class="header">Notifications</span>
        <% bool printedFriendRequest = false; %>
        <%foreach (var friendRequest in Model.FriendRequestNotifications)
          {
               %>
               <% if (!printedFriendRequest)
                  {
                      printedFriendRequest = true; %>
                      <span class="header-2">Friend requests</span>
                      <%} %>

               <%= friendRequest.FullName%> <%: Html.ActionLink("Confirm", "ConfirmFriend", new {adderUserProfileId = friendRequest.UserProfileId}) %> Reject <br />
               <%} %>


</div>