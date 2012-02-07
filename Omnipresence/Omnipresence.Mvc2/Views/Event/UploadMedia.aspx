<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.UploadViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Upload Media
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Upload Media</h2>
    <% using (Html.BeginForm("UploadMedia", "Event", 
                    FormMethod.Post, new { enctype = "multipart/form-data" }))
        {%>

        <%:Html.HiddenFor(model => model.EventID) %>
        <input name="uploadFile" type="file" accept="image/*"/>
        <input type="submit" value="Upload File" />
<%} %>

<%: Html.ActionLink("Back", "Index", new { id = Model.EventID }) %>
 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
