<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Links</h1>
    <asp:button ID="btnAdd" ToolTip="Add a New Link" runat="server" Text="Add Link" class="btn btn-primary btn-sm my-3"/>
    <asp:button ID="btnCategories" ToolTip="Categories" runat="server" Text="Categories" class="btn btn-primary btn-sm my-3" />
    <asp:GridView ID="gvContent" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No links have been created yet.">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="CatName" HeaderText="Category"/>
            <asp:BoundField DataField="Name" HeaderText="Name" />
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