<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="afgadmin_Gallery_Default" MasterPageFile="~/admin/Admin.master" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
   <title></title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="main">
    <h1>Videos</h1>
    <label for="cmbCat" style="display:none;">Category</label>
    <asp:DropDownList ID="cmbCat" runat="server" AutoPostBack="True" style="display:none;"></asp:DropDownList>
    <br />
    <br />
    <asp:Button ID="btnAdd" runat="server" Text="Add" class="btn btn-primary btn-sm my-3"/>
    <asp:GridView ID="gvGalleryItems" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description"/>
            <asp:TemplateField ItemStyle-Width="220" HeaderText="Actions">
            <ItemTemplate>
                <div class="btn-group">
                	<asp:Button runat="server" ID="btnUp" CommandArgument='<%# Eval("Id") %>' OnClick="btnUp_Click" class="btn btn-outline-primary btn-sm " text="&#8593;"/>
                	<asp:Button runat="server" ID="btnDown" CommandArgument='<%# Eval("Id") %>' OnClick="btnDown_Click" class="btn btn-outline-primary btn-sm " text="&#8595;"/>
                	<a target="_blank" href='<%# Eval("Code") %>' title='<%# Eval("Name") %>' class="btn btn-outline-primary btn-sm ">Watch</a>
					<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm "/>
					<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
				</div>
            </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>