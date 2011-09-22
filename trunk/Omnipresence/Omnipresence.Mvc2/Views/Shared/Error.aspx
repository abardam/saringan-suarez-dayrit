<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Web.Mvc.HandleErrorInfo>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Error
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <h2>
        Sorry, an error occurred while processing your request.
    </h2>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
