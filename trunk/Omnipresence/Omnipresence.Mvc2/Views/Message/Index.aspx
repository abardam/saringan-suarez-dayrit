<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Omnipresence.Mvc2.Models.MessageViewModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Index</h2>

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
                <%: item.Message %>
            </td>
            <td>
                <%: Html.ActionLink(item.EventName, "Index", "Event", new {id = item.EventID}, null) %>
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

