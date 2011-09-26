<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
    <script type="text/javascript">

        
        function sideShowNew(d, func) { $("#sidebar").fadeOut(200, function () { $('#sidebar').html(d); $('#sidebar').fadeIn(200, func); }); }
        function sideShow(d) { sideShowNew(d, null) }

        $('.sidebar-button').live('click', function (event) {
            event.preventDefault();

            $('img.selected').css('display', 'none');
            $('img.unselected').css('display', 'inline');

            jQuery('img.unselected', this).css('display', 'none');
            jQuery('img.selected', this).css('display', 'inline');

            $('.helper').css('display', 'none');
        });
        
        $('.sidebar-link').live("click", function (event) {
            

            $.get(event.currentTarget, function (d) {
                sideShow(d);
            });
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
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Index","Sidebar",new{id = 1}) %>" onclick="">Home</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick="">Profile</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Login","Sidebar",new{id=1}) %>" onclick="">Login</a>
        <a class="sidebar-link sidebar-button" href="<%= Url.Action("Register","Sidebar",new{id=1}) %>" onclick="">Register</a>
        <br />
            <a class="sidebar-button" href="" onclick="setNodeMode(true)"><img class="button unselected" src="../../Content/Images/newevent.png" /><img class="button selected" src="../../Content/Images/newevent-selected.png" /></a><span class="helper">(post event)<br /></span>
            <a class="sidebar-link sidebar-button" href="<%= Url.Action("NewEvent","Sidebar") %>" onclick=""><img class="button unselected" src="../../Content/Images/findevent.png" /><img class="button selected" src="../../Content/Images/findevent-selected.png" /></a><span class="helper">(find event)<br /></span>
            <a class="sidebar-link sidebar-button" href="<%= Url.Action("Profile","Sidebar",new{id = 1}) %>" onclick=""><img class="button unselected" src="../../Content/Images/viewprofile.png" /><img class="button selected" src="../../Content/Images/viewprofile-selected.png" /></a><span class="helper">(view profile)<br /></span>
            <div id="sidebar" class="">
            </div>
        </div>
        <div id="map_canvas">
        </div>
    </div>
</asp:Content>
<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>