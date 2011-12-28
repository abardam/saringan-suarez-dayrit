<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.EditProfileViewModel>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit

    

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <script type="text/javascript" src="../../Content/Scripts/datepicker-custom.js"></script>

    <script type="text/javascript" language="javascript">
        function realInitialize() {
            setDatePicker("BirthdateMonth", "BirthdateDate", "BirthdateYear", "<%=Model.BirthdateMonth %>");
        }
    </script>

    <h2>Edit</h2>

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
                <%: Html.DropDownListFor(model => model.BirthdateDay, (SelectList)ViewData["days"]) %>
                <%: Html.DropDownListFor(model => model.BirthdateMonth, Model.Months) %>
                <%: Html.DropDownListFor(model => model.BirthdateYear, (SelectList)ViewData["years"]) %>
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


    <div>
        <%: Html.ActionLink("Back to Profile", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

