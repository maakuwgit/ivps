<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Calendar.aspx.vb" Inherits="admin_Events_Calendar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .Calendar{width:100%;}
        .Day{height:100px; text-align:left; vertical-align:top;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:Calendar CssClass="Calendar" DayStyle-CssClass="Day" runat="server" id="Cal"></asp:Calendar>
</asp:Content>