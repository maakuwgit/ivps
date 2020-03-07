<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Edit.aspx.vb" Inherits="Menu_Edit" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="../module.aspx"-->
	<%
		active = "include"
	%>
	<!--#include file="../tabs.aspx"-->
	<div class="container-fluid">
		<form>
			<input type="hidden" name="id" value="<%= dt.rows(0)("id") %>">
			  <div class="form-group">
			    <label>Includes</label>
			    <textarea type="password" class="form-control"name="description" rows="10"><%= dt.rows(0)("items") %></textarea>
			  </div>
			  <asp:Button type="submit" class="btn btn-primary" runat="server" ID="btnSave" text="Save"/>
			  <asp:Button type="submit" class="btn btn-outline-primary" runat="server" ID="btnSaveClose" text="Save & Close"/>
			  <asp:Button class="btn btn-outline-secondary" runat="server" ID="btnClose" text="Close"/>
		</form>
	</div>
</asp:Content>