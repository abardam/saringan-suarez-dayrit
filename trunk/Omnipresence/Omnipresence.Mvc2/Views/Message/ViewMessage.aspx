<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.MessageViewModel>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <fieldset>
        
        <h3><%: Model.SenderName %> said:</h3>

        <div class="display-field"><%: Model.Message %></div>
        


        <div class="display-field"><% if (Model.EventName != null)
               { %>
               Attached event:
                <%: Html.ActionLink(Model.EventName, "Index", "Event", new { id = Model.EventID }, null)%>
                <%} %></div>
        
    </fieldset>

</asp:Content>

