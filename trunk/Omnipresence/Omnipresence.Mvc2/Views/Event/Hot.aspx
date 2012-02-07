<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EventList.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.IndexViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
Hot
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="SideContent" runat="server">
	<% Html.RenderPartial("IndexSidebar", Model.Sidebar); %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="event-list">
<table>
<tr>
<% if (!Page.User.Identity.Name.Equals("")) { %>
<td class="menu"><h3><%:Html.ActionLink("+New", "New", "Event", null, null)%></h3></td>
<%} %>
<td class="menu" id="select-menu"><h3><%:Html.ActionLink("Hot","Hot","Event",null,null) %></h3></td>
<td class="menu"><h3><%:Html.ActionLink("Top","Top","Event",null,null) %></h3></td>
<% if (!Page.User.Identity.Name.Equals("")) { %>
<td class="menu"><h3><%:Html.ActionLink("Subscriptions", "Subscriptions", "Event", null, null)%></h3></td>
<td class="menu"><h3><%:Html.ActionLink("All", "All", "Event", null, null)%></h3></td>
<%} %>
<td class="menu"><h3><%: Html.ActionLink("Search", "Search", "Home") %></h3></td>
</tr>
</table>
<% if (Model.Events.Count()>0) { %>
	<% bool x = false;  foreach (Omnipresence.Processing.EventModel mode in Model.Events)
    { %>
    <div class="event-box <%if (!x) { %> selected<%} else {%> unselected<%} %>">
    <div class="map-container" id="map<%: mode.EventId %>" data-lat="<%:mode.Location.Latitude %>" data-lng="<%:mode.Location.Longitude %>" style="width:680px; height:200px;"></div>
    <h3><%: Html.ActionLink(mode.Title, "Index", "Event", new {id = mode.EventId}, null) %></h3>
    <h5><%=mode.Location.Name%></h5>
    <p><%=mode.Description%></p>
    </div>
    <% } %>
    <script type="text/javascript">        function realInitialize() {
        <% foreach (Omnipresence.Processing.EventModel mode in Model.Events) { %>
            setMap("map<%:mode.EventId %>");
            <%} %>
        };
    </script>
    <% } else { %>
    <p>There are no events to display.</p>
    <% } %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
