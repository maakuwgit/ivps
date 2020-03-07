<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Locations</h1>
    <asp:button ID="btnAdd" runat="server" Text="Add" class="btn btn-primary btn-sm my-3"/>
            <div class="form-group col-4 p-0">
	<div class="input-group mb-2 mr-sm-2">
	    <div class="input-group-prepend">
		<button class="btn btn-light border" type="button" onclick="$('#searchableTableText').val('');$('#searchableTableText').keyup();"><i class="fas fa-times text-primary"></i></button>
	    </div>
	    <input type="text" class="form-control" id="searchableTableText" placeholder="Filter">
	  </div>
	  <script>
	   $("#searchableTableText").on("keyup", function() {
	    	var value = $(this).val().toLowerCase();
	    	$(".searchableTable tbody tr:not(:first)").filter(function() {
	      		$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    	});
	  });
	  </script>
  </div>
    <asp:GridView ID="gvContent" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover searchableTable" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="Nothing has been added.">
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id"/>
        <asp:BoundField DataField="Name" HeaderText="Name"/>
        <asp:BoundField DataField="Address" HeaderText="Address"/>
        <asp:BoundField DataField="City"  HeaderText="City"/>
        <asp:BoundField DataField="State"  HeaderText="State"/>
        <asp:BoundField DataField="Zip"  HeaderText="Zip"/>
        <asp:BoundField DataField="Phone"  HeaderText="Phone"/>
        <asp:BoundField DataField="Lat"  HeaderText="Lat"/>
        <asp:BoundField DataField="Lng"  HeaderText="Lng"/>
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <div class="btn-group">
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-secondary btn-sm "/>
                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                </div>
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>