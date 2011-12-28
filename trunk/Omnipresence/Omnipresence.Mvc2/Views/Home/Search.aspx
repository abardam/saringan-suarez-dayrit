<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.SearchResultModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Search
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Search</h2>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.SearchString) %>
                <%: Html.ValidationMessageFor(model => model.SearchString) %>
            </div>
            
            <p>
                <input type="submit" value="Search" />
            </p>
        </fieldset>

    <% } %>

    <% if (!("").Equals(Model.SearchString))
       { %>
        <h2>Results</h2>
        <%} %>
    <% if (Model.UserResult != null)
       {
           foreach (Omnipresence.Mvc2.Models.ProfileViewModel pm in Model.UserResult)
           { %>
           <p><a href="/Profile/Index/<%=pm.UserProfileId %>"><%=pm.FirstName + " " + pm.LastName %></a></p>
            <%}
       } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

