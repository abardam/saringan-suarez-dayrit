<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    if (Request.IsAuthenticated) {
%>
        <!--Welcome <b><%: Page.User.Identity.Name %></b>!-->
        <li><%: Html.ActionLink("Home", "Index", "Home")%></li>
        <li><%: Html.ActionLink("Profile", "Profile", "Home") %></li>
        <li><%: Html.ActionLink("Friends", "Friends", "Home") %></li>
        <li><%: Html.ActionLink("About", "About", "Home")%></li>
        <li><%: Html.ActionLink("Log Off", "LogOff", "Account") %></li>
<%
    }
    else {
%> 
        <li><%: Html.ActionLink("Log On", "LogOn", "Account") %></li>
<%
    }
%>
