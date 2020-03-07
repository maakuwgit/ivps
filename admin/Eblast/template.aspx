<%@ Page MasterPageFile="~/admin/Admin.master" CodeFile="template.aspx.vb" Inherits="admin_emailCenter_addTemplate" validateRequest="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
</asp:Content>
<asp:Content ID="ucContent" ContentPlaceHolderID="main" runat="server">
    <link href="/ckeditor/contents.css" rel="stylesheet" type="text/css" />
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
    <%--
    <script src="/ckfinder/ckfinder.js" type="text/javascript"></script>
    <script type="text/javascript">
        CKFinder.setupCKEditor(null, '/ckfinder/');
        var editor = CKEDITOR.replace('ucFCK');
    </script>
    --%>
<div id="container">
<asp:HiddenField ID="Id" runat="server" />
<h1>eBlast Template Creator</h1>
<%  Response.WriteFile("nav.html")%>
    <br />

    <label class="block" for="ctl00_main_txtTitle">Title</label>
    <asp:textbox ID="txtTitle" Width="100%"  runat="server" />
    <br />
    
    <label class="block" for="ctl00_main_txtDesc">Description</label>
    <asp:textbox ID="txtDesc" Width="100%" Rows="5" TextMode="MultiLine" runat="server" />
    <br />
    
    <label class="block" for="ctl00_main_txtSubject">Email Subject</label>
    <asp:textbox ID="txtSubject" Width="100%" runat="server" />
    <br />

    
    <label class="block" for="ctl00_main_ucFCK">Email Body</label>
    <textarea class="ckeditor" ID="ucFCK" runat="server" /><br />
    <center><asp:Label ID="lblMsg" CssClass="alert" runat="server" /></center><br />
    <center><asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" cssclass="buttonSave" Text="Save" runat="server" /></center>

</div>

</asp:Content>
