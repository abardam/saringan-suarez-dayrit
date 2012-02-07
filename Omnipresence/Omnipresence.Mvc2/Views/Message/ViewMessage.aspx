<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.MessageViewModel>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <fieldset>
        
        <div class="display-label">SenderName</div>
        <div class="display-field"><%: Model.SenderName %></div>
        
        <div class="display-label">Message</div>
        <div class="display-field"><%: Model.Message %></div>
        
        <div class="display-label">EventName</div>
        <div class="display-field"><% if (Model.EventName != null)
               { %>
                <%: Html.ActionLink(Model.EventName, "Index", "Event", new { id = Model.EventID }, null)%>
                <%} %></div>
        
    </fieldset>

</asp:Content>

