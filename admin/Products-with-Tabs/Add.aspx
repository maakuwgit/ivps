<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Docs_Add" ValidateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
    <style type="text/css">
        textarea{width:600px; max-width:95%;}
        tr td{border-bottom:1px solid #000;vertical-align: top;border-right:1px solid #000;}
        table{border-left:1px solid #000; border-top:1px solid #000;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit Product</h1>
    <asp:HiddenField runat="server" ID="DocId" />
    <p>
    	<asp:CheckBox runat="server" ID="CheckBox_Published" Text="Published"></asp:CheckBox><br><br>
    </p>
    <p>
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="dlCat" Text="Category"></asp:Label>
        <asp:DropDownList runat="server" ID="dlCat" DataTextField="Name" DataValueField="Id"></asp:DropDownList>
    </p>
    <p>
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="Name" Text="Name"></asp:Label>
        <asp:TextBox runat="server" ID="Name" MaxLength="100"></asp:TextBox>
    </p>
    <p>
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="ShortDescription" Text="Short Description"></asp:Label>
        <asp:TextBox runat="server" CssClass="ckeditor" ID="ShortDescription" MaxLength="255" TextMode="MultiLine" Rows="4"></asp:TextBox>
    </p>
    <!--p>
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="Description2" Text="Description"></asp:Label>
        <asp:TextBox runat="server" CssClass="ckeditor" ID="Description2" MaxLength="2048" TextMode="MultiLine" Rows="4"></asp:TextBox>
    </p-->
    <p>
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="imgUpload" Text="Picture"></asp:Label>
        <asp:FileUpload runat="server" ID="imgUpload" />
    </p>
    <p>
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="tdsUpload" Text="Tech Data Sheet"></asp:Label>
        <asp:FileUpload runat="server" ID="tdsUpload" />
    </p>
    <p>
        <asp:Button runat="server" ID="btnSave" Text="Save" />
        <input type="button" value="Cancel" onclick="location.href='/admin/Products/'" />
    </p>
    
   
    <div>
    	<div style="border-bottom:1px solid #ccc;border-top:5px solid #999;margin-top:1rem;">
    		<h1>Content Tabs</h1>
    		<asp:Button runat="server" Text="Add Content Tab" ID="btnAddTab" style="margin: 0 0 1.5rem 0;"/>
    	</div>
    	<table cellspacing="0" cellpadding="10" width="100%">
    		<tr>
    			<td>Published</td>
    			<td Title="The display order of the tabs. 1 is first, 2 is second, ... 0 will display alphabeticlly at the end.">Display Order</td>
    			<td>Name</td>
    			<td style="border-right:none;">Content Snippet</td>
    			<td></td>
    		</tr>
		<asp:Repeater runat="server" ID="Tabs">
			<ItemTemplate>
			<tr>
			<td>
				<asp:label runat="server" CssClass="input-label" ID="Published" Text='<%# IIf(Eval("Published") = 1, "Yes", "No") %>'></asp:label>
			</td>
			<td>
				<asp:label runat="server" CssClass="input-label" ID="Seq" Text='<%#Eval("Seq")%>'></asp:label>
			</td>
			<td>
			<asp:label runat="server" CssClass="input-label" ID="Name" Text='<%#Eval("Name") %>'></asp:label>
			</td>
			<td width="100%">
			<%# TruncateStringAndRemoveHTML( Eval("Content"), 255) %>
			</td>
			<td>
				<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnUpdateTab_Click" />
				<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClick="btnDeleteTab_Click" OnClientClick="return confirm('Are you sure you want to delete this tab?');"/>
			</td>
			</tr>
			</div>
			</ItemTemplate>
		</asp:Repeater>
		</table>
	</div>
	
</asp:Content>