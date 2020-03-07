<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Promo_Add" ValidateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".DatePicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:HiddenField ID="PromoId" runat="server" Value="0" />
    

    <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>

    
    <h1>Add / Edit Promotion</h1>

<div class="form-group">	
  <asp:CheckBox id="cbFeatured" 
     Text="&nbsp;Featured"
     OnCheckedChanged-=""
     runat="server" name="Featured" ></asp:CheckBox>
</div>
     
<div class="form-group">	
    <asp:Label runat="server" AssociatedControlID="txtName" Text="Name"></asp:Label><br />
    <asp:TextBox runat="server" ID="txtName" Width="300" required="required" MaxLength="128" class="form-control"></asp:TextBox>
</div>
<div class="form-group">	
    <asp:Label runat="server" AssociatedControlID="FileUpload1" Text="Upload a Photo"></asp:Label><br />
    <asp:FileUpload runat="server" ID="FileUpload1" />
</div>
<div class="form-group">	
    <asp:Label runat="server" AssociatedControlID="txtStartDt" Text="Start Date"></asp:Label><br />
    <asp:TextBox runat="server" CssClass="DatePicker" ID="txtStartDt" class="form-control"></asp:TextBox>
</div>
<div class="form-group">	
    <asp:Label runat="server" AssociatedControlID="txtEndDt" Text="End Date"></asp:Label><br />
    <asp:TextBox runat="server" CssClass="DatePicker" ID="txtEndDt" class="form-control"></asp:TextBox>
</div>
<div class="form-group">	
    <asp:Label runat="server" AssociatedControlID="txtDesc" Text="Description"></asp:Label><br />
    <TextArea runat="server" ID="txtDesc" Style="Width:600px;" MaxLength="1000" class="form-control"></Textarea>
</div>
<div class="form-group">	
    <asp:Label runat="server" AssociatedControlID="FileUpload" Text="Upload a PDF Attachment"></asp:Label><br />
    <asp:FileUpload runat="server" ID="FileUpload" />
</div>
<div class="form-group">	
    <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-primary"/>
    <input type="button" value="Cancel" onclick="location.href='/Admin/Promo/'" class="btn btn-secondary"/>
    </div>
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
	<script type="text/javascript">
        $(document).ready(function () { 
            CKEDITOR.replace("ctl00_main_txtDesc");
        });
    </script>
</asp:Content>