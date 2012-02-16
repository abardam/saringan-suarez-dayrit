<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Omnipresence.Mvc2.Models.MessageViewModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Messages
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Messages</h2>

    <table>
        <tr>
            <th>
                Sent by:
            </th>
            <th>
                Message:
            </th>
            <th>
                Event:
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink(item.SenderName, "ProfileById", "Profile", new {id = item.SenderProfileID}, null) %>
            </td>
            <td>
                <% if (!item.Read)
                   { %> <b> <%} %>
                
                <%: Html.ActionLink(item.Message, "ViewMessage", "Message", new {id = item.MessageID.ToString()}, null) %>

                
                <% if (!item.Read)
                   { %> </b> <%} %>
            </td>
            <td>
            <% if (item.EventName != null)
               { %>
                <%: Html.ActionLink(item.EventName, "Index", "Event", new { id = item.EventID }, null)%>
                <%} %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Send", "Send") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

