<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Omnipresence.Processing.UserProfileModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Friends
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Friends</h1>

    <table>
        

    <% foreach (var item in Model) { %>
    
        <p><a href="/Profile/Index/<%=item.UserProfileId %>"><%: item.FirstName %> <%: item.LastName %></a></p>
    
    <% } %>

    </table>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

