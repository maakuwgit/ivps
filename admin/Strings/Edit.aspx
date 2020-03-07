<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Edit.aspx.vb" Inherits="admin_Strings_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    var origName;
    $(document).ready(function () {
        origName = $('#<%=txtName.clientid %>').val();
        if (!(origName == "")) {
            $('#<%=txtName.clientid %>').change(function () {
                if ($('#<%=txtName.clientid %>').val() == origName) {
                    $("#btnUndo").hide();
                }
                else {
                    alert('WARNING: Changing the name of a config string is dangerous.');
                    $("#btnUndo").show();
                }
            });
        }
        $("#btnUndo").click(function () {
            $('#<%=txtName.clientid %>').val(origName);
            $("#btnUndo").hide();
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit String Resource</h1>
    <asp:HiddenField runat="server" ID="StrId" />
    <asp:HiddenField runat="server" ID="CatId" />
    
    <div class="form-group">
    	<asp:Label runat="server" AssociatedControlID="txtName" Text="Name"></asp:Label>
    	<asp:TextBox runat="server" ID="txtName" MaxLength="50" class="form-control col-12 col-lg-4"></asp:TextBox>
    </div>
    
    <div class="form-group">
    	<asp:Label class="input-label" runat="server" AssociatedControlID="txtValue" Text="Value"></asp:Label>
    	<textarea runat="server" ID="txtValue" MaxLength="1024" TextMode="MultiLine" class="form-control"></textarea>
	</div>
	
	<div class="form-group">
    	<asp:Button runat="server" ID="btnSave" text="Save" class="btn btn-success my-3"/>
    	<asp:Button runat="server" ID="btnCancel" text="Close" class="btn btn-outline-secondary my-3"/>
	</div>
	
</asp:Content>