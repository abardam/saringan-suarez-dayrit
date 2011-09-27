<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.IndexViewModel>" %>
<% if ( Request.IsAuthenticated ) { %>
<div class="control-container">
    <span class="header">Welcome, <%= Page.User.Identity.Name %></span>
    <span class="header-2">Click anywhere to continue.</span>
    <span class="content">I am filler text.</span>
</div>
<%} else { %>
<div class="control-container">
    <span class="header">Welcome, Guest!</span>
    <span class="header-2">Please login to proceed.</span>
    <span class="content">I am filler text.</span>
</div>
<%} %>