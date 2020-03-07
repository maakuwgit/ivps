<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Edit.aspx.vb" Inherits="Menu_Edit" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="../module.aspx"-->
	<%
		active = "menusection"
	%>
	<!--#include file="../tabs.aspx"-->
	<div class="container-fluid">
		<form>
			<input type="hidden" name="id" value="<%= dt.rows(0)("id") %>">
			<input type="hidden" id="pv" name="published" value="<%= dt.rows(0)("published") %>">
			<div class="custom-control custom-checkbox mb-3">
			  <input type="checkbox" class="custom-control-input published" id="customCheck1" <%= iif(dt.rows(0)("published").tostring = "1", "checked", "") %>>
			  <label class="custom-control-label" for="customCheck1">Published</label>
			</div>
			  <div class="form-group">
			    <label>Menu</label>
			    <select class="custom-select" name="menu_id">
			    <option>Select the Menu</option>
			    <%
				For Each mrow As DataRow In menu.Rows
			   %>
			   	<option value="<%= mrow("id") %>" <%= iif(dt.rows(0)("menu_id").tostring() = mrow("id").tostring(), "selected", "") %>><%= mrow("name") %></option>
			   <%
				Next
			   %>
			   </select>
			  </div>
			  <div class="form-group">
			    <label>Section</label>
			    <select class="custom-select" name="section_id">
			    <option>Select the Section for the Menu</option>
			    <%
				For Each srow As DataRow In section.Rows
			   %>
			   	<option value="<%= srow("id") %>" <%= iif(dt.rows(0)("section_id").tostring() = srow("id").tostring(), "selected", "") %>><%= srow("name") %></option>
			   <%
				Next
			   %>
			   </select>
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