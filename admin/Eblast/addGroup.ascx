<%@ Control Language="VB" CodeFile="addGroup.ascx.vb" Inherits="admin_emailCenter_addGroup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:ImageButton ID="btnAdd" ImageUrl="add.png" ToolTip="Add a New FAQ" ImageAlign="AbsMiddle" runat="server" />&nbsp;&nbsp;Add A New Group<br />

<ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server"
    TargetControlID="btnAdd"
    PopupControlID="pnl"
    BackgroundCssClass="modalBackground" 
    DropShadow="true" 
    CancelControlID="btnCancel" />
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="up" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
    <asp:Panel ID="pnl" CssClass="panelPopup" runat="server">
        
    <table width="700" cellpadding="10" cellspacing="0">
    <tr>
        <td width="100%" class="rowHeader" colspan="2">
        Add a New Group<br />
        </td>
    </tr>
    <tr>
        <td width="100%" class="rowContent" colspan="2">
        
        Title:<br />  
        <asp:TextBox ID="txtTitle" Width="100%" runat="server" /><br /> 
        <br />       
        
        Description:<br />  
        <asp:TextBox ID="txtDescription" Width="100%" runat="server" TextMode="MultiLine" Rows="7" /><br /> 
        <br />       
       
        </td>
    </tr>
    <tr>
        <td width="50%" class="rowFooter" style="text-align:left;">
        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" CssClass="button1" Text="Save" runat="server" /><br />
        </td>
        <td width="50%" class="rowFooter" style="text-align:right;">
        <asp:Button ID="btnCancel" Text="Cancel" CssClass="button1" runat="server" /><br />
        </td>
    </tr>
    </table>
        
    </asp:Panel>
</ContentTemplate>
</asp:UpdatePanel>