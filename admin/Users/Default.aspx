<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Users_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<h1>Users</h1>
<asp:Button runat="server" ID="btnAdd" Text="Add" class="btn btn-primary btn-sm my-3"/>
<asp:GridView ID="gvUser" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="There are no users to display.">
    <Columns>
        <asp:BoundField HeaderText="Id" DataField="Id" />
        <asp:BoundField HeaderText="Name" DataField="Name" />
        <asp:BoundField HeaderText="Access" DataField="Access" />
        <asp:TemplateField HeaderText="Mailing List">
            <ItemTemplate>
                <asp:CheckBox ID="ckApproved" runat="server" style="margin-left:40px" UserId='<%#Eval("Id")%>' AutoPostBack="true" OnCheckedChanged="ckMailList_CheckedChanged" Checked='<%#Eval("IsMailingList")%>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ItemStyle-Width="120" HeaderText="Actions">
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