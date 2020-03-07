<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>
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
		
		<div class="row">
		<a class="btn btn-secondary mb-3" title="Edit" href="<%= baseurl %>/menu/edit.aspx"><i class="fas fa-plus-circle"></i> Menu</a>
		<table class="table table-striped table-bordered table-hover border-top-0">
			<thead>
				<tr>
					<th scope="col">Pub</th>
					<th scope="col">Id</th>
					<th scope="col">Name</th>
					<th scope="col">Description</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
			<%
				For Each row As DataRow In dt.Rows
			%>
				<tr onclick="document.location='<%= baseurl %>/menu/edit.aspx?id=<%= row("id") %>'" style="cursor:pointer;">
					<td title="Published"><input type="checkbox" class="published-ajax"  <%= iif(row("published").ToString = "1", "checked", "") %> data-id="<%= row("id") %>" data-tbl="mnuMenu"></td>
					<td><%= row("id") %></td>
					<td><%= row("name") %></td>
					<td class="col"><%= WordLimit(row("Description"), 50) %></td>
					<td class="text-right">
							<div class="btn-group" role="group" aria-label="Basic example">
							<a class="btn btn-outline-danger" title="Delete" href="?a=d&id=<%= row("id") %>" onclick="return confirm('Are you sure you want to delete this item?');"><i class="far fa-trash-alt"></i></a>
							<a class="btn btn-outline-success" title="Edit" href="<%= baseurl %>/menu/edit.aspx?id=<%= row("id") %>"><i class="fas fa-edit"></i></a>
						</div>
					</td>
				</tr>
			<%
				Next
			%>
			</tbody>
		</table>
		</div>
	</div>
</asp:Content>
							