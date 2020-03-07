<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Events.aspx.vb" Inherits="admin_Events_Events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Events</h1>
    <input type="button" value="Calendars" onclick="location.href='/admin/Events/Default.aspx'" />
    <input type="button" value="Events" onclick="location.href='/admin/Events/Events.aspx'" />
    <input type="button" value="Permissions" onclick="location.href='/admin/Events/Permissions.aspx'" /><br /><br />
</asp:Content>

