<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.ProfileSidebarViewModel>" %>

<img src="<%: Model.AvatarUrl %>" alt="<%:Model.Name %>"/>
<h1><%: Model.Name %></h1>
<p>Friends: <%: Html.ActionLink(""+Model.FriendCount,"Friends","Friends",new {id = Model.Username},null) %></p>
<p>Reputation: <%: Model.Reputation %></p>