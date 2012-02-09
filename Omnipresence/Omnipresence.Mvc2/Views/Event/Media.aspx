<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/BasicNoScripts.Master"
    Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.MediaPageViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Media
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $.noConflict();
    </script>
    <h2>
        Media</h2>
    <div class="section">
        <%if ((Model.Images.Count() == 0 && (Model.Videos.Count() == 0)))
          {%><h3>
            There are no media to display.</h3>
        <%} %>
        <p>
            <%: Html.ActionLink("Upload media", "UploadMedia", new { id = Model.EventID }) %></p>
        <p>
            <%: Html.ActionLink("Back to Event", "Index", "Event", new { id = Model.EventID }, null) %></p>
        <%if (Model.Images.Count() > 0)
          { %>
        <h1>
            Images</h1>
        <table style="width: 100%;">
            <tr>
                <%int x = 0; foreach (Omnipresence.Processing.MediaItemModel b in Model.Images)
                  { %>
                <td>
                    <a href="<%:Url.Content("~/Uploads/Images/")+b.FileName %>" rel="lightbox" title="by <%:b.UploaderUsername %>">
                        <img src="<%:Url.Content("~/Uploads/Images/")+b.FileName %>" alt="<%: b.FileName %>"
                            class="tn" /></a>
                </td>
                <%if (++x == 4)
                  {
                      x = 0;%>
            </tr>
            <tr>
                <%} %>
                <%} %>
            </tr>
        </table>
    </div>
    <%} if (Model.Videos.Count() > 0)
          {%>
    <div class="section">
        <h1>
            Videos</h1>
        <table style="width: 100%;">
            <tr>
                <%int x = 0; foreach (Omnipresence.Processing.MediaItemModel b in Model.Videos)
                  { %>
                <td>
                    <video width="320" height="240" controls="controls" src="<%:Url.Content("~/Uploads/Videos/")+b.FileName %>" />
                    Your browser does not support the video tag. </video>
                </td>
                <%if (++x == 2)
                  {
                      x = 0;%>
            </tr>
            <tr>
                <%} %>
                <%} %>
            </tr>
        </table>
    </div>
    <%} %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        img.tn
        {
            max-width: 100px;
            max-height: 100px;
        }
    </style>
    <script type="text/javascript" src="/Content/Scripts/Lightbox/js/prototype.js"></script>
    <script type="text/javascript" src="/Content/Scripts/Lightbox/js/scriptaculous.js?load=effects,builder"></script>
    <script type="text/javascript" src="/Content/Scripts/Lightbox/js/lightbox.js"></script>
    <link rel="stylesheet" href="/Content/Scripts/Lightbox/css/lightbox.css" type="text/css"
        media="screen" />
</asp:Content>
