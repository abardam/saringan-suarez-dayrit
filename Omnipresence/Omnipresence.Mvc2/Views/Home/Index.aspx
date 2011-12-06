<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
<script type="text/javascript">
        $.get('<%=Url.Action("Index","Sidebar") %>', function (d) {
            sideShow(d);
        });
</script>
</asp:Content>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
            <%--<a class="sidebar-link sidebar-button" href="<%= Url.Action("Index","Sidebar") %>" onclick="">Home</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick="">Profile</a>--%>
            <div id="login-widget">
                <%
                    if (!Request.IsAuthenticated)
                    {
                %>
                <span class="small-text"><a class="sidebar-link sidebar-button" href="<%= Url.Action("Login","Sidebar") %>"
                    onclick="">Login</a> | <a class="sidebar-link sidebar-button" href="<%= Url.Action("Register","Sidebar",new{id=1}) %>"
                        onclick="">Register</a></span>
                <%
                    }
                    else
                    {
                %>
                <span class="small-text">Logged in as:
                    <%=Page.User.Identity.Name %>
                    | <a class="" href="<%= Url.Action("LogOff","Account") %>" onclick="">Logout</a></span>
                <%
                    }
                %>
            </div>
            <br />
            <% if (Request.IsAuthenticated)
               {%>
            <div id="sidebar-nav">
                <a class="sidebar-button" href="" onclick="">
                    <img class="button unselected" src="../../Content/Images/newevent.png" alt="New Event" /></a><span
                        class="helper">(post event)<br />
                    </span><a class="sidebar-link sidebar-button" href="<%= Url.Action("Search","Sidebar") %>"
                        onclick="">
                        <img class="button unselected" src="../../Content/Images/findevent.png" alt="Search" /></a><span
                            class="helper">(find event)<br />
                        </span><a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{username = Page.User.Identity.Name }) %>"
                            onclick="">
                            <img class="button unselected" src="../../Content/Images/viewprofile.png" alt="My Profile" /></a><span
                                class="helper">(view profile)<br />
                            </span>
            </div>
            <% } %>
            <div id="sidebar" class="">
            </div>
</asp:Content>
<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
