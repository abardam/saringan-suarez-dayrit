<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.SearchResultModel>" %>

    <fieldset>
        <legend>Results</legend>
        
        <% foreach (Omnipresence.Mvc2.Models.ProfileViewModel pm in Model.UserResult)
           { %>
           <span><%=Html.ActionLink(pm.FirstName+" "+pm.LastName,"Profile",new {userProfileId=pm.UserProfileId}) %></span>
            <%} %>

    </fieldset>


