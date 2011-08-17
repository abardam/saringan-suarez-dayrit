<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    if (Request.IsAuthenticated) {
%>
        <!--Welcome <b><%: Page.User.Identity.Name %></b>!-->
        <li><%: Html.ActionLink("Home", "Index", "Home")%></li>
        <li><%: Html.ActionLink("Profile", "Index", "Profile") %></li>
        <li><%: Html.ActionLink("Friends", "Index", "Friends") %></li>
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
