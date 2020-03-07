<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_News_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $(".datepicker").datepicker();
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

  <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>
  
    <h1 runat="server" id="newsTitle"></h1>
  
    <asp:HiddenField ID="NewsId" runat="server" />

    <input type="hidden" name="id" value="<%= Request("Id") %>">
    
    <asp:CheckBox id="cbCornerstone" 
     Text="&nbsp;Cornerstone"
     OnCheckedChanged-=""
     runat="server"></asp:CheckBox><br>
     
    <asp:CheckBox id="cbFeatured" 
     Text="&nbsp;Featured"
     OnCheckedChanged-=""
     runat="server" name="Featured" style="display:none"></asp:CheckBox><br>

    <div class="form-group">
    <asp:Label runat="server" AssociatedControlID="Categories" Text="Category:"></asp:Label>
    <asp:DropDownList runat="server" ID="Categories" class="form-control col-lg-4"></asp:DropDownList>
    </div>
    
    <div class="form-group">
    <asp:Label runat="server" AssociatedControlID="txtTitle" Text="Title"></asp:Label>
    <asp:TextBox runat="server" ID="txtTitle" class="form-control col-lg-4"></asp:TextBox>
    </div>
    
    <div class="form-group">
    <asp:Label runat="server" AssociatedControlID="txtPubDate" Text="Publication Date" ToolTip="This story will be withheld from the news feed until this date."></asp:Label>
    <asp:TextBox runat="server" ID="txtPubDate" ToolTip="This story will be withheld from the news feed until this date." class="datepicker form-control col-lg-4"></asp:TextBox>
    </div>
    
    <div class="form-group">
    	<asp:Label runat="server" AssociatedControlID="filePicture" Text="Picture"></asp:Label>
    	<asp:FileUpload runat="server" ID="filePicture" class="form-control-file"></asp:FileUpload>
    	<div><asp:Image id="NewsStoryImage" runat="server"  class="form-control col-lg-3 img-fluid border-0" /></div>
    </div>
    
    <div class="form-group">
    	<asp:Label runat="server" AssociatedControlID="txtDescription" Text="Description"></asp:Label>
    	<asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Rows="4" class="form-control"></asp:TextBox>
    </div>
    
    <div class="form-group">
    <asp:Label runat="server" AssociatedControlID="txtContents" Text="Content"></asp:Label>
    <asp:TextBox runat="server" ID="txtContents" TextMode="MultiLine" class="ckeditor form-control col-lg-4"></asp:TextBox>
    </div>
    
     <div class="form-group">
    <asp:Label runat="server" AssociatedControlID="Slug" Text="Slug"></asp:Label>
    <asp:TextBox runat="server" ID="Slug" class="form-control col-lg-4"></asp:TextBox>
    </div>
    
    <div class="form-group">
  
   
        <asp:Button runat="server" ID="btnSave" Text="Save" class="btn btn-success my-3"/>
        <asp:Button runat="server" ID="btnSaveClose" Text="Save & Close" class="btn btn-outline-success my-3"/>
        <asp:Button runat="server" ID="btnCancel" Text="Cancel" class="btn btn-outline-secondary my-3"/>
    </div>
</asp:Content>