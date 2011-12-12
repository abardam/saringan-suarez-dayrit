<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EventList.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Omnipresence.Processing.EventModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="event-list">
<% if (Model.Count()>0) { %>
	<% bool x = false;  foreach (Omnipresence.Processing.EventModel mode in Model)
    { %>
    <div class="event-box<%if (!x) { x=true; %> selected<%} else {%> unselected<%} %>">
    <div id="map<%: mode.EventId %>" data-lat="<%:mode.Location.Latitude %>" data-lng="<%:mode.Location.Longitude %>" style="background-image:url('../../Content/gmaps.png');background-position:center;width:680px; height:200px;"></div>
    <h3><%=mode.Title%></h3>
    <h5><%=mode.Location.Name%></h5>
    <p><%=mode.Description%></p>
    </div>
    <% } %>
    <script type="text/javascript">$(document).ready(function() {
	<% foreach (Omnipresence.Processing.EventModel mode in Model) { %>
    alert("map<%:mode.EventId %>");
    <% } %>});</script>
    <% } else { %>
    <p>There are no events to display.</p>
    <% } %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
