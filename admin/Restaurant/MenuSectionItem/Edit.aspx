<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="true" CodeFile="Edit.aspx.vb" Inherits="Menu_Edit" ValidateRequest="false" %>
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
		<div class="row m-auto">
			<div class="form-group d-inline-block mr-5">
			    <label class="badge badge-pill badge-info">Menu</label>
			    <h4><%= dt.rows(0)("menuname") %></h4>
			</div>
			<div class="form-group d-inline-block">
			    <label class="badge badge-pill badge-info">Section</label>
			    <h4><%= dt.rows(0)("sectionname") %></h4>
			</div>
		</div>
	
	<div class="jumbotron pt-3 pb-3">
		<p class="lead">Add an Item</p>

		<form action method="post">
			<input type="hidden" name="id" value="<%= selectedMenuSectionItem.rows(0)("id") %>">
			<input type="hidden" name="menu_section_id" value="<%= dt.rows(0)("id") %>">
			<input type="hidden" id="pv" name="published" value="<%= iif(selectedMenuSectionItem.rows(0)("published").tostring.length = 0, 0, selectedMenuSectionItem.rows(0)("published")) %>">
			<div class="custom-control custom-checkbox mb-3">
			  <input type="checkbox" class="custom-control-input published" id="customCheck1" <%= iif(selectedMenuSectionItem.rows(0)("published").tostring = "1", "checked", "") %>>
			  <label class="custom-control-label" for="customCheck1">Published</label>
			</div>
			<div class="form-row">
				<div class="form-group col-9">
				    <label>Item</label>
				    <select class="form-control" name="item_id">
				    <option>Select an Item</option>
				    <%
					For Each irow As DataRow In item.Rows
				   %>
					<option value="<%= irow("id") %>" <%= iif(selectedMenuSectionItem.rows(0)("item_id").ToString = irow("id").ToString, "selected", "") %> ><%= irow("name") %></option>
				   <%
					Next
				   %>
				   </select>
				  </div>
			  
				<div class="form-group col-3">
				    <label>Price</label>
				    <div class="input-group">
				        <div class="input-group-prepend">
					<div class="input-group-text">$</div>
				        </div>
				        <% If  selectedMenuSectionItem.rows(0)("price").ToString.length = 0 Then %>
				        		<input type="text" class="form-control" id="inlineFormInputGroupUsername" name="price">
				        <% Else %>
				        		<input type="text" class="form-control" id="inlineFormInputGroupUsername" name="price" value="<%= Convert.ToDecimal(selectedMenuSectionItem.rows(0)("price")).ToString("N2") %>">
				        <% End If %>
				      </div>
				</div>
			</div>
			
			<div class="form-row">
			<div class="form-group col-5">
			    <label>Size</label>
			    <select class="form-control" name="size_id">
			    <option value="">Select an Size</option>
			    <%
				For Each srow As DataRow In size.Rows
			   %>
				<option value="<%= srow("id") %>" <%= iif(selectedMenuSectionItem.rows(0)("size_id").ToString = srow("id").ToString, "selected", "") %> ><%= srow("name") %></option>
			   <%
				Next
			   %>
			   </select>
			  </div>
			<div class="form-group col-5">
			    <label>Includes</label>
			    <select class="form-control" name="include_id">
			    <option value="">Select the Incudes</option>
			    <%
				For Each inrow As DataRow In include.Rows
			   %>
				<option value="<%= inrow("id") %>" <%= iif(selectedMenuSectionItem.rows(0)("include_id").ToString = inrow("id").ToString, "selected", "") %> ><%= inrow("items") %></option>
			   <%
				Next
			   %>
			   </select>
			  </div>
			<div class="form-group col-2">
			    <label>Section Item Id</label>
			    <input type="text" class="form-control" name="section_item_number" value="<%= selectedMenuSectionItem.rows(0)("section_item_number") %>">
			</div>
			</div>
			<div class="form-group">
			    <label for="">Description</label>
			    <textarea type="password" class="form-control"name="description" rows="3"><%= selectedMenuSectionItem.rows(0)("description") %></textarea>
			  </div>
			  <div class="form-group">
			    <label>Order online url</label>
			    <input type="text" class="form-control" name="order_online_url" value="<%= selectedMenuSectionItem.rows(0)("order_online_url") %>">
			  </div>
			<div class="form-group">
			   <%
				if selectedMenuSectionItem.rows(0)("id").ToString.length > 0 Then
			%>
				<asp:Button type="submit" class="btn btn-primary" runat="server" ID="btnSave" text="Save"/>
			<%
				Else
			%>
				<asp:Button type="submit" class="btn btn-primary" runat="server" ID="btnAdd" text="Add"/>
			<%
				End If
			   %>  
			  <!--<asp:Button type="submit" class="btn btn-outline-primary" runat="server" ID="btnSaveClose" text="Save & Close"/>-->
			  <asp:Button class="btn btn-outline-secondary" runat="server" ID="btnReset" text="Reset"/>
			  <asp:Button class="btn btn-outline-secondary" runat="server" ID="btnClose" text="Done"/>
			</div>
		</form>
	</div>
	
		<div>
			<h4>All Menu Items</h4>
			<div class="row ml-0 mr-0">
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
			<table class="table table-striped table-bordered table-hover border-top-0" id="searchableTable">
				<thead>
					<tr>
						<th scope="col" title="Published">Pub</th>
						<th scope="col">Id</th>
						<th scope="col" style="white-space: nowrap;">Section Item Id</th>
						<th scope="col">Item</th>
						<th scope="col">Price</th>
						<th scope="col">Size</th>
						<th scope="col">Include</th>
						<th scope="col">Description</th>
						<th scope="col" style="white-space: nowrap;">Order Url</th>
					</tr>
				</thead>
				<tbody>
				<%
					For Each msirow As DataRow In menuSectionItem.Rows
				%>
					<tr onclick="document.location='edit.aspx?id=<%= dt.rows(0)("id") %>&msid=<%= msirow("id") %>'" style="cursor:pointer;">
						<td title="Published"><input type="checkbox" class="published-ajax"  <%= iif(msirow("published").tostring = "1", "checked", "") %> data-id="<%= msirow("id") %>" data-tbl="mnuMenuSectionItem"></td>
						<td class="text-center"><%= msirow("id") %></td>
						<td class="col- text-center"><%= msirow("section_item_number") %></td>
						<td class="col"><%= msirow("item") %></td>
						<td class="col"><%= Convert.ToDecimal(msirow("price")).ToString("N2") %></td>
						<td class="col text-center"><%= iif(msirow("size").tostring.length = 0, "None", msirow("size")) %></td>
						<td class="col text-center" title="Include" data-content="<%= iif(msirow("include").tostring.length = 0, "None",  msirow("include")) %>" data-toggle="popover" data-placement="auto"><%= iif(msirow("include").tostring.length = 0, "None",  "Yes") %></td>
						<td class="col text-center" title="Description" data-content="<%=iif(msirow("description").tostring.length = 0, "None",  msirow("description")) %>" data-toggle="popover" data-placement="auto"><%=iif(msirow("description").tostring.length = 0, "None",  "Yes") %></td>
						<td class="col text-center" title="Order Url" data-content="<%= iif(msirow("order_online_url").tostring.length = 0, "None",  msirow("order_online_url")) %>" data-toggle="popover" data-placement="auto"><%= iif(msirow("order_online_url").tostring.length = 0, "None",  "Yes") %></td>
					</tr>
				<%
					Next
				%>
				</tbody>
			</table>
		</div>
	</div>
</asp:Content>