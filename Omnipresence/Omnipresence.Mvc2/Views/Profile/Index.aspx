<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.ProfileViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<img src=<%:Model.Avatar %> alt=""/>
<h1><%: Model.FirstName %> <%: Model.LastName %></h1>
<h2><%:Model.Description %></h2>
<p><%:Model.GenderText %></p>
<p>Date of birth: <%:Model.Birthdate.ToLongDateString() %></p>
<p>Reputation: <%:Model.Reputation %></p>
<% if (!Page.User.Identity.Name.Equals(""))
   {
       if (Model.ViewingOwn)
       { %>

<%: Html.ActionLink("edit", "Edit")%>
<%}
       else
       {
           if (Model.ViewingFriend)
           {
               %>
               <p>Friend. </p>
               <%}
           else if (Model.ThisDudeHasSentAFriendRequestToYou)
           {
               %><p>Friend request pending. <a href="/Friends/Add/<%=Model.UserProfileId%>">Confirm.</a> Reject.</p><%
    }
           else if (Model.FriendRequested)
           {
               %><p>Friend request sent!</p><%
    }
           else
           { %>
       <p><a href="/Friends/Add/<%=Model.UserProfileId%>">Add as friend</a></p>
    <%}
       }
   } %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
