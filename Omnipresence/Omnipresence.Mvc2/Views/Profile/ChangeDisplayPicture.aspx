<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.ChangeDisplayPictureModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ChangeDisplayPicture
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>ChangeDisplayPicture</h2>
    <% using (Html.BeginForm("ChangeDisplayPicture", "Profile", 
                    FormMethod.Post, new { enctype = "multipart/form-data" }))
        {%>

        <%:Html.HiddenFor(model => model.UserProfileID) %>
        <input name="uploadFile" type="file" accept="image/*"/>
        <input type="submit" value="Upload File" />
<%} %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
