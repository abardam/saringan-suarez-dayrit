<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.EditProfileModel>" %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>edit</legend>
            
            
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
                <%: Html.TextBoxFor(model => model.BirthdateDay, new { style = "width:25px" })%>
                <%: Html.DropDownListFor(model => model.BirthdateMonth, Model.Months) %>
                <%: Html.TextBoxFor(model => model.BirthdateYear, new { style = "width:45px" })%>
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


