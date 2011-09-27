<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.ProfileModel>" %>

<% //TODO: Write actual PROFILE content (ProfileUserControl) %>
<div class="control-container">
    <div style="float:left; padding-right:15px;">
    <img src="<%= Model.AvatarUrl %>" alt="<%=Model.FirstName %>"/>
    </div>
    <div style="float:left;">
    <span class="header"><%= Model.FirstName %> <%= Model.LastName %></span>
    <span class="header-2"><%=Model.Description %></span>
    </div>
</div>