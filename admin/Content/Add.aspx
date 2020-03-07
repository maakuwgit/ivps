<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	<!--script src="/ckeditor/ckeditor.js" type="text/javascript"></script-->
	<script src="/admin/js/tinymce/tinymce.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Content Editor</h1>
    <asp:HiddenField ID="Id" runat="server" />
    <div class="alert alert-info alert-dismissible fade show" role="alert" style="display:<%# iif(LCase(GetUserLoggedIn(Session("user")).email) = "rcc@romeocomp.com", "block", "none") %>">
    	<asp:Label CssClass="input-label" runat="server" ID="lblSnippet"></asp:Label>
	</div>
	
	<div class="form-group">
	<label for="ctl00_main_txtName">Page</label><br />
	<asp:DropDownList runat="server" ID="dropDownPages"></asp:DropDownList>
	</div>

    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Name</label>
        <asp:TextBox runat="server" ID="txtName" class="form-control col-12 col-lg-4"></asp:TextBox>
    </div>
    
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Page Title</label>
        <asp:TextBox runat="server" ID="txtTitle" class="form-control col-12 col-lg-4"></asp:TextBox>
    </div>
    
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtContent">Content</label>
        <textarea runat="server" id="txtContent" class="form-control"></textarea>
    </div>
    <div class="form-group">
    	<asp:Button runat="server" Text="Save" ID="btnSaveContinueEdit" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Save & Close" ID="btnSave" class="btn btn-outline-secondary my-3"/>
        <asp:Button runat="server" Text="Close" ID="btnCancel" class="btn btn-outline-secondary my-3"/>
    </div>
    
       <script type="text/javascript">
       tinymce.init({
    		selector: 'textarea',
    		height: 500,
		plugins: 'print paste preview code searchreplace autolink directionality visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount imagetools contextmenu colorpicker textpattern help',
 		 toolbar: 'template | undo redo | styleselect | formatselect | bold italic strikethrough forecolor backcolor | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat | link image code',
 		 image_advtab: true,
 		 image_title: true, 
 		 file_picker_types: 'image', 
 		 cleanup_on_startup: false,
            trim_span_elements: false,
            verify_html: false,
            cleanup: false,
            convert_urls: false,
		content_css: [
		    '/bootstrap/4.1.0/scss/bootstrap.css',
		    '/admin/_templates/styles.css'
		  ],
		  importcss_file_filter: "/bootstrap/4.1.0/scss/bootstrap.css",
		images_upload_url: '/admin/image/ImageUpload.ashx',
		templates: [
			{"title": "Container", "description": "", "url": "/admin/_templates/container.html"},
			{"title": "Row", "description": "", "url": "/admin/_templates/row.html"},
		],
		image_class_list: [
			{title: 'Responsive', value: 'img-fluid img-responsive'},
			{title: 'Responsive Full Width', value: 'img-fluid img-responsive w-100'},
		],
		init_instance_callback: function (editor) {
            editor.on('KeyDown', function (e) {
			    if(e.keyCode == 27) {
				 let editor = tinyMCE.activeEditor
				 const dom = editor.dom
				 const parentBlock = tinyMCE.activeEditor.selection.getSelectedBlocks()[0]
				 const containerBlock = parentBlock.parentNode.nodeName == 'BODY' ? dom.getParent(parentBlock, dom.isBlock) : dom.getParent(parentBlock.parentNode, dom.isBlock)
				 let newBlock = tinyMCE.activeEditor.dom.create('p')
				 newBlock.innerHTML = '<br data-mce-bogus="1">';
				 dom.insertAfter(newBlock, containerBlock)
				 let rng = dom.createRng();
				 newBlock.normalize();
				 rng.setStart(newBlock, 0);
				 rng.setEnd(newBlock, 0);
				 editor.selection.setRng(rng);
			    }
		  });
          }
  	});
    </script>
</asp:Content>