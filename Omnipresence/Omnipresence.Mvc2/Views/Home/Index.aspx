<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EventList.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.IndexViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="SideContent" runat="server">
	<% Html.RenderPartial("IndexSidebar", Model.Sidebar); %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="event-list">
<table>
<tr>
<td class="menu"><h3><%:Html.ActionLink("Hot","Hot","Event",null,null) %></h3></td>
<td class="menu"><h3><%:Html.ActionLink("Top","Top","Event",null,null) %></h3></td>
<% if (!Page.User.Identity.Name.Equals("")) { %>
<td class="menu"><h3><%:Html.ActionLink("Subscriptions", "Subscriptions", "Event", null, null)%></h3></td>
<td class="menu"><h3><%:Html.ActionLink("+New", "New", "Event", null, null)%></h3></td>
<%} %>
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
    <%--<%if (mode.IsLikedByUser)
      { %><div class="VoteDown"><%: Html.ActionLink(":)", "VoteDown", "Event", null, null)%></div>
    <%}else{ %>
    <div class="VoteUp"><%: Html.ActionLink(":)","VoteUp","Event", null,null) %></div>
    <%} %>
    </div>
    <% } %>--%>
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
<style type="text/css">
    table 
    {
        width:100%;
        text-align:center;
        border:0px;
        border-spacing:0px;
    }
    td.menu 
    {
        border-right: 1px solid white;
        border-left: 1px solid white;
        border-top: 2px solid white;
        border-bottom: 2px solid white;
        padding: 10px;
        background-color: Black;
        color:White;
    }
    td.menu a 
    {
        color:White;
    }
    td.menu:hover 
    {
        background-color: #C00;
    }
    div.VoteDown 
    {
        padding:10px;
        background-color:Yellow;
        color:Black;
    }
    div.VoteUp 
    {
        padding:10px;
        background-color:Black;
        color:White;
    }
</style>
</asp:Content>
