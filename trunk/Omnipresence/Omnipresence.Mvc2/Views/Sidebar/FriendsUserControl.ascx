<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<Omnipresence.Processing.UserProfileModel>>" %>
<div class="control-container">
    <span class="header">Friends</span>
    <table>
        <tr>
            <th></th>
            <th>
                Name
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td></td>
            <td>
                <a class="sidebar-link sidebar-button" onclick="" href="<%= Url.Action("Profile", "Sidebar", new {userProfileId=item.UserProfileId}) %>"><%: item.FirstName +" "+ item.LastName%></a>
            </td>
        </tr>
    
    <% } %>

    </table>


</div>