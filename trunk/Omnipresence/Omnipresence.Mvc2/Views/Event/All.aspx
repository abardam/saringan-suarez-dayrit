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
</style>
</asp:Content>
