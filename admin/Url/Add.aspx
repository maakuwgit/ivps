<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
  <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>
    <h1>Add / Edit Website Link</h1>
    <asp:HiddenField ID="Id" runat="server" />
   <asp:Label ID="idlbl" runat="server"/> <br>
   <div class="form-group">
	<asp:CheckBox id="cbActive" Text="&nbsp;Active" runat="server" name="Active" ></asp:CheckBox>
     </div>
	
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Name</label><br>
        <asp:TextBox runat="server" ID="txtName" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtLabel">Label</label><br>
        <asp:TextBox runat="server" ID="txtLabel" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtUrl">Url</label><br>
        <asp:TextBox runat="server" ID="txtUrl" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtLocation">File Location</label><br>
        <asp:TextBox runat="server" ID="txtLocation" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtAction">Action</label><br>
        <asp:TextBox runat="server" ID="txtAction" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtProperties">Properties</label><br>
        <textarea runat="server" id="txtProperties" class="form-control" rows="5"></textarea>
    </div>
         <div class="form-group">
	<label>Parent Link (Optional)</label><br />
	<asp:DropDownList runat="server" ID="dropdownParents"></asp:DropDownList>
	</div>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Cancel" ID="btnCancel" class="btn btn-secondary my-3"/>
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