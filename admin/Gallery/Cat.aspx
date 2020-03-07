<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Cat.aspx.vb" Inherits="admin_Gallery_Cat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    var CatId;
    $(document).ready(function () {
        var dlg = $("#CatDetail").dialog({ autoOpen: false, title: "Add / Edit Category" });
        dlg.parent().appendTo("form:first");
        $("#AddCat").click(function () {
            CatId = 0;
            $("#CatDetail").dialog("open");
        });
        $("#btnGallery").click(function () {
            location.href = 'Default.aspx';
        });
        $(".mGrid tbody").sortable({
            handle: ".drag",
            items: ".rows",
            stop: function (event, ui) {
                $("tbody tr").each(function (idx, tr) {
                    $.ajax("CatSeq.ashx", {
                        data: {
                            "Id": $(tr).find(".Cat-Id").html(),
                            "Seq": idx
                        },
                        cache: false
                    });
                });
            }
        });
        $(".btnEdit").click(function (evt) {
            var name = $(evt.target).closest("tr").find(".Cat-Name").html();
            CatId = $(evt.target).closest("tr").find(".Cat-Id").html();
            $(".txtName").val(name);
            $("#CatDetail").dialog("open");
        });
        $(".btnDelete").click(function (evt) {
            var name = $(evt.target).closest("tr").children(".Cat-Name").html();
            if (confirm('Are you sure you want to delete the ' + name + ' category?')) {
                CatId = $(evt.target).closest("tr").children(".Cat-Id").html();
                $(evt.target).closest("tr").remove();
                $.ajax("CatDelete.ashx", {
                    data: {
                        "Id": CatId
                    },
                    cache: false
                });
            }
        });
        $("#btnSave").click(function () {
            $.ajax("CatEdit.ashx", {
                data: {
                    "Id": CatId,
                    "Name": $(".txtName").val()
                },
                cache: false,
                complete: function () {
                    location.reload();
                }
            });
        });
        $("#btnCancel").click(function () {
            $("#CatDetail").dialog("close");
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
    <h1>Gallery Categories</h1>
    <input type="button" value="Add Category" id="AddCat" class="btn btn-primary btn-sm my-3"/>
    <input type="button" value="Manage Galleries" id="btnGallery" class="btn btn-secondary btn-sm my-3"/>
    <p class="tip">To reorder categories, click the drag handle and move them up or down.</p>
     <asp:GridView ID="gvCats" runat="server" AutoGenerateColumns="False" GridLines="None" RowStyle-CssClass="rows" CssClass="mGrid table table-hover" EmptyDataText="No categories have been created yet.">
        <Columns>
            <asp:TemplateField ItemStyle-CssClass="drag" ItemStyle-Width="30" HeaderText="Reorder" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span style="color:#ccc;">drag</span> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="40" ItemStyle-CssClass="Cat-Id" />
            <asp:BoundField ItemStyle-CssClass="Cat-Name" DataField="Name" HeaderText="Name" />
            <asp:TemplateField ItemStyle-Width="200" HeaderText="Actions">
                <ItemTemplate>
                    <div class="btn-group">
                    	<input type="button" class="btnEdit btn btn-outline-primary btn-sm" data-toggle="modal" data-target="#editCategoryMod" value="Edit" />
                    	<input type="button" class="btnDelete btn btn-outline-danger btn-sm" value="Delete" OnClientClick="return confirm('Are you sure?')"/>
                	</div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div id="CatDetail">
        <asp:Label ID="Label1" runat="server" AssociatedControlID="Name" Text="Name"></asp:Label><br />
        <asp:TextBox runat="server" CssClass="txtName" ID="Name"></asp:TextBox><br /><br />
        <input type="button" id="btnSave" value="Save" />
        <input type="button" id="btnCancel" value="Cancel" />
    </div>
</asp:Content>