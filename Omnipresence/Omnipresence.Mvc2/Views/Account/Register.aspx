<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.RegisterModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="../../Scripts/omnimap-registration.js"></script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Register</h3>
    <p>
        You're one step away from creating your own account. <%: Html.ActionLink("Sign in", "LogOn") %> if you already have an account.
    </p>
    <% using (Html.BeginForm()) { %>
        <%: Html.ValidationSummary(true, "Account creation was unsuccessful. Please correct the errors and try again.")%>
        <div>
            <fieldset>
                
                <div class="editor-label">
                    <label id="username-label" for="username">
                        Username
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.TextBoxFor(m => m.UserName)%>
                </div>
                <div class="validation-field">
                    <label id="username-validation" />
                </div>

                <div class="editor-label">
                    <label id="email-label" for="email">
                        Email
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.TextBoxFor(m => m.Email)%>
                </div>
                <div class="validation-field">
                    <label id="email-validation" />
                </div>

                <div class="editor-label">
                    <label id="password-label" for="password">
                        Password
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.PasswordFor(m => m.Password)%>
                </div>
                <div id="validation-field">
                    <label id="password-validation" />
                </div>

                <div class="editor-label">
                    <label id="confirm-password-label" for="confirm-password">
                        Confirm Password
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.PasswordFor(m => m.ConfirmPassword)%>                 
                </div>
                <div class="validation-field">
                    <label id="confirm-password-validation" />
                </div>

                <div class="editor-label">
                    <label id="first-name-label" for="first-name">
                        First Name
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.TextBoxFor(m => m.FirstName)%>
                </div>
                <div class="validation-field">
                    <label id="first-name-validation" />
                </div>

                <div class="editor-label">
                    <label id="last-name-label" for="last-name">
                        Last Name
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.TextBoxFor(m => m.LastName)%>
                </div>
                <div class="validation-field">
                    <label id="last-name-validation" />
                </div>

                <div class="editor-label">
                    <label id="birthdate-label" for="birthdate">
                        Birthdate
                    </label>
                </div>
                <div class="editor-field">
                    <%:Html.TextBoxFor(m => m.Birthdate)%>
                </div>
                <div class="validation-field">
                    <label id="birthdate-validation" />
                </div>

                <p>
                    <input id="register-button" type="submit" value="Register"/>
                </p>
            </fieldset>
        </div>
    <%} %>
</asp:Content>
