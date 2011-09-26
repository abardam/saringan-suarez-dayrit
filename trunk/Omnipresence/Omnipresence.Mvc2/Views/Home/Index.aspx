<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
    <script type="text/javascript">
        function sideShow(d) { $("#sidebar").fadeOut(200, function () { $('#sidebar').html(d); $('#sidebar').fadeIn(200); }); }
        
        $('.sidebar-button').live('click', function(event) {
            event.preventDefault();
        });
        
        $('.sidebar-link').live("click", function (event) {
            

            $.get(event.currentTarget, function (d) {
                sideShow(d);
            });
        });

        function showNewEvent() {
            $.get('<%= Url.Action("NewEvent","Sidebar") %>', function (d) {
                sideShow(d);
            });
        }
    </script>
</asp:Content>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div id="map_container">
        <div id="sidebar-big">
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Index","Sidebar",new{id = 1}) %>" onclick="">Home</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick="">Profile</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Login","Sidebar",new{id=1}) %>" onclick="">Login</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Register","Sidebar",new{id=1}) %>" onclick="">Register</a>
        <br />
            <a class="sidebar-button" href="" onclick="setNodeMode(true)"><img class="button" src="../../Content/Images/newevent.png" /></a>
            <a class="sidebar-link sidebar-button" href="<%= Url.Action("NewEvent","Sidebar") %>" onclick=""><img class="button" src="../../Content/Images/findevent.png" /></a>
            <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick=""><img class="button" src="../../Content/Images/viewprofile.png" /></a>
            <div id="sidebar" class="">
            </div>
        </div>
        <div id="map_canvas">
        </div>
    </div>
</asp:Content>
<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>