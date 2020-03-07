<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit Website Image</h1>
    
    <asp:HiddenField ID="Id" runat="server" />
    <p><asp:Label CssClass="input-label" runat="server" ID="lblSnippet"></asp:Label></p>
    <p><asp:Label CssClass="input-label" runat="server" ID="lblSnippet2"></asp:Label></p>

    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Name</label>
        <asp:TextBox runat="server" ID="txtName" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtSrc">Src (Use only if an image is not being uploaded)</label>
        <asp:TextBox runat="server" ID="txtSrc" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtProperties">Properties</label>
        <textarea runat="server" id="txtProperties" class="form-control" rows="5"></textarea>
    </div>
    <div class="form-group">
    	<div class="custom-file">
			<asp:FileUpload runat="server" ID="fileUploadImage" class="custom-file-input"></asp:FileUpload>
			<asp:Label runat="server" AssociatedControlID="fileUploadImage" Text="Choose Image (Optional)" class="custom-file-label"></asp:Label>
		</div>
	</div>
    <div class="form-group">
    	<asp:HyperLink ID="displayImageLink" runat="server" Target="_new"><asp:Image ID="displayImage" runat="server" style="max-height:200px;border:1px solid #999;display:inline-block;padding:1rem;"></asp:Image></asp:HyperLink>
	</div>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Cancel" ID="btnCancel" class="btn btn-outline-secondary my-3"/>
    </div>
    <script type="text/javascript">
        $(document).ready(function () { 
            CKEDITOR.replace("ctl00_main_txtContent", {
                "extraPlugins": "imagebrowser",
                "imageBrowser_listUrl": "../images/Images.ashx"
            });
        });
    </script>
</asp:Content>