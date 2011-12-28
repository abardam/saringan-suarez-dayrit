﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Basic.Master" Inherits="System.Web.Mvc.ViewPage<Omnipresence.Mvc2.Models.CreateEventViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateEventView
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">        function realInitialize() {
            setMap("map");
            //document.getElementById("Longitude").readonly = true;
            //document.getElementById("Latitude").readonly = true;
        };
        </script>
    <h2>Create new event</h2>

    <div id="map" class="map-container" style="width:540px; height:400px; margin-left:auto; margin-right:auto" data-lat="14.632524261766926" data-lng="121.07566595077515" new="true"></div>

    <%=ViewData["message"] %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Title) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Title) %>
                <%: Html.ValidationMessageFor(model => model.Title) %>
            </div>
 
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Name) %>
                <%: Html.ValidationMessageFor(model => model.Name) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Description) %>
                <%: Html.ValidationMessageFor(model => model.Description) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.StartTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.StartTime) %>
                <%: Html.ValidationMessageFor(model => model.StartTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.EndTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.EndTime) %>
                <%: Html.ValidationMessageFor(model => model.EndTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Duration) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Duration) %>
                <%: Html.ValidationMessageFor(model => model.Duration) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CreateTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CreateTime) %>
                <%: Html.ValidationMessageFor(model => model.CreateTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.DeleteTime) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.DeleteTime) %>
                <%: Html.ValidationMessageFor(model => model.DeleteTime) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CategoryString) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CategoryString) %>
                <%: Html.ValidationMessageFor(model => model.CategoryString) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Address) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Address) %>
                <%: Html.ValidationMessageFor(model => model.Address) %>
            </div>
            
            <!--<div class="editor-label">
                <%: Html.LabelFor(model => model.Latitude) %>
            </div>
            <div class="editor-field">-->
                <%: Html.HiddenFor(model => model.Latitude) %>
                <!--<%: Html.ValidationMessageFor(model => model.Latitude) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Longitude) %>
            </div>
            <div class="editor-field">-->
                <%: Html.HiddenFor(model => model.Longitude) %>
                <!--<%: Html.ValidationMessageFor(model => model.Longitude) %>
            </div>-->
            
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>


<asp:Content ID="Content8" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

