<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="admin_Events_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="/admin/events/js/fullcalendar.css" rel="stylesheet" type="text/css" />
    <link href="/admin/events/js/fullcalendar.print.css" rel="stylesheet" type="text/css" media="print" />
    <script src="/admin/events/js/fullcalendar.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var EvtUpdate;
        $(document).ready(function () {
            $(".DatePicker").datepicker();
            var dlg = $("#event").dialog({ title: 'Add / Edit Event', autoOpen: false, modal: true, resizable: false, width: 625 });
            dlg.parent().appendTo($("form:first"));
            $("#calendar").fullCalendar({
                eventSources: [
                    {
                        url: '/admin/Events/Events.ashx?CalId=1',
                        color: '#36C',
                        textColor: '#fff'
                    },
                    {
                        url: '/admin/Events/Events.ashx?CalId=2',
                        color: '#3C6',
                        textColor: '#fff'
                    },
                    {
                        url: '/admin/Events/Events.ashx?CalId=3',
                        color: '#C36',
                        textColor: '#fff'
                    },
                    {
                        url: '/admin/Events/Events.ashx?CalId=4',
                        color: '#000',
                        textColor: '#fff'
                    },
                    {
                        url: '/admin/Events/Events.ashx?CalId=5',
                        color: '#C63',
                        textColor: '#fff'
                    }
                ],
                editable: true,
                disableDragging: true,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                eventClick: function (event, jsEvent, view) {
                    $("#<%=btnDelete.ClientId %>").show();
                    $(".error").removeClass("error");
                    EvtUpdate = event;
                    $("#ctl00_main_EventId").val(event.id);
                    __doPostBack('ctl00_main_EventId', '');
                    $('#event').dialog('open');
                },
                dayClick: function (d) {
                    $('#dvCals input[type=checkbox]').removeAttr('checked');
                    $("#<%=btnDelete.ClientId %>").hide();
                    $(".error").removeClass("error");
                    $("#event").dialog('open');
                    $("#ctl00_main_EventId").val(0);
                    $("#ctl00_main_txtTitle").val("");
                    $("#ctl00_main_txtDesc").val("");
                    $(".DatePicker").datepicker("setDate", d);
                }
            });
        });
    </script>
    <style type="text/css">
        .EventField{width:290px;}
        .DatePicker{width:100px;}
        .error{background-color:#FEF1EC;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="calendar"></div>
    <div id="event">
        <asp:UpdatePanel runat="server" ID="asyncEvent" UpdateMode="Conditional">
            <ContentTemplate>
                <div style="float:left; width:300px;">
                    <asp:HiddenField runat="server" ID="CalendarId" />
                    <asp:HiddenField runat="server" ID="EventId" />
                
                    <asp:Label runat="server" AssociatedControlID="txtTitle" Text="Title"></asp:Label><br />
                    <asp:TextBox runat="server" ID="txtTitle" CssClass="EventField" MaxLength="100"></asp:TextBox><br /><br />
                    <asp:Label runat="server" AssociatedControlID="txtDesc" Text="Description"></asp:Label><br />
                    <asp:TextBox runat="server" ID="txtDesc" TextMode="MultiLine" CssClass="EventField" Rows="3" MaxLength="2048"></asp:TextBox><br /><br />
                    <asp:Label runat="server" AssociatedControlID="txtStart" Text="Start"></asp:Label><br />
                    <asp:TextBox runat="server" ID="txtStart" CssClass="DatePicker"></asp:TextBox>
                    <asp:DropDownList runat="server" ID="dlSHour">
                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="7" Value="7"></asp:ListItem>
                        <asp:ListItem Text="8" Value="8" selected="True"></asp:ListItem>
                        <asp:ListItem Text="9" Value="9"></asp:ListItem>
                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                        <asp:ListItem Text="11" Value="11"></asp:ListItem>
                        <asp:ListItem Text="12" Value="12"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" ID="dlSMinute">
                        <asp:ListItem Text="00" Value="00"></asp:ListItem>
                        <asp:ListItem Text="15" Value="15"></asp:ListItem>
                        <asp:ListItem Text="30" Value="30"></asp:ListItem>
                        <asp:ListItem Text="45" Value="45"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" ID="dlSPeriod">
                        <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                        <asp:ListItem Text="PM" Value="AM"></asp:ListItem>
                    </asp:DropDownList>
                    <br /><br />
                    <asp:Label runat="server" AssociatedControlID="txtEnd" Text="End"></asp:Label><br />
                    <asp:TextBox runat="server" ID="txtEnd" CssClass="DatePicker"></asp:TextBox>
                    <asp:DropDownList runat="server" ID="dlEHour">
                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="7" Value="7"></asp:ListItem>
                        <asp:ListItem Text="8" Value="8" selected="True"></asp:ListItem>
                        <asp:ListItem Text="9" Value="9"></asp:ListItem>
                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                        <asp:ListItem Text="11" Value="11"></asp:ListItem>
                        <asp:ListItem Text="12" Value="12"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" ID="dlEMinute">
                        <asp:ListItem Text="00" Value="00"></asp:ListItem>
                        <asp:ListItem Text="15" Value="15"></asp:ListItem>
                        <asp:ListItem Text="30" Value="30" selected="True"></asp:ListItem>
                        <asp:ListItem Text="45" Value="45"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" ID="dlEPeriod">
                        <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                        <asp:ListItem Text="PM" Value="AM"></asp:ListItem>
                    </asp:DropDownList>
                    <br /><br />
                    <asp:CheckBox runat="server" ID="ckAllDay" Text="All Day Event" /><br /><br />
                    <asp:Button runat="server" ID="btnSave" Text="Save" />
                    <input type="button" runat="server" value="Cancel" onclick="$('#event').dialog('close')" />
                    <input id="btnDelete" style="float:right;" type="button" runat="server" value="Delete Event" onclick="$('#deleteConf').slideDown()" />
                    <div id="deleteConf" style="display:none; text-align:right;">Are you sure? <asp:LinkButton runat="server" ID="lnkDelete" Text="Yes" style="color:#f36;"></asp:LinkButton> | <a href="#" style="color:#36C;" onclick="$('#deleteConf').slideUp()">No</a> </div>
                </div>
                <div id="dvCals" style="float:right; height:380px; width:275px; overflow:auto; padding:5px; border:2px solid #EFEFEF">
                    <label>Display on these calendar(s):</label><br />
                    <a href="#" style="color:#36C" onclick="$('#dvCals input[type=checkbox]').attr('checked', 'checked');">Select All</a> |
                    <a href="#" style="color:#36C" onclick="$('#dvCals input[type=checkbox]').removeAttr('checked');">Clear Selection</a>
                    <hr />
                    <asp:CheckBoxList runat="server" ID="cklCalendars"></asp:CheckBoxList>
                </div>
                <div style="clear:both;"></div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="lnkDelete" EventName="Command" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>

