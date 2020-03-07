<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Bios_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/themes/redmond/jquery-ui.css" rel="Stylesheet" />
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/jquery-ui.js"></script>
    	<script type="text/javascript">
    	    $(function () {
    	        var availableCats = [
<% 
Dim con As New System.Data.SQLClient.SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
Dim AD as new System.Data.SQLClient.SQLDataAdapter("Select Distinct(Title) as Title from RCBio",con)
Dim DT as new system.data.datatable 
con.open()
ad.fill(dt)
for x as integer = 0 to dt.rows.count - 1 
    response.write("""" & dt.rows(x)("Title") & """")
    if x <> dt.rows.count - 1 then response.write(",")
next
con.close()


%>
                ];
    	        $("#ctl00_main_txtTitle").autocomplete({
    	            source: availableCats
    	        });
    	    });
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
        <h1>Staff Bio :: Add / Edit Member Info</h1><hr />
        <asp:HiddenField runat="server" ID="Id" />
        <img runat="server" id="img" src="" alt="Image" style="float:right; max-width:500px;" />

        <label for="ctl00_main_txtName">Name</label><br />
        <asp:TextBox runat="server" ID="txtName" required="required"></asp:TextBox><br /><br />

        <label for="ctl00_main_txtTitle">Title</label><br />
        <asp:TextBox runat="server" ID="txtTitle" required="required"></asp:TextBox><br /><br />

        <label for="ctl00_main_txtDesc">Description</label><br />
        <asp:TextBox runat="server" ID="txtDesc" TextMode="MultiLine"></asp:TextBox><br /><br />

        <label for="ctl00_main_fileUpload">Select Image<br /><em>Images should be at least 400 pixels tall.<br />Accepted file extensions: .jpg / .gif / .png</em></label><br />
        <asp:FileUpload runat="server" ID="fileUpload" /><br /><br />
        
        <label for="ctl00_main_txtSlug">Slug</label><br />
        <asp:TextBox runat="server" ID="txtSlug"></asp:TextBox><br /><br />
        
        <asp:Button ID="btnSave" runat="server" Text="Save" />
        <input type="button" onclick="history.go(-1)" value="Cancel"/>
</asp:Content>

