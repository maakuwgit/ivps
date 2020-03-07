<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Edit.aspx.vb" Inherits="Menu_Edit" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="../module.aspx"-->
	<%
		active = "item"
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
				  <div class="custom-file">
					<asp:FileUpload runat="server" ID="fileUploadImage" class="custom-file-input" accept="image/png, image/jpeg, image/jpg" onchange="$('.custom-file-label').text($(this).val().replace(/C:\\fakepath\\/i, ''));"></asp:FileUpload>
					<label class="custom-file-label" for="inputGroupFile01">Choose Image</label>
				  </div>
			  </div>
			  <div class="form-group">
			  	<% If dt.rows(0)("img").ToString.Length > 0 Then %>
				  <img src="<%= baseurl %>/img.ashx?id=<%= dt.rows(0)("id") %>&h=200" class="border">
				  <% End If %>
			  </div>
			  <div class="form-group">
			    	<div class="custom-control custom-checkbox">
				  	<input type="checkbox" class="custom-control-input" id="customCheck1" value="1" name="deleteimg">
				  	<label class="custom-control-label" for="customCheck1" name="deleteimg">Delete Image</label>
				</div>
			  </div>
			  <asp:Button type="submit" class="btn btn-primary" runat="server" ID="btnSave" text="Save"/>
			  <asp:Button type="submit" class="btn btn-outline-primary" runat="server" ID="btnSaveClose" text="Save & Close"/>
			  <asp:Button class="btn btn-outline-secondary" runat="server" ID="btnClose" text="Close"/>
		</form>
	</div>
</asp:Content>