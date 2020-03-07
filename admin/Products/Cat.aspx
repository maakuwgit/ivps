<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Cat.aspx.vb" Inherits="Cat" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	<!--script src="/ckeditor/ckeditor.js" type="text/javascript"></script-->
	<script src="/admin/js/tinymce/tinymce.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
  <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>
    <h1>Category Editor</h1>
    <asp:HiddenField ID="Id" runat="server" />
    <div class="alert alert-info alert-dismissible fade show" role="alert" style="display:<%# iif(LCase(GetUserLoggedIn(Session("user")).email) = "rcc@romeocomp.com", "block", "none") %>">
    	<asp:Label CssClass="input-label" runat="server" ID="lblSnippet"></asp:Label>
	</div>
	
	<div class="form-group">
	<label for="ctl00_main_txtName">Parent</label><br />
	<asp:DropDownList runat="server" ID="parentid"></asp:DropDownList>
	</div>

    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Name</label>
        <asp:TextBox runat="server" ID="name" class="form-control col-12 col-lg-4"></asp:TextBox>
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtContent">Content</label>
        <textarea runat="server" id="description" class="form-control"></textarea>
    </div>
    <div class="form-group">
    	<asp:Button runat="server" Text="Save" ID="btnSaveContinueEdit" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Save & Close" ID="btnSave" class="btn btn-outline-secondary my-3"/>
        <asp:Button runat="server" Text="Close" ID="btnCancel" class="btn btn-outline-secondary my-3"/>
    </div>
    
       <script type="text/javascript">
       /* $(document).ready(function () { 
            CKEDITOR.replace("ctl00_main_txtContent");
        });*/
        
        tinymce.init({
    		selector: 'textarea',
    		height: 500,
		plugins: 'print paste preview code searchreplace autolink directionality visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount imagetools contextmenu colorpicker textpattern help',
 		 toolbar: 'template | undo redo | styleselect | formatselect | bold italic strikethrough forecolor backcolor | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat | link image code',
 		 image_advtab: true,
 		 image_title: true, 
 		 file_picker_types: 'image', 
 		 automatic_uploads: true,
		content_css: [
		    '/bootstrap/4.1.0/scss/bootstrap.css',
		    '/admin/_templates/styles.css'
		  ],
		  importcss_file_filter: "/bootstrap/4.1.0/scss/bootstrap.css",
		images_upload_url: '/admin/image/ImageUpload.ashx',
		templates: [
			{"title": "1 Column Row", "description": "1 column in a basic container and row", "url": "/admin/_templates/1-container-row.html"},
			{"title": "4x8 Column Row", "description": "4x8 columns in a basic container and row", "url": "/admin/_templates/4x8-container-row.html"},
			{"title": "6x6 Column Row", "description": "6x6 columns in a basic container and row", "url": "/admin/_templates/6x6-container-row.html"},
			{"title": "3x6x3 Column Row", "description": "3x6x3 columns in a basic container and row", "url": "/admin/_templates/3x6x3-container-row.html"},
			{"title": "4x4x4 Column Row", "description": "4x4x4 columns in a basic container and row", "url": "/admin/_templates/4x4x4-container-row.html"},

			{"title": "Full Width Container", "description": "Full Width Container", "url": "/admin/_templates/fluid-container.html"},
			{"title": "Basic Container", "description": "Basic Container", "url": "/admin/_templates/container.html"},
			{"title": "Row", "description": "Row", "url": "/admin/_templates/row.html"},
			
			{"title": "1 Column", "description": "1 column", "url": "/admin/_templates/1-column.html"},
			{"title": "4x8 columns", "description": "4x8 columns", "url": "/admin/_templates/4x8-columns.html"},
			{"title": "6x6 columns", "description": "6x6 columns", "url": "/admin/_templates/6x6-columns.html"},
			{"title": "3x6x3 columns", "description": "3x6x3 columns", "url": "/admin/_templates/3x6x3-columns.html"},
			{"title": "4x4x4 columns", "description": "4x4x4 columns", "url": "/admin/_templates/4x4x4-columns.html"},
			
		],
		image_class_list: [
			{title: 'Responsive', value: 'img-fluid img-responsive'},
			{title: 'Responsive Full Width', value: 'img-fluid img-responsive w-100'},
		],
		init_instance_callback: function (editor) {
            
          }
  	});
    </script>
</asp:Content>