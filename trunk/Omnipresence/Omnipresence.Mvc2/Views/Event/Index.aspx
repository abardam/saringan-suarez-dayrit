<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.EventCommentViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        <%: Model.Title %></h1><p><%:Html.ActionLink(Model.CreatorUsername, "Profile","Profile", new {id = Model.CreatorUsername}, null)%></p>
    <div id="map<%: Model.EventId %>" data-lat="<%:Model.Latitude %>" data-lng="<%:Model.Longitude %>"
        style="background-position: center; width: 100%; height: 200px; margin-top:20px; margin-bottom:20px;
    ">
    </div>
    <script type="text/javascript">
        function realInitialize() {
            setMap("map<%:Model.EventId %>", "<%:Model.Title %>", "<%:Model.CategoryString.ToLower() %>");
        }
    </script>
    <div>
        <h3>
            <%: Model.Description %></h3>
    </div>
    <div>
        <p>
            Start date: <%: String.Format("{0:D}", Model.StartTime) %> </p>
            <p>
            End date: <%:String.Format("{0:D}", Model.EndTime) %></p>
    </div>
    <div>
        <p>
            Rating:
            <%: Model.Rating %></p>
    </div>
    <% if (Model.CreatedByUser)
       { %><p><%: Html.ActionLink("Edit", "Edit", new { id = Model.EventId })%></p><%}
       else
       {
           %><p><%:Html.ActionLink("Vote up", "VoteUp", new { id = Model.EventId }) %> | <%:Html.ActionLink("Vote down", "VoteDown", new { id = Model.EventId }) %></p><%
                                                                                                                                                                 } %>
    <p><%: Html.ActionLink("Share", "Share", new { id = Model.EventId })%></p>
    <div class="section">
    <h1>
        Media</h1>
    <p><%: Html.ActionLink("Upload media", "UploadMedia", new { id = Model.EventId }) %></p>
    <p><%: Html.ActionLink("View all media", "Media", new { id = Model.EventId }) %></p>
    </div>
    <div class="section">
    <h1>
        Comments</h1>
        <table style="width:100%;font-size:1em;">
    <% foreach (Omnipresence.Mvc2.Models.CommentViewModel cm in Model.CommentList)
       {
    %>
    <tr><td>
        <h2 style="float:left; clear:both;"><%= cm.CommenterName %> says:</h2></td></tr><tr><td>
        <p style="float:left"><%= cm.CommentText %>(<%=String.Format("{0:D}",cm.TimeString) %>)
        <% if (cm.UserIsAuthor)
           { %>[<%:Html.ActionLink("x","Delete","Comment", new {id = cm.CommentId}, null) %>]<%} %></p>
           </td></tr>
    <%} %>
    <% if (!User.Identity.Name.Equals(""))
       {
           using (Html.BeginForm())
           { %>
           <tr><td>
    <%: Html.ValidationSummary(true)%></td></tr>
           <tr><td>
    <%: Html.TextAreaFor(model => model.NewComment)%></td></tr>
           <tr><td>
    <input type="submit" value="Comment" /></td></tr>
    <%}
       } %></table></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
