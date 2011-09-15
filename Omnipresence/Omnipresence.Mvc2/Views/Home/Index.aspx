<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="Title" runat="server">
    Omnipresence
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <script src="../../Scripts/jquery-1.4.1.js"> </script>
    <script type="text/javascript" src="../../Scripts/omnimap-scripts.js"></script>
</asp:Content>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
    <div class="banner">
        <h1>Omnipresence: A Location Based Social Network</h1>
    </div>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
<div id="map_container">
    <div id="event_info" class="">
    <div id="error" class="toggle">
    <span class="header">An error has occured.</span>
    <span class="header-2">Click anywhere to continue.</span>
    <span class="text">I am filler text.</span>
    </div>
    <div id="default" class="toggled">
    <span class="header">This is the map.</span>
    <span class="header-2">Click anywhere to continue.</span>
    <span class="text">I am filler text.</span>
    </div>

    <div id="new_event" class="toggle">
    <span class="header">Name of Event</span>
    <div id="votes">
        <button id="upVote" name="upvoteButton" type="button">++</button>
        <button name="downvoteButton" type="buttom">--</button>
    </div>
    
    <span class="header-2">Location:</span><span class="content">coordinates</span>
    
    <div id="type_selector">
    <span class="header-2">Type:</span>
    <form name="edit_type">
    <select name="sel_type">
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
    <option value="4">Option 4</option>
    </select>
    <input id="changeEventTypeButton" type="button" value="Change" onClick="changeType(' + markerNum + ', this.form)">
    </form>
    </div>
    
    <div id="description">
    <span class="header-2">Description: </span>
    <span class="content">Lorem ipsum dolor sit amet </span>
    </div>

    <div id="editDescription">
    <form name="edit' + markerNum + '" action="" >
    <textarea id="editDescriptionTextArea">Enter new description</textarea><br />
    <input value ="Edit!" type="button" onclick="editDescription(' + markerNum + ', this.form)"/>
    </form>
    </div>

    <div id="comment-box"><span class="header-2">Comments</span>
    <div id="comments">
    I am a comment</div>
    </div>

    <div id="add-comment-box"><form name="comment" action="">
    <textarea id="commentTextArea">Add new comment</textarea><br />
    <input value ="Comment!" type="button" onclick="addComment(' + markerNum + ', this.form)"/>
    </form></div>
    </div>
    </div>
    <div id="map_canvas">
    </div>
</div>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
