<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Promo_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Promotions</h1>
    <input type="button" value="Add Promo" onclick="location.href='/Admin/Promo/Add.aspx'" class="btn btn-primary btn-sm my-3"/>
    <asp:GridView ID="gvPromo" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No content areas have been created yet.">
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id" />
        <asp:TemplateField HeaderText="Featured">
            	<ItemTemplate>
                    	<asp:CheckBox ID="ckFeatured" runat="server" PromoId='<%#Eval("Id")%>' AutoPostBack="true" OnCheckedChanged="ckFeatured_CheckedChanged" Checked='<%# iif( Not IsDBNull(Eval("Featured")), Eval("Featured"), 0)  %>' />
                	</ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Name" HeaderText="Name" />
        <asp:BoundField DataField="Desc" HeaderText="Description" />
        <asp:BoundField DataField="StartDt" HeaderText="Starts" DataFormatString="{0:d}" />
        <asp:BoundField DataField="EndDt" HeaderText="Ends" DataFormatString="{0:d}" />
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