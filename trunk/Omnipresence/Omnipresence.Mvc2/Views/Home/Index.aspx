<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EventList.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Omnipresence.Processing.EventModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="event-list">
	<% foreach (Omnipresence.Processing.EventModel mode in Model) { %>
    <div class="event-box selected">
    <h3><%=mode.Title%></h3>
    <h5><%=mode.Location.Name%></h5>
    <p><%=mode.Description%></p>
    </div>
    <% } %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
