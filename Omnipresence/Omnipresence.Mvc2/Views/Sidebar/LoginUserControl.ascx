<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Omnipresence.Mvc2.Models.LogOnModel>" %>
<% // TODO: Write this (LoginUserControl) %>
<div class="control-container">
<% if (!Request.IsAuthenticated)
   { %>
<span class="header-2">
    Log On</span>
<span class="content">
    Please enter your username and password.
    <%: Html.ActionLink("Register", "Register")%>
    if you don't have an account.
</span>
<% using (Html.BeginForm())
   { %>
<%: Html.ValidationSummary(true, "Login was unsuccessful. Please correct the errors and try again.")%>
<div>
    <fieldset>
        <legend>Account Information</legend>
        <div class="editor-label">
            <%: Html.LabelFor(m => m.UserName)%>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(m => m.UserName)%>
            <%: Html.ValidationMessageFor(m => m.UserName)%>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(m => m.Password)%>
        </div>
        <div class="editor-field">
            <%: Html.PasswordFor(m => m.Password)%>
            <%: Html.ValidationMessageFor(m => m.Password)%>
        </div>
        <div class="editor-label">
            <%: Html.CheckBoxFor(m => m.RememberMe)%>
            <%: Html.LabelFor(m => m.RememberMe)%>
        </div>
        <p>
            <input type="submit" value="Log On" />
        </p>
    </fieldset>
</div>
<% } %>
<%}
   else
   { %>
<span class="header">Login</span>
<span class="header-2">You are already logged in as <%=Page.User.Identity.Name %>.</span>
<%} %>
</div>