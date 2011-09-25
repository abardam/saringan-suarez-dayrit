<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.ProfileModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    <%: ViewData["Name"] %>
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
    <div class="banner">
        <h1><%: ViewData["Name"] %></h1>
    </div>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <span class="header"><%: Html.LabelFor(m =>m.FirstName) %>'s Information</span>

    <span class="header-2">Avatar</span>
    <span class="text"><img src="<%: Html.LabelFor(m => m.AvatarUrl)%>" alt="<%: Html.LabelFor(m =>m.FirstName) %>"/></span>

    <span class="header-2">First Name</span>
    <span class="text"><%: Html.LabelFor(m => m.FirstName) %></span>

    <span class="header-2">Last Name</span>
    <span class="text"><%: Html.LabelFor(m => m.LastName) %></span>

    <span class="header-2">Gender</span>
    <span class="text"><%: Html.LabelFor(m => m.GenderText) %></span>

    <span class="header-2">Description</span>
    <span class="text"><%: Html.LabelFor(m => m.Description) %></span>

    <span class="header-2">Birthdate</span>
    <span class="text"><%: Html.LabelFor(m => m.Birthdate) %></span>

    <span class="header-2">Reputation</span>
    <span class="text"><%: Html.LabelFor(m => m.Reputation) %></span>

</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>