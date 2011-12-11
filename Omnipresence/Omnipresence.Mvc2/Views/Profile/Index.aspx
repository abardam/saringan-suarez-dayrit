<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Processing.UserProfileModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h1><%: Model.FirstName %> <%: Model.LastName %></h1>
<img src=<%:Model.Avatar %> alt=""/>
<p>Date of birth: <%:Model.Birthdate.ToLongDateString() %></p>
<p>Description: <%:Model.Description %></p>
<p>Reputation: <%:Model.Reputation %></p>
<%:Html.ActionLink("edit", "Edit") %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
