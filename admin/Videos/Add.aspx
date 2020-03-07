<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="afgadmin_Gallery_Add" ValidateRequest="false" MasterPageFile="~/Admin/Admin.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title></title>
    <style type="text/css">
        label{display:block; font-weight:bold; margin-top:10px;
            margin-bottom: 0px;
        }
        select{padding:1px;}
        .button{width:80px; margin:auto 10px;}
        em{font-weight:normal;}
    </style>
    <link type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/themes/redmond/jquery-ui.css" rel="Stylesheet" />
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/jquery-ui.js"></script>
    	<script type="text/javascript">
    	    $(function () {
    	        var availableCats = [

                ];
    	        $("#txtCatName").autocomplete({
    	            source: availableCats
    	        });
    	    });
	</script>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="main">
    <h1>Add New Video</h1><hr />
    <asp:HiddenField ID="Id" runat="server" />
    
        <label for="txtCatName" style="display:none;">Category<br /><em>Begin typing to add to an existing category.<br />Type a new name to create in a new category.</em></label>
        <asp:TextBox runat="server" ID="txtCatName" required="required" style="display:none;">></asp:TextBox>
<div class="form-group">
        <label for="txtImgName">Video Name</label>
        <asp:TextBox runat="server" ID="txtImgName" required="required" class="form-control"></asp:TextBox>
</div>
<div class="form-group">
        <label for="txtImgDesc">Description</label>
        <asp:TextBox runat="server" ID="txtImgDesc" TextMode="MultiLine" class="form-control" style="height:100px;"></asp:TextBox>
</div>
<div class="form-group">
        <label for="txtCode">Video URL<br /><em>Find a video on YouTube, right click the video, click "Copy video URL", and paste it in this box.</em></label>
        <asp:TextBox runat="server" ID="txtCode" TextMode="MultiLine" Columns="50" class="form-control" style="height:100px;"></asp:TextBox>
</div>
<div class="form-group">
        <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary"/>
        <input type="button" onclick="history.go(-1)" value="Cancel" class="btn btn-outline-secondary"/>
</div>
</asp:Content>