<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".mGrid tbody").sortable({
                handle: ".drag",
                items: "> .item",
                stop: function (e) {
                    $(e.target).closest("tbody").find("tr.item").each(function (idx, tr) {
                    console.log($(tr).find(".id").html() + "-" + (idx+1))
                        $.ajax("Seq.ashx", {
                            data: {
                                "Id": $(tr).find(".id").html(),
                                "Seq": (idx+1)
                            },
                            cache: false
                        });
                    });
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Menu Links</h1>
    <asp:button ID="btnAdd" runat="server" Text="Add Menu Link" class="btn btn-primary btn-sm my-3" />
    
     <div class="form-group col-4 p-0">
	<div class="input-group mb-2 mr-sm-2">
	    <div class="input-group-prepend">
		<button class="btn btn-light border" type="button" onclick="$('#searchableTableText').val('');$('#searchableTableText').keyup();"><i class="fas fa-times text-primary"></i></button>
	    </div>
	    <input type="text" class="form-control" id="searchableTableText" placeholder="Filter" value="<%= Request("filter") %>">
	  </div>
	  <script>
	   $("#searchableTableText").on("keyup", function() {
	    	var value = $(this).val().toLowerCase();
	    	$(".filter").val(value)
	    	$(".searchableTable tbody tr:not(:first)").filter(function() {
	      		$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    	});
	  });
	  </script>
  </div>
  <input type="hidden" name="filter" class="filter" runat="server" id="filter">
    <asp:GridView ID="gvSlider" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="mGrid table table-hover searchableTable" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="item alt" EmptyDataText="No links have been added." RowStyle-CssClass="item">
     <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-CssClass="id"/>
        <asp:BoundField DataField="order" HeaderText="Order" />
        <asp:TemplateField HeaderText="Menu">
        		<ItemTemplate>
 				<%# getMenuInfo( Eval("menuid") ) %>
          	</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Link">
        		<ItemTemplate>
 				<%# getLinkInfo( Eval("linkid") ) %>
          	</ItemTemplate>
        </asp:TemplateField>
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