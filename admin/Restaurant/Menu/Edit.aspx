<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Edit.aspx.vb" Inherits="Menu_Edit" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="../module.aspx"-->
	<%
		active = "menu"
	%>
	<!--#include file="../tabs.aspx"-->
	<div class="container-fluid">
		<form>
			<input type="hidden" name="id" value="<%= dt.rows(0)("id") %>">
			  <div class="form-group">
			    <label>Name</label>
			    <input type="text" class="form-control" name="name" value="<%= dt.rows(0)("name") %>">
			  </div>
			  <div class="form-group">
			    <label for="">Description</label>
			    <textarea type="password" class="form-control"name="description" rows="10"><%= dt.rows(0)("description") %></textarea>
			  </div>
			  <div class="form-group">
			    <label>Order online url</label>
			    <input type="text" class="form-control" name="order_online_url" value="<%= dt.rows(0)("order_online_url") %>">
			  </div>
			  <asp:Button type="submit" class="btn btn-primary" runat="server" ID="btnSave" text="Save"/>
			  <asp:Button type="submit" class="btn btn-outline-primary" runat="server" ID="btnSaveClose" text="Save & Close"/>
			  <asp:Button class="btn btn-outline-secondary" runat="server" ID="btnClose" text="Close"/>
		</form>
	</div>
</asp:Content>