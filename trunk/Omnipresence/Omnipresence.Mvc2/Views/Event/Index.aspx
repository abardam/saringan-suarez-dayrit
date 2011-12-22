<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Processing.EventModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="map<%: Model.EventId %>" data-lat="<%:Model.Location.Latitude %>" data-lng="<%:Model.Location.Longitude %>" style="background-position:center;width:100%; height:200px;">
    </div>
    <script type="text/javascript">
        function realInitialize() {
            setMap("map<%:Model.EventId %>");
        }
    </script>
    <h1>
        <%: Model.Title %></h1>
        <div>
            <p><%: Model.Description %></p></div>
        <div>
            <p>From <%: String.Format("{0:g}", Model.StartTime) %> to <%:String.Format("{0:g}", Model.EndTime) %></p></div>
        <div><p>Rating: <%: Model.Rating %></p></div>
        <%: Html.ActionLink("Edit", "Edit", new {  id=Model.EventId  }) %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
