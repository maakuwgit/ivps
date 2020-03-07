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
    <h1>Slider Images</h1>
    <asp:button ID="btnAdd" runat="server" Text="Add New Image" class="btn btn-primary btn-sm my-3" />
    <asp:GridView ID="gvSlider" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="mGrid table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="item alt" EmptyDataText="No products have been added yet." RowStyle-CssClass="item">
     <Columns>
        <asp:TemplateField ItemStyle-Width="200" HeaderText="Photo" ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="drag">
			<ItemTemplate>
				<img class="drag" src='<%#Eval("ImgSrc") %>' alt="Slide Image Missing" style="width:200px;"/>
			</ItemTemplate>
		</asp:TemplateField>
        <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-CssClass="id"/>
        <asp:BoundField DataField="Seq" HeaderText="Order" ItemStyle-CssClass="id"/>
        <asp:BoundField DataField="Name" HeaderText="Name"/>
        <asp:BoundField DataField="Title"  HeaderText="Title"/>
        <asp:BoundField DataField="Published"  HeaderText="Published"/>
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
</asp:Content>