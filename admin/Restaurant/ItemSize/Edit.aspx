<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Edit.aspx.vb" Inherits="Menu_Edit" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="../module.aspx"-->
	<%
		active = "size"
	%>
	<!--#include file="../tabs.aspx"-->
	<div class="container-fluid">
		<form>
			<input type="hidden" name="id" value="<%= dt.rows(0)("id") %>">
			  <div class="form-group">
			    <label>Name</label>
			    <input type="text" class="form-control" name="name" value="<%= dt.rows(0)("name") %>">
			  </div>
			  <asp:Button type="submit" class="btn btn-primary" runat="server" ID="btnSave" text="Save"/>
			  <asp:Button type="submit" class="btn btn-outline-primary" runat="server" ID="btnSaveClose" text="Save & Close"/>
			  <asp:Button class="btn btn-outline-secondary" runat="server" ID="btnClose" text="Close"/>
		</form>
	</div>
</asp:Content>