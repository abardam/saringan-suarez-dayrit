<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.ProfileViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Profile
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section">
        <h1>
            <%: Model.Username %>'s Profile</h1>
        <div>
            <img src="<%: Model.AvatarUrl %>" alt="<%:Model.Username %>" /></div>
        <div class="display-label">
            Name</div>
        <div class="display-field">
            <%: Model.FirstName %>
            <%: Model.LastName %></div>
        <div class="display-label">
            Birthdate</div>
        <div class="display-field">
            <%: String.Format("{0:g}", Model.Birthdate) %></div>
        <div class="display-label">
            Description</div>
        <div class="display-field">
            <%: Model.Description %></div>
        <div class="display-label">
            Reputation</div>
        <div class="display-field">
            <%: Model.Reputation %></div>
        <div class="display-label">
            Gender</div>
        <div class="display-field">
            <%: Model.GenderText %></div>
    </div>
    <% if (!Page.User.Identity.Name.Equals(""))
   {
       if (Model.ViewingOwn)
       { %>

<%: Html.ActionLink("edit", "Edit")%>
<%}
       else
       {
           if (Model.ViewingFriend)
           {
               %>
               <p>Friend. </p>
               <%}
           else if (Model.ThisDudeHasSentAFriendRequestToYou)
           {
               %><p>Friend request pending. <a href="/Friends/Add/<%=Model.UserProfileId%>">Confirm.</a> Reject.</p><%
    }
           else if (Model.FriendRequested)
           {
               %><p>Friend request sent!</p><%
    }
           else
           { %>
       <p><a href="/Friends/Add/<%=Model.UserProfileId%>">Add as friend</a></p>
    <%}
       }
   } %>
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
    <div class="section">
        <h1>
            Events</h1>
        <% foreach (Omnipresence.Processing.EventModel b in Model.UserEvents)
           { %><p>
           <%: b.Title %></p>
        <% } %>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
