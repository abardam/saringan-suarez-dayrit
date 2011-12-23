<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.EditProfileViewModel>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit

    

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script language="javascript" type="text/javascript">
        window.onload = function () {
            var monthSelect = document.getElementById("BirthdateMonth");
            monthSelect.onchange = setDays;
            document.getElementById("BirthdateYear").onchange = setDays;
            document.getElementById("BirthdateMonth").remove(12);

            for(var i = 0; i < monthSelect.length;i++){
                if(monthSelect.options.item(i).text == "<%= Model.BirthdateMonth %>"){
                    monthSelect.selectedIndex = i;
                    break;
                }
            }

            monthSelect.remove(12);

            setDays();

        }

        function setDays() {
            var daySelect = document.getElementById("BirthdateDay");
            var monthSelect = document.getElementById("BirthdateMonth");
            var yearSelect = document.getElementById("BirthdateYear");

            var selectedYear = yearSelect.options.item(yearSelect.selectedIndex).value;


            var numDays;
            switch (monthSelect.selectedIndex) {
                case 0:
                case 2:
                case 4:
                case 7:
                case 9:
                case 11:
                    numDays = 31;
                    break;
                case 3:
                case 5:
                case 6:
                case 8:
                case 10:
                    numDays = 30;
                    break;
                default:
                    if (selectedYear % 4 == 0 && (selectedYear % 100 != 0 || selectedYear % 400 == 0)) {
                        numDays = 29;
                    }
                    else {
                        numDays = 28;
                    }
            }
            while (daySelect.length < numDays) {
                var option = document.createElement("option");
                option.text = (daySelect.length + 1);
                daySelect.add(option);
            }
            while (daySelect.length > numDays) {
                daySelect.remove(daySelect.length - 1);
            }

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

