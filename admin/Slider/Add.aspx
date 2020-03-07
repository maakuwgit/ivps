<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit Slider Image</h1>
    
    <asp:HiddenField ID="Id" runat="server" />
    <p><asp:Label CssClass="input-label" runat="server" ID="lblSnippet"></asp:Label></p>
    <p><asp:Label CssClass="input-label" runat="server" ID="lblSnippet2"></asp:Label></p>
	<input type="hidden" value="<%= SliderData.Rows(0)("Id") %>" name="Id">
	<div class="">
		<label >Published</label>
	</div>
	
	<div class="form-group form-check form-check-inline">
		<input type="radio" name="published" value="1" <%= IIf(SliderData.Rows(0)("Published").ToString().Length() = 0 ORELSE SliderData.Rows(0)("Published") = 1, "checked", "") %> class="form-check-input">
		<label class="form-check-label" for="inlineCheckbox1">Yes</label>
	</div>
	<div class="form-check form-check-inline">
		<input type="radio" name="published" value="0" <%= IIf(SliderData.Rows(0)("Published").ToString().Length() = 0 ORELSE SliderData.Rows(0)("Published") = 0, "checked", "") %> >
     	<label class="form-check-label" for="inlineCheckbox1">&nbsp;No</label>
    </div>
    <div class="form-group">
        <label class="input-label" for="name">Order</label>
        <input type="text" value="<%= SliderData.Rows(0)("Seq") %>" name="Seq" class="form-control required">
    </div>
    <div class="form-group">
        <label class="input-label" for="name">Name</label>
        <input type="text" value="<%= SliderData.Rows(0)("Name") %>" name="Name" class="form-control required">
    </div>
    <div class="form-group">
        <label class="input-label" for="name">Title</label>
        <input type="text" value="<%= SliderData.Rows(0)("Title") %>" name="title" class="form-control">
    </div>
    <!--div class="form-group">
        <label class="input-label" for="description">Src (Use only if an image is not being uploaded)</label>
        <input type="text" value="<%= SliderData.Rows(0)("ImgSrc") %>" name="ImgSrc" class="form-control">
    </div-->
    <div class="form-group">
        <label class="input-label" for="description">Description</label>
        <textarea name="description" id="description" class="form-control"><%= SliderData.Rows(0)("Description") %></textarea>
    </div>
    <div class="form-group">
    	 <label class="fileUploadImage" for="description">Image</label>
    	<div class="custom-file">
			<asp:FileUpload runat="server" ID="fileUploadImage" class="custom-file-input"></asp:FileUpload>
			<asp:Label runat="server" AssociatedControlID="fileUploadImage" Text="Choose Image" class="custom-file-label"></asp:Label>
		</div>
	</div>
	<% If SliderData.Rows(0)("ImgSrc").ToString().Trim().Length() > 0 Then %>
    <div class="form-group">
    	<img src="<%= SliderData.Rows(0)("ImgSrc") %>" style="max-height:200px;display:inline-block;padding:1rem;">
	</div>
	<% End If %>
	   <%= Forms.AddFormChecker() %>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Save & Close" ID="btnSaveClose" class="btn btn-secondary my-3"/>
        <asp:Button runat="server" Text="Close" ID="btnCancel" class="btn btn-outline-secondary my-3"  OnClientClick="FormValidator.validate = false"/>
    </div>
    <!--script src="/ckeditor/ckeditor.js" type="text/javascript"></script-->
    <script type="text/javascript">
        //$(document).ready(function () { 
         //   CKEDITOR.replace("description");
       //});
    </script>
    
 
    
</asp:Content>