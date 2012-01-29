<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.CreateEventViewModel>" %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CreatedBy) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CreatedBy) %>
                <%: Html.ValidationMessageFor(model => model.CreatedBy) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Name) %>
                <%: Html.ValidationMessageFor(model => model.Name) %>
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
                <%: Html.TextBoxFor(model => model.StartTime, String.Format("{0:g}", Model.StartTime)) %>
                <%: Html.ValidationMessageFor(model => model.StartTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.EndTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.EndTime, String.Format("{0:g}", Model.EndTime)) %>
                <%: Html.ValidationMessageFor(model => model.EndTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Duration) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Duration) %>
                <%: Html.ValidationMessageFor(model => model.Duration) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CreateTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CreateTime, String.Format("{0:g}", Model.CreateTime)) %>
                <%: Html.ValidationMessageFor(model => model.CreateTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.DeleteTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.DeleteTime, String.Format("{0:g}", Model.DeleteTime)) %>
                <%: Html.ValidationMessageFor(model => model.DeleteTime) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>


