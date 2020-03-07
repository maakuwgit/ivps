<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_News_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>News</h1>
    <p>
        <input type="button" value="Add Story" onclick="location.href = 'Add.aspx';" class="btn btn-primary btn-sm my-3"/>
        <input type="button" value="Manage Categories" onclick="location.href = 'Cat.aspx';" class="btn btn-primary btn-sm my-3"/>
    </p>
    
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
		  
    <asp:GridView ID="gvNews" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover searchableTable" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="There are no news stories to display.">
        <Columns>
        	<asp:TemplateField HeaderText="Cornerstone">
                <ItemTemplate>
                    	<asp:CheckBox ID="ckCornerstone" runat="server" NewsId='<%#Eval("Id")%>' AutoPostBack="true" OnCheckedChanged="ckCornerstone_CheckedChanged" Checked='<%# iif( Not IsDBNull(Eval("Cornerstone")), Eval("Cornerstone"), 0)  %>' />
                	</ItemTemplate>
            </asp:TemplateField>
        	<asp:TemplateField HeaderText="Category">
                <ItemTemplate>
                    <%# getCategoryName( Eval("CatId") ) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="PubDate" dataformatstring="{0:MMM-dd-yyyy}" HeaderText="Date Published" />
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="btn-group">
                		<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm "/>
                		<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                	</div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>