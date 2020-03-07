<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Gallery2_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".mGrid tbody").each(function (i, ctl) {
                if ($(ctl).children().length <= 2) {
                    $(ctl).children("tr").children("td:first, th:first").hide();
                }
            });
            $("#AddGallery").dialog({ modal: true, autoOpen: false, title: "Add Gallery" });
            $("#btnAdd").click(function () {
                var dlg = $("#AddGallery").dialog("open");
                dlg.parent().appendTo("form").first();
            });
            $("#btnCat").click(function () {
                location.href = 'Cat.aspx';
            });
            $("#btnCancel").click(function () {
                $("#AddGallery").dialog("close");
            });
            $(".mGrid tbody").sortable({
                handle: ".drag",
                items: ".rows",
                stop: function (event, ui) {
                    $(event.target).closest("tbody").children(".row").each(function (idx, tr) {
                        $.ajax("Seq.ashx", {
                            data: {
                                "Id": $(tr).find(".GalleryId").html(),
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
        input[type=text], select{padding:2px; width:200px; border:1px solid #aaa; margin:2px;}
        textarea{width:255px; max-width:255px; min-width:255px; max-height:200px;}
        .drag{cursor:move;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Galleries</h1>
    <input type="button" id="btnAdd" value="Add Gallery" class="btn btn-primary btn-sm my-3"/>
    <input type="button" id="btnCat" value="Manage Categories" class="btn btn-secondary btn-sm my-3"/>
    <p class="tip">To reorder galleries, click the drag handle and move them up or down.</p>
    <asp:Repeater ID="myRepeater" runat="server" OnItemDataBound="getNestedData">
        <ItemTemplate>
            <h3><%#Container.DataItem("Name")%></h3>
           <asp:GridView ID="gvDocs" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="mGrid table table-hover"  RowStyle-CssClass="rows" EmptyDataText="No galleries have been assigned to this category.">
                <Columns>
                    <asp:TemplateField ItemStyle-CssClass="drag" HeaderText="Reorder" >
                        <ItemTemplate>
                            <span style="color:#ccc;">drag</span> 
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField ItemStyle-CssClass="GalleryId" DataField="Id" HeaderText="Id"  />
                    <asp:BoundField DataField="Name" HeaderText="Name"  />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:TemplateField  HeaderText="Actions">
                        <ItemTemplate>
                            <div class="btn-group">
								<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm"/>
								<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
							</div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ItemTemplate>
    </asp:Repeater>
    <div id="AddGallery">
        <asp:Label ID="Label1" runat="server" AssociatedControlID="dlCat" Text="Category"></asp:Label><br />
        <asp:DropDownList runat="server" ID="dlCat"></asp:DropDownList><br /><br />
        <asp:Label runat="server" AssociatedControlID="txtName" Text="Name"></asp:Label><br />
        <asp:TextBox runat="server" ID="txtName"></asp:TextBox><br /><br />
        <asp:Label runat="server" AssociatedControlID="txtDesc" Text="Description"></asp:Label><br />
        <asp:TextBox runat="server" ID="txtDesc" TextMode="MultiLine"></asp:TextBox><br /><br />
        <asp:Button runat="server" ID="btnSave" Text="Save" />
        <input type="button" id="btnCancel" value="Cancel" />
    </div>

</asp:Content>