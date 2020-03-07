<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Website Images</h1>
    <asp:button ID="btnAdd" runat="server" Text="Add New Image" class="btn btn-primary btn-sm my-3" />
    <asp:GridView ID="gvContent" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No images have been added.">
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id"/>
        <asp:BoundField DataField="Name" HeaderText="Name"/>
        <asp:BoundField DataField="FileName"  HeaderText="File Name"/>
        <asp:BoundField DataField="Src"  HeaderText="Src"/>
        <asp:ImageField DataImageUrlField="Src" ControlStyle-Height = "50"></asp:ImageField>
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
</asp:Content>