<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="GalleryDetail.aspx.vb" Inherits="admin_Gallery_GalleryDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            var dlg = $("#EditImage").dialog({ title: 'Add / Edit Image', autoOpen: false, modal: true, width: 380 });
            dlg.parent().appendTo($("form"));
            $("#btnEditName").click(function () {
                var dlg2 = $("#GalleryProps").dialog({title:'Gallery Name / Desc'}).toggleClass("sel");
                dlg2.parent().appendTo($("form"));
            });
            $("#ctl00_main_pnlPix").sortable({
                connectWith: ".defImage",
                stop: function (event, ui) {
                    $(".defImage").removeClass("sorting");
                    $("#ctl00_main_pnlPix .pnlPic").each(function (i) {
                        $("#ctl00_main_pnlPix .pnlPic").eq(i).children("input[type=hidden]").first().val(i.toString());
                        $.ajaxSetup({
                            url: 'UpdateSeq.ashx'
                        });
                        $.ajax({
                            data: { 'Id': $("#ctl00_main_pnlPix .pnlPic").eq(i).children("input[type=hidden]").eq(1).val(), 'Seq': $("#ctl00_main_pnlPix .pnlPic").eq(i).children("input[type=hidden]").first().val() }
                        });
                    });
                    $.ajaxSetup({
                            url: 'UpdateSeq.ashx'
                    });
                    $.ajax({
                        data: { 'Id': $(".defImage .pnlPic").eq(0).children("input[type=hidden]").eq(1).val(), 'Seq': '-1'}
                    });
                },
                start: function (event, ui) {
                    $(".defImage").addClass("sorting");
                },
            });
            $(".defImage").sortable({
                receive: function(event, ui){
                    $(".defImage .pnlPic").each(function(i, ctl){
                        if (!$(event.target).closest(".pnlPic").is(ctl)){
                            $("#ctl00_main_pnlPix").append(ctl);
                        }
                    });
                    $.ajaxSetup({
                        url: 'UpdateSeq.ashx'
                    });
                    $.ajax({
                        data: { 'Id': $(".defImage .pnlPic").eq(0).children("input[type=hidden]").eq(1).val(), 'Seq': '-1'}
                    });
                }
            });
        });
    </script>
    <style type="text/css">
        .pnlPic{text-align:center; float:left; padding:8px; border-radius:5px; display:inline-block; min-height:170px;}
        .pnlPic span{font-weight:bold; font-size:13px;}
        .imgdiv{background-position:center center; cursor:move; background-repeat:no-repeat; text-align:right; margin:0 auto 4px auto;}
        .imgdiv input{display:none;}
        .imgdiv:hover input{display:inline-block;}
        .pnlPic:hover{background-color:#333; color:#fff;}
        
        .defImage{height:160px; background-image:url('/admin/images/no-thumb.png'); background-repeat:no-repeat; width:240px; margin: 12px 0; padding-top:45px; background-color:#efefef; border:2px solid #aaa; background-position:center center; overflow:hidden;}
        .defImage .pnlPic:hover{color:#222; margin-bottom:20px;}
        .defImage .pnlPic{float:none; display:block; border-radius:0; background-color:inherit;}
        .defImage .imgdiv{
            cursor:default;
        }
        .sorting{
            border:2px dashed #222;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField runat="server" ID="GalleryId" />
     <p>
            <input type="button" value="Go Back" onclick="location.href='Default.aspx'" class="btn btn-secondary btn-sm my-3"/>
            <asp:Button ID="btnAddImage" runat="server" Text="Add Image(s)" class="btn btn-primary btn-sm my-3"/><br />
        </p>
    <h1>Editing Gallery :: <asp:Label runat="server" id="lblName"></asp:Label></h1>
    <div>
       
        <p>
            <input Id="btnEditName" type="button" value="Edit Name / Category" class="btn btn-secondary btn-sm my-3"/>
        </p>
        <div id="ShowProps">
            <div id="GalleryProps" style="display:none;">
                <asp:Label runat="server" AssociatedControlID="dlCat" Text="Category"></asp:Label><br />
                <asp:DropDownList runat="server" ID="dlCat"></asp:DropDownList><br /><br />
                <asp:Label runat="server" AssociatedControlID="txtGName" Text="Gallery Name"></asp:Label><br />
                <asp:TextBox runat="server" ID="txtGName"></asp:TextBox><br /><br />
                <asp:Label runat="server" AssociatedControlID="txtGDesc" Text="Description"></asp:Label><br />
                <asp:TextBox runat="server" ID="txtGDesc" TextMode="MultiLine" Rows="3" style="width:200px; max-width:300px; max-height:200px;"></asp:TextBox><br /><br />
                <asp:Button ID="btnSaveGalleryName" runat="server" Text="Save" />
            </div>
        </div>
    </div>
    <br />
    <asp:CheckBox runat="server" ID="chkShow" Text="Show Thumb Image in Gallery" AutoPostBack="True" />
    <div id="defImage" runat="server" class="defImage">
    
    </div>

    
    <asp:Panel runat="server" ID="pnlPix"></asp:Panel>
	<br style="clear:both" />
    <div id="EditImage">
        <asp:UpdatePanel runat="server" ID="asyncEditImage">
            <ContentTemplate>
                <div style="width:320px; float:left;">
                    <asp:Panel runat="server" ID="upload">
                        <asp:Label runat="server" AssociatedControlID="FileUpload" Text="Allowed file types: .jpg, .gif, .png"></asp:Label><br />
                        <div style="padding:10px;background:#eee;"><small><b>Important: Image size should be 1000px X 600px</b></small></div><br>
                        <asp:FileUpload runat="server" ID="FileUpload" multiple="multiple" /><br /><br />
                    </asp:Panel>
                    <asp:Label runat="server" AssociatedControlID="txtName" Text="Name"></asp:Label><br />
                    <asp:TextBox runat="server" Width="346" ID="txtName" MaxLength="128"></asp:TextBox><br /><br />
                    <asp:Label runat="server" Visible="false" AssociatedControlID="txtAlt" Text="Alt"></asp:Label>
                    <asp:TextBox runat="server" Visible="false" Width="346" MaxLength="128" ID="txtAlt"></asp:TextBox>
                    <asp:Label runat="server" AssociatedControlID="txtDesc" Text="Description"></asp:Label><br />
                    <asp:TextBox runat="server" ID="txtDesc" Width="346" MaxLength="1024" TextMode="MultiLine" Rows="3"></asp:TextBox><br /><br />
                    <asp:Button runat="server" ID="btnSave" Text="Save" />
                    <asp:Button runat="server" ID="btnCancel" Text="Cancel" />
                </div>
                <%--
                <div id="Cats" runat="server">
                    <asp:Label runat="server" AssociatedControlID="Cats" Text="Select Category(ies)"></asp:Label><br />
                </div>
                --%>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnAddImage" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                <asp:PostBackTrigger ControlID="btnSave" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>

