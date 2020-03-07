<%@ Page Title="" Language="VB" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Users_Add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">input[type="text"]{width:200px;}</style>
    <%If Not Request("Id") is Nothing andalso IsNumeric(Request("Id")) Then%>
    <script type="text/javascript">
        $(document).ready(function () {
            var dlg = $("#dvReset").dialog({ title: 'Reset Password', autoOpen: false, modal: true });
            dlg.parent().appendTo($("form:first"));
        });
        function CheckPasswords() {
            var Pass = $("#ctl00_main_txtPassword").val();
            var Pass2 = $("#ctl00_main_txtPassword2").val();
            if (Pass == Pass2) {
                $("#lblPass").html("&nbsp;");
                return true;
            }
            else {
                $("#dvReset").effect("bounce");
                $("#lblPass").html("The passwords don't match.");
                return false;
            }
        }
    </script>
    <%Else%>
        <script type="text/javascript">
            $(document).ready(function () { 
                $("#btnChangePW").hide();
            });
        </script> 
    <%End If%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="server">
<h1>Add / Edit User</h1>
<asp:Button runat="server" ID="btnSave" Text="Save" />
<asp:Button runat="server" ID="btnCancel" Text="Cancel" />
<input id="btnChangePW" type="button" value="Reset Password" style="margin-left:10px;" onclick="$('#dvReset').dialog('open')" />
<br />
<asp:Label ID="lblMsg" runat="server"></asp:Label>
<asp:HiddenField ID="Id" runat="server" /><br />
<div style="float:left; width:220px;">
    <%-- 
    <label for="ctl00_main_dlAccess">Access</label><label for="ctl00_main_txtFirstName"><br />
    <asp:DropDownList ID="dlAccess" runat="server">
        <asp:ListItem>User</asp:ListItem>
        <asp:ListItem>Power User</asp:ListItem>
        <asp:ListItem>Admin</asp:ListItem>
    </asp:DropDownList>
    --%>
    <br />
    <label for="ctl00_main_txtFirstName">First Name:</label><br />
    <asp:TextBox runat="server" ID="txtFirstName"></asp:TextBox><br />

    <label for="ctl00_main_txtLastName">Last Name:</label><br />
    <asp:TextBox runat="server" ID="txtLastName"></asp:TextBox><br />

    <label for="ctl00_main_txtPhone">Phone:</label><br />
    <asp:TextBox runat="server" ID="txtPhone"></asp:TextBox><br />

    <label for="ctl00_main_txtMobile">Mobile:</label><br />
    <asp:TextBox runat="server" ID="txtMobile"></asp:TextBox><br />

    <label for="ctl00_main_txtEmail">Email:</label><br />
    <asp:TextBox runat="server" ID="txtEmail"></asp:TextBox>
</div>
<div style="float:left; width:220px; padding-left:25px;">
    <br />
    <label for="ctl00_main_txtAddress">
    Address 1:</label><br />
    <asp:TextBox runat="server" ID="txtAddress"></asp:TextBox><br />

    <label for="ctl00_main_txtAddress2">Address 2:</label><br />
    <asp:TextBox runat="server" ID="txtAddress2"></asp:TextBox><br />

    <label for="ctl00_main_txtCity">City:</label><br />
    <asp:TextBox runat="server" ID="txtCity"></asp:TextBox><br />

    <label for="ctl00_main_txtState">State:</label><br />
    <asp:TextBox runat="server" ID="txtState"></asp:TextBox><br />

    <label for="ctl00_main_txtZip">Zip:</label><br />
    <asp:TextBox runat="server" ID="txtZip"></asp:TextBox>
</div>
<div id="dvReset" style="width:220px;">
    <label for="ctl00_main_txtPassword">Password:</label><br />
    <input type="password" runat="server" ID="txtPassword" autocomplete="off"/><br />
    <label for="ctl00_main_txtPassword2">Confirm Password:</label><br />
    <input type="password" runat="server" ID="txtPassword2" autocomplete="off"/><br />
    <div id="lblPass" style="color:#f00;">&nbsp;</div>
    <asp:Button runat="server" ID="btnReset" Text="Reset Password" OnClientClick="return CheckPasswords()" />
</div>
<div style="clear:both;">
    <label for="ctl00_main_txtNotes">Notes</label><br />
    <textarea runat="server" id="txtNotes" rows="4" cols="54"></textarea>
</div>
</asp:Content>