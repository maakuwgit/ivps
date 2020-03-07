<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Products_Default" ValidateRequest="false" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Products</h1>
    <p>
        <input type="button" value="Add Product" onclick="location.href = 'Add.aspx'" />
        <input type="button" value="Manage Categories" onclick="location.href='Cat.aspx'" />
    </p>
    <asp:Repeater runat="server" ID="rptCat">
        <ItemTemplate>
            <h3><%#Eval("Name")%></h3>
            <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No products have been added yet.">
                <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="40" />
                <asp:BoundField DataField="Published" HeaderText="Published" ItemStyle-Width="40" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:TemplateField ItemStyle-Width="110" HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

