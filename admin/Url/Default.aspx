<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Website Links</h1>
    <asp:button ID="btnAdd" runat="server" Text="Add New Link" class="btn btn-primary btn-sm my-3"/>
            <div class="form-group col-4 p-0">
	<div class="input-group mb-2 mr-sm-2">
	    <div class="input-group-prepend">
		<button class="btn btn-light border" type="button" onclick="$('#searchableTableText').val('');$('#searchableTableText').keyup();"><i class="fas fa-times text-primary"></i></button>
	    </div>
	    <input type="text" class="form-control" id="searchableTableText" placeholder="Filter" value="<%= Request("filter") %>">
	  </div>
	  <script>
	   $("#searchableTableText").on("keyup change paste", function() {
	    	var value = $(this).val().toLowerCase();
	    	$(".filter").val(value)
	    	$(".searchableTable tbody tr:not(:first)").filter(function() {
	      		$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    	});
	  });
	  </script>
  </div>
 <input type="hidden" name="filter" class="filter" runat="server" id="filter">
    <asp:GridView ID="gvContent" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover searchableTable" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No links have been added.">
        
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id"/>
        <asp:TemplateField HeaderText="Active">
            	<ItemTemplate>
                    	<asp:CheckBox ID="ckActive" runat="server" LinkId='<%#Eval("Id")%>' AutoPostBack="true" OnCheckedChanged="ckActive_CheckedChanged" Checked='<%# iif( Not IsDBNull(Eval("Active")), Eval("Active"), 0)  %>' />
                	</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Parent">
            	<ItemTemplate>
 			<%# getParent( Eval("parentid") ) %>
          	</ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Name" HeaderText="Name"/>
        <asp:BoundField DataField="Label" HeaderText="Website Label"/>
        <asp:BoundField DataField="url"  HeaderText="Url"/>
        <asp:BoundField DataField="location"  HeaderText="File Location"/>
        <asp:BoundField DataField="action"  HeaderText="Action"/>
        <asp:BoundField DataField="properties"  HeaderText="Properties"/>
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <div class="btn-group">
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm "/>
                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                </div>
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>
    	<script>
		$("#searchableTableText").trigger("keyup")
	</script>
</asp:Content>