<%@ Page MasterPageFile="~/admin/Admin.master" Language="VB" CodeFile="default.aspx.vb" Inherits="Admin_email" ValidateRequest="false" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="ucContent" ContentPlaceHolderID="main" runat="server">
    <div id="container">
        <h1>Eblast Center</h1>
        <%  Response.WriteFile("nav.html")%>
        
        <br />
        <p>This is the NEW<b>ER</b> Email Center. To simply send an email, create a subject, and then paste the body of your message into the box below, or, create a new message using the editor.</p>
        <p><em>NOTE: If you are creating your message in Microsoft Word, be sure to select the PASTE FROM WORD button BEFORE pasting the content into the editor window because of formatting issues from MS WORD.</em></p>
        <hr />
        <br />
        
        Select Template:<br />
        <asp:radiobuttonlist ID="rblTemplate" OnSelectedIndexChanged="rblTemplate_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" runat="server">
            <asp:ListItem Text="None" Value="0" Selected="True" />
        </asp:radiobuttonlist><br />
    
        Select Recipient Group:<br />
        <asp:radiobuttonlist ID="rblGroup" OnSelectedIndexChanged="rblGroup_SelectedIndexChanged" AutoPostBack="true" runat="server">
            <asp:ListItem Text="I'll provide an email address below." value="0" Selected="True" />
            <asp:ListItem Text="Everyone in the Mailing List" Value="1" />
            <asp:ListItem Text="Select Group List" Value="2" />
        </asp:radiobuttonlist>
        <asp:DropDownList ID="ddlGroups" Visible="false" runat="server" /><br />
        <asp:Panel runat="server" ID="pnlEmail">
            Email Address: <br /><asp:TextBox runat="server" ID="txtEmail" Width="200"></asp:TextBox>
        </asp:Panel>
        
        <br />
    
         Subject:<br />
        <asp:textbox ID="txtSubject" Width="100%" runat="server" /><br />
        <br />
    
        <%--   BL 11/14/2011 It's scary how many broken features were lurking around in the email center...
        
        Attachment:<br />
        <asp:FileUpload ID="fileAttachment" runat="server" /><br />
        <br />
        --%>
        <textarea ID="ucFCK" class="ckeditor" runat="server"></textarea>
        <br />
        <asp:Label ID="lblMsg" CssClass="alert" runat="server" /><br />
        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" cssclass="buttonSubmit" Text="Send Email" runat="server" />
    </div>
    
</asp:Content>