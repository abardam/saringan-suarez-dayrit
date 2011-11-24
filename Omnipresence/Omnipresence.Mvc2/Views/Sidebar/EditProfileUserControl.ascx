<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Processing.UserProfileModel>" %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.UserProfileId) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.UserProfileId) %>
                <%: Html.ValidationMessageFor(model => model.UserProfileId) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.FirstName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.FirstName) %>
                <%: Html.ValidationMessageFor(model => model.FirstName) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.LastName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.LastName) %>
                <%: Html.ValidationMessageFor(model => model.LastName) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Birthdate) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Birthdate, String.Format("{0:g}", Model.Birthdate)) %>
                <%: Html.ValidationMessageFor(model => model.Birthdate) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Description) %>
                <%: Html.ValidationMessageFor(model => model.Description) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Reputation) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Reputation) %>
                <%: Html.ValidationMessageFor(model => model.Reputation) %>
            </div>
            <!--
            
            <div class="editor-label">
                gender
            </div>
            <div class="editor-field">
                gender
            </div>
            -->
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>


