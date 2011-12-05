<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.EditProfileViewModel>" %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
            
            
            <div class="editor-label">
                First name
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.FirstName) %>
                <%: Html.ValidationMessageFor(model => model.FirstName) %>
            </div>
            
            <div class="editor-label">
                Last name
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.LastName) %>
                <%: Html.ValidationMessageFor(model => model.LastName) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Birthdate) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Birthdate, String.Format("{0:g}", Model.Birthdate.ToString("dddd, dd MMMM yyyy"))) %>
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
                Gender
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.GenderText, ViewData["gender"] as SelectList)%>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>


