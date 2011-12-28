<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EventList.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Omnipresence.Processing.EventModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	All
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <script type="text/javascript" language="javascript">
        function realInitialize(){
            setMap("map");
        <% foreach(Omnipresence.Processing.EventModel item in Model){ %>
            addMarker(new google.maps.LatLng(<%= item.Location.Latitude %>, <%= item.Location.Longitude %>), "<%= item.Title %>");
            <%} %>
        }
    </script>
    
    <h2>All</h2>

    <div class="map-container" id="map" data-lat="0" data-lng="0" style="width:680px; height:400px;"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

