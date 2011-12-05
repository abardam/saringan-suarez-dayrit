<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.SearchEventViewModel>" %>
<div class="control-container">
    <span class="header">Search</span>
    <span class="header-2">Use the form below to search our event databases.</span>
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        <fieldset>
            <div class="editor-label">
                Search
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.SearchString) %>
                <%: Html.ValidationMessageFor(model => model.SearchString) %>
            </div>
            <p>
                <input type="submit" value="Go!" />
            </p>
        </fieldset>
    <% } %>
</div>