<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.NotificationsViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Notifications
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Notifications</h2>
    <h3>
        <%: Model.Message %></h3>
        <div style="text-align:center; width:100%; display:block;">
    <table style="display:block; margin:auto;width:500px;">
        <% foreach (var item in Model.PendingFriendRequests)
           { %>
        <tr>
            <td>
                <img src="<%: item.Avatar %>" alt="<%: item.FirstName %> <%: item.LastName %>" class="thumb"/>
            </td>
            <td style="width:300px">
                <h2>
                    <%: Html.ActionLink( item.FirstName + " " + item.LastName, "ProfileById", "Profile", new { id = item.UserProfileId }, null ) %></h2>
            </td>
            <td style="width:150px"><p>
                <%: Html.ActionLink("Accept", "Accept", "Friends", new { id=item.UserProfileId }, null) %>
                |
                <%: Html.ActionLink("Decline", "Decline", "Friends", new { id=item.UserProfileId }, null)%></p>
            </td>
        </tr>
        <% } %>





    </table>
    
    

    

        <% foreach (Omnipresence.Mvc2.Models.MessageViewModel unread in Model.UnreadMessages)
           { %>
           <p><%: unread.SenderName %>: <%: unread.Message %></p>
        <% } %>

    
    
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
