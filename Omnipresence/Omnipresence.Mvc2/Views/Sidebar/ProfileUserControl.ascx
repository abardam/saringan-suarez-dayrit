<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.ProfileModel>" %>

<% //TODO: Write actual PROFILE content (ProfileUserControl) %>
<div class="control-container">
    <div style="float:left; padding-right:15px;">
    <img src="<%= Model.AvatarUrl %>" alt="<%=Model.FirstName %>"/>
    </div>
    <div style="float:left;">
    <span class="header"><%= Model.FirstName %> <%= Model.LastName %></span>
    <span class="header-2"><%=Model.Description %></span>
    <span>Born <%= Model.Birthdate.ToString("dddd, dd MMMM yyyy") %>. </span>
    <span><%= Model.GenderText %>. </span>
    <span><%= Model.Reputation %> reputation. </span>
    <a href="<%= Url.Action("EditProfile", "Sidebar") %>">Edit</a>
    </div>
</div>