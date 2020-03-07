<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Docs_Default" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<h1>Documents</h1>
    <p>Documents are sorted by Category on the front end. You can add documents and categories using the buttons below.</p>
	<p>
        <input type="button" value="Add Document" onclick="location.href='Add.aspx'" class="btn btn-primary btn-sm my-3"/>
        <input type="button" value="Manage Categories" onclick="location.href='CatDefault.aspx'" class="btn btn-primary btn-sm my-3"/>
    </p>
    <asp:GridView ID="gvDocs" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No documents have been added yet.">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="FileName" HeaderText="File Name" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                <div class="btn-group">
                	<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm "/>
                	<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                	<asp:Button runat="server" Text="Download" CommandArgument='<%#Eval("Id") %>' OnClick="btnDownload_Click" class="btn btn-outline-secondary btn-sm" />
                </div>

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>