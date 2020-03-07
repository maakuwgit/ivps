<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Cat.aspx.vb" Inherits="admin_Products_Cat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    var CatId;
    $(document).ready(function () {
        var dlg = $("#CatDetail").dialog({ autoOpen: false, title: "Add / Edit Category" });
        dlg.parent().appendTo("form:first");
        var dlg2 = $("#CatSecurity").dialog({ autoOpen: false, title: "Security", width:400 });
        dlg.parent().appendTo("form:first");
        $("#AddCat").click(function () {
            CatId = 0;
            $("#CatDetail").dialog("open");
            $(".txtName, .txtDesc").val("");
            //$(".ckPublic input").removeAttr("checked");
        });
        $("#btnProducts").click(function () {
            location.href = 'Default.aspx';
        });
        $(".mGrid tbody").sortable({
            handle: ".drag",
            items: ".row",
            stop: function (event, ui) {
                $("tbody tr").filter("tr:gt(1)").each(function (idx, tr) {
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
        $(".btnSub").click(function (evt) {
            CatId = $(evt.target).closest("tr").find(".Cat-Id").html();
            location.href = "?Id=" + CatId;
        });
        $(".btnEdit").click(function (evt) {
            $(".txtName, .txtDesc").val("");
            var name = $(evt.target).closest("tr").find(".Cat-Name").html();
            var desc = $(evt.target).closest("tr").find(".Cat-Desc").text();
            CatId = $(evt.target).closest("tr").find(".Cat-Id").html();
            $(".txtName").val(name);
            if (desc !== "&nbsp;"){
                $(".txtDesc").val(desc);
            }
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
                    "Name": $(".txtName").val(),
                    "Description" : $(".txtDesc").val(),
                    "ParentId": $(".ParentId input").val()
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
        $("#btnParent").click(function () {
            location.href = "/admin/Products/Cat.aspx";
        });
        $(".btnSub").hide();
    });
</script>
<style type="text/css">
    .drag{
        cursor:move;    
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1 id="pgTitle" runat="server">Product Categories</h1>
    <input type="button" value="Add Category" id="AddCat" />
    <input type="button" value="Manage Products" id="btnProducts" />
    <% 
        If Not Request("Id") Is Nothing Then
            Response.Write("<input type=""button"" value=""Go Back"" id=""btnParent"" />")
        End If
    %>
    
    <div class="ParentId">
        <asp:HiddenField runat="server" ID="ParentId" Value="0" />
    </div>
    <p class="tip">To reorder categories, click the drag handle and move them up or down.</p>
    <asp:GridView ID="gvCats" runat="server" AutoGenerateColumns="False" GridLines="None" RowStyle-CssClass="row" CssClass="mGrid" PagerStyle-CssClass="pgr" EmptyDataText="No categories have been created yet.">
        <Columns>
            <asp:TemplateField ItemStyle-CssClass="drag" ItemStyle-Width="30" HeaderText="Reorder" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span style="color:#ccc;">drag</span> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="40" ItemStyle-CssClass="Cat-Id" />
            <asp:BoundField ItemStyle-CssClass="Cat-Name" DataField="Name" HeaderText="Name" />
            <asp:BoundField ItemStyle-CssClass="Cat-Desc" DataField="Description" HeaderText="Description" />
            <asp:TemplateField ItemStyle-Width="300" HeaderText="Actions">
                <ItemTemplate>
                    <input type="button" class="btnSub" value="Sub Cats" />
                    <input type="button" class="btnEdit" value="Edit" />
                    <input type="button" class="btnDelete" value="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div id="CatDetail">
        <p>
            <asp:Label runat="server" CssClass="input-label" AssociatedControlID="Name" Text="Name"></asp:Label>
            <asp:TextBox runat="server" CssClass="txtName" ID="Name"></asp:TextBox>
        </p>
        <p>
            <asp:Label runat="server" CssClass="input-label" AssociatedControlID="Desc" Text="Description"></asp:Label>
            <asp:TextBox runat="server" CssClass="txtDesc" ID="Desc" TextMode="MultiLine"></asp:TextBox>
        </p>
        <p>
            <input type="button" id="btnSave" value="Save" />
            <input type="button" id="btnCancel" value="Cancel" />
        </p>
    </div>
    <div id="CatSecurity">
        <div>
            <p>Changes are automatically saved with each click.</p>
            <table class="mGrid">
                <thead>
                    <tr>
                        <th>Email</th>
                        <th>Access</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</asp:Content>