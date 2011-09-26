<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Processing.NewEventModel>" %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Title) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Title) %>
                <%: Html.ValidationMessageFor(model => model.Title) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Description) %>
                <%: Html.ValidationMessageFor(model => model.Description) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.StartTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.StartTime) %>
                <%: Html.ValidationMessageFor(model => model.StartTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.EndTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.EndTime) %>
                <%: Html.ValidationMessageFor(model => model.EndTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CategoryString) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CategoryString) %>
                <%: Html.ValidationMessageFor(model => model.CategoryString) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.VisibilityTypeString) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.VisibilityTypeString) %>
                <%: Html.ValidationMessageFor(model => model.VisibilityTypeString) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Latitude) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Latitude) %>
                <%: Html.ValidationMessageFor(model => model.Latitude) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Longitude) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Longitude) %>
                <%: Html.ValidationMessageFor(model => model.Longitude) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.LocationName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.LocationName) %>
                <%: Html.ValidationMessageFor(model => model.LocationName) %>
            </div>
            
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>


