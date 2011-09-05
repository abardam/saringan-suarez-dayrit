<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Omnipresence
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <script src="../../Scripts/jquery-1.4.1.js"> </script>
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
</asp:Content>

<asp:Content ID="TopLeftContent" ContentPlaceHolderID="TopLeftContent" runat="server">
    <div class="banner">
        <h1>Omnipresence: A Location Based Social Network</h1>
    </div>
</asp:Content>

<asp:Content ID="TopCenterContent" ContentPlaceHolderID="TopCenterContent" runat="server">
</asp:Content>

<asp:Content ID="TopRightContent" ContentPlaceHolderID="TopRightContent" runat="server">
</asp:Content>

<asp:Content ID="MiddleLeftContent" ContentPlaceHolderID="MiddleLeftContent" runat="server">
</asp:Content>

<asp:Content ID="MiddleCenterContent" ContentPlaceHolderID="MiddleCenterContent" runat="server">
    <div id="map_canvas">
    </div>
</asp:Content>

<asp:Content ID="MiddleRightContent" ContentPlaceHolderID="MiddleRightContent" runat="server">
</asp:Content>

<asp:Content ID="BottomLeftContent" ContentPlaceHolderID="BottomLeftContent" runat="server">
</asp:Content>

<asp:Content ID="BottomCenterContent" ContentPlaceHolderID="BottomCenterContent" runat="server">
</asp:Content>

<asp:Content ID="BottomRightContent" ContentPlaceHolderID="BottomRightContent" runat="server">
</asp:Content>
