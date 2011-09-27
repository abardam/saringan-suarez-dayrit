<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
    <script type="text/javascript">
        $.get('<%=Url.Action("Index","Sidebar") %>', function (d) {
            sideShow(d);
        });

        function showNewEvent() {
            $.get('<%= Url.Action("NewEvent","Sidebar") %>', function (d) {
                sideShowNew(d, function () {
                    $('#Latitude').attr("disabled", "disabled");
                    $('#Longitude').attr("disabled", "disabled");
                });

            });
        }
    </script>
</asp:Content>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div id="map_container">
        <div id="sidebar-big">
        <%--<a class="sidebar-link sidebar-button" href="<%= Url.Action("Index","Sidebar") %>" onclick="">Home</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick="">Profile</a>--%>
        <div id="login-widget">
        
<%
    if (!Request.IsAuthenticated)
    {
%>
        <span class="small-text"><a class="sidebar-link sidebar-button" href="<%= Url.Action("Login","Sidebar") %>" onclick="">Login</a> | <a class="sidebar-link sidebar-button" href="<%= Url.Action("Register","Sidebar",new{id=1}) %>" onclick="">Register</a></span>
<%
    }
    else
    {
%>
        <span class="small-text">Logged in as: <%=Page.User.Identity.Name %> | <a class="" href="<%= Url.Action("LogOff","Account") %>" onclick="">Logout</a></span>
<%
    }
%>
</div>
        <br />
        <% if (Request.IsAuthenticated)
           {%>
        <div id="sidebar-nav">
            <a class="sidebar-button" href="" onclick=""><img class="button unselected" src="../../Content/Images/newevent.png" alt="New Event"/></a><span class="helper">(post event)<br /></span>
            <a class="sidebar-link sidebar-button" href="<%= Url.Action("Search","Sidebar") %>" onclick=""><img class="button unselected" src="../../Content/Images/findevent.png" alt="Search"/></a><span class="helper">(find event)<br /></span>
            <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick=""><img class="button unselected" src="../../Content/Images/viewprofile.png" alt="My Profile"/></a><span class="helper">(view profile)<br /></span>
        </div>
        <% } %>
            <div id="sidebar" class="">
            </div>
        </div>
        <div id="map_canvas">
        </div>
    </div>
</asp:Content>
<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>