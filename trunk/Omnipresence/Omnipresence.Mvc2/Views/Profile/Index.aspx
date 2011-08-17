<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    <%: ViewData["Name"] %>
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="TopLeftContent" ContentPlaceHolderID="TopLeftContent" runat="server">
    <div class="banner">
        <h1><%: ViewData["Name"] %></h1>
    </div>
</asp:Content>

<asp:Content ID="TopCenterContent" ContentPlaceHolderID="TopCenterContent" runat="server">
</asp:Content>

<asp:Content ID="TopRightContent" ContentPlaceHolderID="TopRightContent" runat="server">
</asp:Content>

<asp:Content ID="MiddleLeftContent" ContentPlaceHolderID="MiddleLeftContent" runat="server">
</asp:Content>

<asp:Content ID="MiddleCenterContent" ContentPlaceHolderID="MiddleCenterContent" runat="server">
</asp:Content>

<asp:Content ID="MiddleRightContent" ContentPlaceHolderID="MiddleRightContent" runat="server">
</asp:Content>

<asp:Content ID="BottomLeftContent" ContentPlaceHolderID="BottomLeftContent" runat="server">
</asp:Content>

<asp:Content ID="BottomCenterContent" ContentPlaceHolderID="BottomCenterContent" runat="server">
</asp:Content>

<asp:Content ID="BottomRightContent" ContentPlaceHolderID="BottomRightContent" runat="server">
</asp:Content>
