<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.SearchResultModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Search
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Search</h2>
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.SearchString) %>
            <%: Html.ValidationMessageFor(model => model.SearchString) %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownListFor(model => model.SearchType, Model.SearchTypes) %>
        </div>
        <p>
            <input type="submit" value="Search" />
        </p>
    </fieldset>
    <% } %>
    <% if (!("").Equals(Model.SearchString))
       { %>
    <h2>
        Results</h2>
        <% if (Model.Message != "")
           { %>
        <h3>
        <%:Model.Message%>
        </h3>
        <%} %>
    <%} %>
    <% if (Model.UserResult != null)
       {
           foreach (Omnipresence.Processing.UserProfileModel pm in Model.UserResult)
           { %>
    <p>
        <%: Html.ActionLink(pm.FirstName + " " + pm.LastName,"ProfileById", "Profile", new {id = pm.UserProfileId}, null) %></p>
    <%}
       } %>
    <% if (Model.EventResult != null)
       {
           foreach (Omnipresence.Processing.EventModel em in Model.EventResult)
           { %>
    <p>
        <%: Html.ActionLink(em.Title + ". " + em.Location.Name + ", " + String.Format("{0:D}", em.StartTime),"Index", "Event", new {id = em.EventId}, null) %></p>
    <%}
       } %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
