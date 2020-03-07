<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
  <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>
    <h1>Edit Website Redirects</h1>
    <asp:HiddenField ID="Id" runat="server" />
	<div class="form-column">
    	<div class="form-group">
        		<label>Url</label>
        		<asp:TextBox runat="server" ID="txtUrl" class="form-control col-lg-6"></asp:TextBox>
    	</div>
	<div class="form-group">
		
		<label>Redirect Url</label>
		<div class="border p-3 col-lg-6">
		<asp:DropDownList runat="server" ID="dropRedirectUrl" class="form-control mb-2"></asp:DropDownList>
		<asp:TextBox runat="server" ID="txtRedirectUrl" class="form-control" placeholder="Enter Custom Url "></asp:TextBox>
		</div>
	</div>
	<div class="form-group">
        		<label>Response Code</label>
        		<asp:DropDownList runat="server" ID="dropResponseCode" class="form-control col-lg-3"></asp:DropDownList>
    	</div>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Cancel" ID="btnCancel" class="btn btn-secondary my-3 "/>
    </div>
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