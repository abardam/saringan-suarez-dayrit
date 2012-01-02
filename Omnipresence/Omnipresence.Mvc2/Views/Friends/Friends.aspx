<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.FriendsViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Friends
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h1><%:Model.Username %>'s Friends</h1>
<div style="text-align:center">
<% int counter = 0; foreach (Omnipresence.Processing.ProfileIdModel friend in Model.Friends)
   {
       if (counter == 0)
       {%>
       <table style="margin:auto;"><tr>
       <%} %>
       <td style="width:125px;height:125px;text-align:center;"><img src="<%: friend.AvatarUrl %>" alt="<%:friend.Username %>" style="" class="thumb"/><br />
   <%:Html.ActionLink(friend.Username, "Profile", "Profile", new { id = friend.Username }, null)%></td>
   <%
       if (++counter == 4)
       {%></tr></table>
       <%} counter %= 4; %>
<%} %>
   <%
       if (counter != 0)
       {%></tr></table>
       <%} %>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
