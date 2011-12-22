<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Processing.EventModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit</h2>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.EventId) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.EventId) %>
                <%: Html.ValidationMessageFor(model => model.EventId) %>
            </div>
            
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
                <%: Html.LabelFor(model => model.IsPrivate) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.IsPrivate) %>
                <%: Html.ValidationMessageFor(model => model.IsPrivate) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.IsActive) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.IsActive) %>
                <%: Html.ValidationMessageFor(model => model.IsActive) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.LastModified) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.LastModified, String.Format("{0:g}", Model.LastModified)) %>
                <%: Html.ValidationMessageFor(model => model.LastModified) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Created) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Created, String.Format("{0:g}", Model.Created)) %>
                <%: Html.ValidationMessageFor(model => model.Created) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Rating) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Rating) %>
                <%: Html.ValidationMessageFor(model => model.Rating) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CreatedById) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CreatedById) %>
                <%: Html.ValidationMessageFor(model => model.CreatedById) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

