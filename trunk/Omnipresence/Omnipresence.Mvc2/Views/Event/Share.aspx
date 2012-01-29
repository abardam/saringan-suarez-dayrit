<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.ShareEventViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Share
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Share</h2>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            
            Enter the usernames, separated by commas.
            
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.SharedIDList) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.SharedIDList) %>
                <%: Html.ValidationMessageFor(model => model.SharedIDList) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Message) %>
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.Message) %>
                <%: Html.ValidationMessageFor(model => model.Message) %>
            </div>
            
            <p>
                <input type="submit" value="Send" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

