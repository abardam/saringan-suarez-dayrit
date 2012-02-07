<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.ProfileViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Profile
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section">
        <h1>
            <%: Model.Username %>'s Profile</h1>
        <div class="section">
            <table style="margin: auto;">
                <tr>
                    <td>
                        <div id="display-pic">
                            <img src="<%: Model.AvatarUrl %>" alt="<%:Model.Username %>" /></div>
                    </td>
                    <td>
                        <div id="user-info" style="text-align: left !important">
                            <h2 class="name">
                                <%: Model.FirstName %>
                                <%: Model.LastName %></h2>
                            <!--p>
            <%if (Model.Birthdate != null) {%>Born <%: String.Format("{0:g}", Model.Birthdate) %>, <%} %>
            <%: Model.GenderText %></p-->
                            <p>
                                <%: Model.Description %></p>
                            <!--p>
            Reputation: <%: Model.Reputation %></p-->
                            <% if (!Page.User.Identity.Name.Equals(""))
                               {
                                   if (Model.ViewingOwn)
                                   { %>
                            <p>
                                <%: Html.ActionLink("Edit Profile", "Edit")%></p>
                            <%}
                                   else
                                   {
                                       if (Model.ViewingFriend)
                                       {
                            %>
                            <p>
                                <%: Model.Username %>
                                is your friend.</p>
                            <%}
               else if (Model.ThisDudeHasSentAFriendRequestToYou)
               {
                            %><p>
                                <%=Html.ActionLink("Accept", "Accept","Friends", new { id = Model.UserProfileId }, null) %>
                                or
                                <%=Html.ActionLink("Reject", "Decline","Friends", new { id = Model.UserProfileId }, null) %>
                                friend request.</p>
                            <%
}
               else if (Model.FriendRequested)
               {
                            %><p>
                                Friend request pending.</p>
                            <%
}
               else
               { %>
                            <p>
                                <%=Html.ActionLink("Add as Friend", "Add","Friends", new { id = Model.UserProfileId }, null) %></p>
                            <%}
           }
                               } %>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="section">
        <h1>
            Friends</h1>
        <div style="text-align: center">
            <% int counter = 0; foreach (Omnipresence.Processing.ProfileIdModel friend in Model.Friends)
               {
                   if (counter == 0)
                   {%>
            <table style="margin: auto;">
                <tr>
                    <%} %>
                    <td style="width: 125px; height: 125px; text-align: center;">
                        <img src="<%: friend.AvatarUrl %>" alt="<%:friend.Username %>" style="" class="thumb" /><br />
                        <%:Html.ActionLink(friend.Username, "Profile", "Profile", new { id = friend.Username }, null)%>
                    </td>
                    <%
                        if (++counter == 4)
                        {%></tr>
            </table>
            <%} counter %= 4; %>
            <%} %>
            <%
                if (counter != 0)
                {%></tr></table>
            <%} %>
            <%: Html.ActionLink("see all", "Friends", "Friends", new { id = Model.Username }, null) %>
        </div>
    </div>
    <div class="section" id="event-listing">
        <h1>
            Events</h1>
        <% foreach (Omnipresence.Processing.EventModel b in Model.UserEvents)
           { %>
        <p class="event-bar">
            <%: Html.ActionLink(b.Title+",", "Index", "Event", new{ id = b.EventId }, null)%> <%: b.Location.Name %>, <%:String.Format("{0:D}", b.StartTime)%>.</p>
        <% } %>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" href="../../Content/styles/profile.css" />
</asp:Content>
