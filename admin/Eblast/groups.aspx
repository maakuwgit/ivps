<%@ Page MasterPageFile="~/Admin/Admin.master"  Language="VB" CodeFile="groups.aspx.vb" Inherits="admin_emailCenter_groups" %>
<%@ Register TagPrefix="rcc" TagName="add" Src="addGroup.ascx" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .movebutton{display:block; width:130px;}
        p{margin:0; padding:0;}
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var dlg = $("#emaillist").dialog({ title: 'Paste Email Addresses Below', autoOpen: false, modal: true, width: 510 });
            dlg.parent().appendTo("form").first();
            $("#btnAddEmails").click(function () {
                $("#emaillist textarea").val("");
                $("#emaillist").dialog("open");
            });
            $("#btnCancel").click(function(){
                $("#emaillist").dialog("close");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="ucContent" ContentPlaceHolderID="main" runat="server">

<div id="container">

    <div style="width:50%;float:left;">
        <h1>Eblast Groups</h1>
    </div>
    <div style="width:50%;float:left;">
        <rcc:add ID="ucAdd" runat="server" />
    </div>
    <div style="clear:both;"></div>

    <%  Response.WriteFile("nav.html")%>
    <br />
    <div id="lblMsg" style="font-weight:bold;" runat="server"></div>
    <label for="ctl00_main_ddlGroups">Select a Group</label>
    <asp:DropDownList ID="ddlGroups" AutoPostBack="true" runat="server" /><br />

    <br />

    <div style="width:200px;float:left;">
        <p><strong>Assigned Emails</strong></p>
        <asp:ListBox ID="lstGroups" Width="200px" Height="200px" runat="server" SelectionMode="Multiple" />
    </div>
    <div style="float:left;width:130px;text-align:center;">
        <div style="border-bottom:2px solid #333;">
            <br />
            <p><strong>Add</strong></p>
            <asp:Button ID="btnAddAll" Text="< Add All <" CssClass="movebutton" OnClick="btnAddAll_Click" runat="server" />
            <asp:Button ID="btnAdd" Text="< Add Sel <" CssClass="movebutton" OnClick="btnAdd_Click" runat="server" />
        </div>
        <div>
            <p><strong>Remove</strong></p>
            <asp:Button ID="btnRemove" Text="> Remove Sel >" CssClass="movebutton" OnClick="btnRemove_Click" runat="server" />
            <asp:Button ID="btnRemoveAll" Text="> Remove All >" CssClass="movebutton" OnClick="btnRemoveAll_Click" runat="server" />
        </div>
    </div>
    <div style="width:200px;float:left;">
        <p><strong>Available Emails</strong></p>
        <asp:ListBox ID="lstUsers" Width="200px" Height="200px" runat="server" SelectionMode="Multiple" /><br />
        <asp:Button ID="btnDeleteUser" Text="Delete" CssClass="buttonCancel" Onclick="btnDeleteUser_Click" runat="server" />
        <input type="button" id="btnAddEmails" value="Add Emails" />
        <br />
    </div>
    <div style="clear:both;"></div>
</div>
<div id="emaillist">
    <p>Paste any text that contains valid email addresses below. Email addresses must be separated by white space or commas.</p>
    <textarea runat="server" id="txtEmails" rows="20" cols="50"></textarea>
    <asp:Button runat="server" ID="btnSubmitEmails" Text="Submit" />
    <input type="button" id="btnCancel" value="Cancel" />
</div>
</asp:Content>