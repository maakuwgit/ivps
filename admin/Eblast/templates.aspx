<%@ Page MasterPageFile="~/admin/Admin.master" Language="VB" CodeFile="templates.aspx.vb" Inherits="Admin_emailCenter_templates" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

<div id="container">

<div style="width:50%;text-align:left;float:left;">
    <h1>Eblast Templates</h1>
</div>
<div style="width:50%;text-align:right;float:left;">
    &raquo;&nbsp;<a href="template.aspx" class="_link">Add a New Template</a>
</div>
<div style="clear:both;"></div>
<%  Response.WriteFile("nav.html")%>
<asp:PlaceHolder ID="plh" runat="server" />

</div>

</asp:Content>