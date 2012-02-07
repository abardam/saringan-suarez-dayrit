<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EventList.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.IndexViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
All
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
<td class="menu"><h3><%:Html.ActionLink("Hot","Hot","Event",null,null) %></h3></td>
<td class="menu"><h3><%:Html.ActionLink("Top","Top","Event",null,null) %></h3></td>
<% if (!Page.User.Identity.Name.Equals("")) { %>
<td class="menu"><h3><%:Html.ActionLink("Subscriptions", "Subscriptions", "Event", null, null)%></h3></td>
<%} %>
<td class="menu" id="select-menu"><h3><%:Html.ActionLink("All", "All", "Event", null, null)%></h3></td>
<td class="menu"><h3><%: Html.ActionLink("Search", "Search", "Home") %></h3></td>
</tr>
</table>
<script type="text/javascript" language="javascript">
        function realInitialize(){
            setMap("map");
        <% foreach(Omnipresence.Processing.EventModel item in Model.Events){ %>
            var tempLatlng = new google.maps.LatLng(<%= item.Location.Latitude %>, <%= item.Location.Longitude %>);
            addClickableMarker(tempLatlng, "<%= item.Title %>", <%= item.EventId%>);
            mapPanTo(tempLatlng);
            <%} %>
        }

        function goEvent(eventId){
            window.location = "/e/"+eventId;
        }
    </script>
    
    <h2>All</h2>

    <div class="map-container" id="map" data-lat="0" data-lng="0" all="true" style="width:680px; height:400px;"></div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
