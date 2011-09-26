<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.ProfileModel>" %>

<% //TODO: Write actual PROFILE content (ProfileUserControl) %>
<div class="control-container">
    <span class="header"><%= Model.FirstName %> <%= Model.LastName %></span>
    <span class="header-2">Click anywhere to continue.</span>
    <span class="text">I am filler text.</span>
</div>