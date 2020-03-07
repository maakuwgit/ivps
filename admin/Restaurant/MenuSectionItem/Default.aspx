<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="../module.aspx"-->
	<%
		active = "sectionitem"
	%>
	<!--#include file="../tabs.aspx"-->
	<div class="container-fluid">
		
		<div class="row">
		 <div class="jumbotron pb-0 pt-3 mb-3 w-100">
		 <div class="col-12 ">
		 <div class="form-group">
		    	<div class="input-group mb-2 mr-sm-2">
			    <div class="input-group-prepend">
			      	<button class="btn btn-secondary border-none" type="button" onclick="$('#searchableTableText').val('');$('#searchableTableText').keyup();">X</button>
			    </div>
			    <input type="text" class="form-control" id="searchableTableText" " placeholder="<%= filterPlaceholder %>">
			  </div>
		  </div>
		</div>
		</div>
		</div>
		
		<div class="row">
		<table class="table table-striped table-bordered table-hover border-top-0" id="searchableTable">
			<thead>
				<tr>
					<th scope="col">Id</th>
					<th scope="col">Menu</th>
					<th scope="col">Section</th>
					<th scope="col">Number of Items</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
			<%
				For Each row As DataRow In dt.Rows
			%>
				<tr onclick="document.location='<%= baseurl %>/MenuSectionItem/edit.aspx?id=<%= row("id") %>'" style="cursor:pointer;">
					<td><%= row("id") %></td>
					<td class="col-"><%= row("MenuName") %></td>
					<td class="col-"><%= row("SectionName") %></td>
					<td class="col"><%= row("MenuSectionItemCount") %></td>
					<td class="text-right">
							<div class="btn-group" role="group" aria-label="Basic example">
							<a class="btn btn-outline-danger" title="Delete" href="?a=d&id=<%= row("id") %>" onclick="return confirm('Are you sure you want to delete this item?');"><i class="far fa-trash-alt"></i></a>
							<a class="btn btn-outline-success" title="Edit" href="<%= baseurl %>/MenuSectionItem/edit.aspx?id=<%= row("id") %>"><i class="fas fa-edit"></i></a>
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
							