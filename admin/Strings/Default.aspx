<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Strings_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>String Resource Manager</h1>
    <ul id="Categories" runat="server" class="nav nav-tabs"></ul>
    
    <div id="Strings" class="">
        <asp:Button runat="server" ID="btnAddString" Text="Add String" Visible="false" class="btn btn-primary btn-sm my-3" />
        <asp:GridView ID="gvStr" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="There are no strings to display for the selected category.">
            <Columns>
                <asp:BoundField HeaderText="Name" DataField="Name" />
                <asp:BoundField HeaderText="Value" DataField="Value" />
                <asp:TemplateField  HeaderText="Actions">
                    <ItemTemplate>
                    	<div class="btn-group">
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm "/>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>