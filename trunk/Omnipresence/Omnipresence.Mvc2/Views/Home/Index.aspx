<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
    <script type="text/javascript">
        $('.toDefault').live('click', function () { $.get('<%= Url.Action("Default","Home") %>', function (d) { sideShow(d); }); });
        $('.toNewEvent').live('click', function () { $.get('<%= Url.Action("Default","Home") %>', function (d) { sideShow(d); }); });
        function sideShow(d) {$("#event_info").fadeOut(200, function () { $('#event_info').html(d); $('#event_info').fadeIn(200); }); }
    </script>
</asp:Content>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div id="map_container">
        <div id="event_info" class="">
        </div>
        <a class="toDefault" href="#">Hello</a>
        <div id="map_canvas">
        </div>
    </div>
</asp:Content>
<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>