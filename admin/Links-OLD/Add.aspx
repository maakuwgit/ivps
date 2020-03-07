<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Links_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style type="text/css">
        em{font-weight:normal;}
        textarea {width:600px; resize:vertical;}
        input[type=text] {width:200px;}
    </style>
    <link type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/themes/redmond/jquery-ui.css" rel="Stylesheet" />
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/jquery-ui.js"></script>
    	<script type="text/javascript">
    	    $(function () {
    	        var availableCats = [
<% 
Dim con As New System.Data.SQLClient.SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
Dim AD as new System.Data.SQLClient.SQLDataAdapter("Select Distinct(CatName) as CatName from RCLink",con)
Dim DT as new system.data.datatable 
con.open()
ad.fill(dt)
for x as integer = 0 to dt.rows.count - 1 
    response.write("""" & dt.rows(x)("CatName") & """")
    if x <> dt.rows.count - 1 then response.write(",")
next
con.close()


%>
                ];
    	        $("#ctl00_main_txtCatName").autocomplete({
    	            source: availableCats
    	        });
    	    });
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<h1>Site Content Editor</h1>
<asp:HiddenField ID="Id" runat="server" />

<label for="txtCatName" title="Begin typing to add to an existing category.
Type a new name to create in a new category.">Category</label><br />
<asp:TextBox runat="server" ID="txtCatName" title="Begin typing to add to an existing category.
Type a new name to create in a new category."></asp:TextBox><br /><br />

<label for="ctl00_main_txtName">Name</label><br />
<asp:TextBox runat="server" ID="txtName"></asp:TextBox><br /><br />

<label for="ctl00_main_txtName">Link</label><br />
<asp:TextBox runat="server" ID="txtLink" TextMode="MultiLine" Rows="3"></asp:TextBox><br /><br />

<label for="ctl00_main_txtDesc">Description</label><br />
<asp:TextBox runat="server" ID="txtDesc" TextMode="MultiLine" Rows="3"></asp:TextBox><br /><br />
<div style="display:none;">
    <label for="ctl00_main_fileUpload">Image</label><br />
    <asp:FileUpload ID="fileUpload" runat="server" /><br /><br />

    <label for="ctl00_main_txtContent">Content</label><br />
    <textarea runat="server" id="txtContent" class="ckeditor" readonly="readonly"></textarea>
</div>
<p>
    <asp:Button runat="server" Text="Save" ID="btnSave" />
    <asp:Button runat="server" Text="Cancel" ID="btnCancel" />
</p>
</asp:Content>