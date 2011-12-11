<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Processing.UserProfileModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit</h2>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        <p><%= Html.Encode(ViewData["Message"]) %></p>
        <fieldset>
                <%: Html.HiddenFor(model => model.UserProfileId) %>
            
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
                <%: Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Description) %>
                <%: Html.ValidationMessageFor(model => model.Description) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Birthdate) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Birthdate, String.Format("{0:g}", Model.Birthdate)) %>
                <%: Html.ValidationMessageFor(model => model.Birthdate) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.IsFemale) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.IsFemale) %>
                <%: Html.ValidationMessageFor(model => model.IsFemale) %>
            </div>
                <%: Html.HiddenFor(model => model.Reputation) %>
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to Profile", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

