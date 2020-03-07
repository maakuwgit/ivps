<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_News_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    var GenericId;
    $(document).ready(function () {
		$( ".table tbody" ).sortable({
			stop: function (event, ui) {
                $("tbody tr").each(function (idx, tr) {
                    $.ajax("GenSeq.ashx", {
                        data: {
                            "Id": $(tr).find(".Gen-Id").html(),
                            "Seq": idx
                        },
                        cache: false
                    });
                });
            }
		});
    });
</script>
<style type="text/css">
    .drag{
        cursor:move;    
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>FAQ</h1>
    <p>
        <input type="button" value="Add Question" onclick="location.href = 'Add.aspx';" class="btn btn-primary btn-sm my-3"/>
        
    </p>
    
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
  
    <asp:GridView ID="gvNews" runat="server" AutoGenerateColumns="False" GridLines="None" RowStyle-CssClass="" CssClass="table table-hover searchableTable" PagerStyle-CssClass="pgr"  EmptyDataText="There are no items to display.">
        <Columns>
         <asp:TemplateField ItemStyle-CssClass="drag" ItemStyle-Width="30" HeaderText="Reorder" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span style="color:#ccc;">drag</span> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Id" HeaderText="Id" />
              <asp:TemplateField  HeaderText="Featured" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span><%# isFeatured(eval("featured")) %></span> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Question" HeaderText="Question" />
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
    <script>
		$("#searchableTableText").trigger("keyup")
	</script>
</asp:Content>