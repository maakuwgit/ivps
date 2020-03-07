<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Z-Add.aspx.vb" Inherits="admin_Docs_Add2" ValidateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
    <style type="text/css">
        textarea{width:600px; max-width:95%;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit Product</h1>
    <asp:HiddenField runat="server" ID="DocId" />
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
        <asp:TextBox runat="server" CssClass="ckeditor" ID="ShortDescription" MaxLength="2048" TextMode="MultiLine" Rows="4"></asp:TextBox>
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
    
    
    
    <!--ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li>
  </ul-->
  
  <!--div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home">...</div>
    <div role="tabpanel" class="tab-pane" id="profile">...</div>
    <div role="tabpanel" class="tab-pane" id="messages">...</div>
    <div role="tabpanel" class="tab-pane" id="settings">...</div>
  </div-->
   
    <div>
    	<div style="border-bottom:1px solid #ccc;border-top:5px solid #999;margin-top:1rem;">
    		<h1>Content Tabs</h1>
    		<asp:Button runat="server" Text="Add Content Tab" ID="btnAddTab" style="margin: 0 0 1.5rem 0;"/>
    	</div>
		<asp:DataList runat="server" DataKeyField="Id" ID="Tabs">
			<EditItemTemplate>
				<div style="margin: .5rem 0 1.5rem 0;border-bottom:1px solid #999;">
				<div><label>Tab Name</label></div>
				<div style="margin: .5rem 0 0 0;">
					<asp:TextBox runat="server" CssClass="input-label" ID="Names" Text='<%# DataBinder.Eval(Tab, "Content") %>'></asp:TextBox>
				</div>
				<br>
				<div><label>Tab Content</label></div>
				<div style="margin: .5rem 0 1.5rem 0;">
					<asp:TextBox runat="server" ID="txtNamers" CssClass="ckeditor" Text='<%#Eval("Content") %>'  MaxLength="2048" TextMode="MultiLine" Rows="10" style="min-width:400px; width:500px; max-width:700px; max-height:500px;"></asp:TextBox><br />
				
				<asp:Button runat="server" Text="Update" ID="btnUpdateTab" CommandName="Update" UseSubmitBehavior="true" CommandArgument='<%#Eval("Id") %>' style="margin: 0 0 1.5rem 0;"/></div>
				</div>
			</EditItemTemplate>
		</asp:DataList>
	</div>
	
</asp:Content>