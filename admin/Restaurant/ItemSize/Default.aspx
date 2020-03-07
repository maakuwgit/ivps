<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>
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
		
		<div class="row">
		<a class="btn btn-secondary mb-3" title="Edit" href="<%= baseurl %>/itemsize/edit.aspx"><i class="fas fa-plus-circle"></i> Size</a>
		<table class="table table-striped table-bordered table-hover border-top-0">
			<thead>
				<tr>
					<th scope="col">Id</th>
					<th scope="col">Name</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
			<%
				For Each row As DataRow In dt.Rows
			%>
				<tr>
					<td><%= row("id") %></td>
					<td class="col"><a href="<%= baseurl %>/itemsize/edit.aspx?id=<%= row("id") %>"><%= row("name") %></a></td>
					<td class="text-right">
							<div class="btn-group" role="group" aria-label="Basic example">
							<a class="btn btn-outline-danger" title="Delete" href="?a=d&id=<%= row("id") %>" onclick="return confirm('Are you sure you want to delete this item?');"><i class="far fa-trash-alt"></i></a>
							<a class="btn btn-outline-success" title="Edit" href="<%= baseurl %>/itemsize/edit.aspx?id=<%= row("id") %>"><i class="fas fa-edit"></i></a>
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
							