<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
</asp:Content>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
<div id="map_container">
    <div id="event_info" class="">
    </div>
    <div id="map_canvas">
    </div>
</div>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
