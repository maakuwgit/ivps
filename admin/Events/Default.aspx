<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/admin/admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Events_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".DatePicker").datepicker();
            var dlgSec = $("#dvSecurity").dialog({ title: 'Calendar Security', autoOpen: false, modal: true, resizable: false, width: 500, height: 270 });
            var dlgEdit = $("#dvEdit").dialog({ title: 'Edit Calendar Details', autoOpen: false, modal: true, resizable: false, width: 500, height: 320 });
            dlgSec.parent().appendTo($("form:first"));
            dlgEdit.parent().appendTo($("form:first"));
        });
        function Security() {
            $("#dvSecurity").dialog('open');
        }
        function MoveRightAll() {
            $("#ctl00_main_lbUser option").appendTo($("#ctl00_main_lbUserAccess"));
        }
        function MoveRight() {
            $("#ctl00_main_lbUser option:selected").appendTo($("#ctl00_main_lbUserAccess"));
        }
        function MoveLeftAll() {
            $("#ctl00_main_lbUserAccess option").appendTo($("#ctl00_main_lbUser"));
        }
        function MoveLeft() {
            $("#ctl00_main_lbUserAccess option:selected").appendTo($("#ctl00_main_lbUser"));
        }
        
    </script>
    <style type="text/css">
        .GridButton{width:80px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:ScriptManager runat="server" ID="SM"></asp:ScriptManager>
    <h1>Calendars</h1>
    &nbsp;<input runat="server" id="btnAll" visible="false" type="button" value="World View" onclick="location.href='/admin/Events/View.aspx?Id=KitchenSink'" />
    <asp:UpdatePanel runat="server" ID="asyncCalendars">
        <ContentTemplate>
            <asp:GridView ID="gvCal" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No calendars have been created yet.">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" />
                    <asp:BoundField DataField="Name" HeaderText="Calendar Name" />
                    <asp:BoundField DataField="Owner" HeaderText="Owner" />
                    <asp:BoundField DataField="Description" HeaderText="Description"/>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                        	<div class="btn-group">
                            <%Dim CurUser As RCCUser = GetUserLoggedIn(Session("user"))%>
                            <% If CurUser.access >= 11 Then%>
                                <asp:Button ID="Button1" runat="server" OnClick="Edit" Text="Edit" class="btn btn-outline-primary btn-sm" CommandArgument='<%#Eval("Id") %>' />
                                <asp:Button runat="server" OnClick="Permissions" Text="Security" class="btn btn-outline-primary btn-sm" CommandArgument='<%#Eval("Id") %>'  /><br />        
                            <% End If%>
                            <asp:Button runat="server" OnClick="View" Text="View" CssClass="GridButton" CommandArgument='<%#Eval("Id") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>    
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="dvSecurity">
        <asp:UpdatePanel runat="server" ID="asyncCal">
            <ContentTemplate>
                <asp:HiddenField ID="CalId" runat="server" />
                <asp:Label runat="server" ID="lblSecCalName" Font-Bold="true"></asp:Label><br />
                <div id="SecContainer">
                    <div id="dv1" style="margin-right:5px; max-height:155px; overflow:auto; border:2px solid #EFEFEF">
                        <asp:CheckBoxList runat="server" ID="ckL" RepeatColumns="3" RepeatDirection="Vertical" CellSpacing="10"></asp:CheckBoxList>
                    </div>
                    <br />
                    <asp:Button ID="btnSecSave" runat="server" Text="Save" />
                    <input type="button" value="Cancel" onclick="$('#dvSecurity').dialog('close')" />
                </div>
            <%--<div id="SecContainer">
                    <div class="SecUserList">
                        <asp:Label runat="server" AssociatedControlID="lbUser" Text="User List" /><br />
                        <select id="lbUser" multiple runat="server" class="UserList" enableviewstate="false">
                        
                        </select>
                    </div>
                    <div id="dvSecMid">
                        <input class="SecButton" type="button" onclick="MoveRight()" value="&gt;" />
                        <input class="SecButton" type="button" onclick="MoveRightAll()" value="&gt;&gt;" />
                        <input class="SecButton" type="button" onclick="MoveLeftAll()" value="&lt;&lt;" />
                        <input class="SecButton" type="button" onclick="MoveLeft()" value="&lt;" />
                    </div>
                    <div class="SecUserList">
                        <asp:Label runat="server" AssociatedControlID="lbUserAccess" Text="Assigned Users" /><br />
                        <select id="lbUserAccess" multiple= runat="server" class="UserList" enableviewstate="false">
                        
                        </select>
                    </div>
                    <div style="clear:both; padding-top:8px;">
                        
                    </div>
                </div>--%>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSecSave" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <div id="dvEdit">
        <asp:UpdatePanel runat="server" ID="asyncEdit">
            <ContentTemplate>
                <asp:HiddenField runat="server" ID="EditCalId" />
                <asp:Label runat="server" AssociatedControlID="dlOwner" Text="Owner"></asp:Label><br />
                <asp:DropDownList runat="server" ID="dlOwner" DataTextField="FullName" DataValueField="Id"></asp:DropDownList><br /><br />
                <asp:Label runat="server" AssociatedControlID="txtName" Text="Calendar Name"></asp:Label><br />
                <asp:TextBox runat="server" ID="txtName"></asp:TextBox><br /><br />
                <asp:Label runat="server" AssociatedControlID="txtDesc" Text="Description"></asp:Label><br />
                <asp:TextBox runat="server" ID="txtDesc" TextMode="MultiLine" Rows="4" Width="455"></asp:TextBox><br /><br />
                <asp:Button ID="btnEditSave" runat="server" Text="Save" />
                <input type="button" value="Cancel" onclick="$('#dvEdit').dialog('close')" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>