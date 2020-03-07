<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Bios_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<asp:Button runat="server" Text="Add Staff Bio" ID="btnAdd" class="btn btn-primary btn-sm my-3"/>
<asp:GridView ID="gvBio" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr"  EmptyDataText="No staff bios have been created yet.">
<AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id"/>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                	<div class="btn-group">
                    	<asp:Button runat="server" ID="btnUp" CommandArgument='<%# Eval("Id") %>' OnClick="btnUp_Click"  class="btn btn-outline-primary btn-sm" Text="&#8593;"/>
                    	<asp:Button runat="server" ID="btnDown" CommandArgument='<%# Eval("Id") %>' OnClick="btnDown_Click" class="btn btn-outline-primary btn-sm" Text="&#8595;"/>
                    
                		<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm"/>
                		<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                	</div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    <PagerStyle CssClass="pgr"></PagerStyle>
    </asp:GridView>
</asp:Content>

