<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Strings_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        var dlgCat;
        var dlgStr;
        var acops = { autoHeight: false, collapsible: true, active: false }
        $(document).ready(function () {
            dlgCat = $("#AddCat").dialog({ title: 'Add / Edit Category', autoOpen: false, modal: true });
            dlgStr = $("#AddString").dialog({ title: 'Add / Edit String', autoOpen: false, modal: true });
            dlgCat.parent().appendTo($("form"));
            dlgStr.parent().appendTo($("form"));
            $("#accordion").load("/admin/strings/cats.ashx", function () {
                $("#accordion").accordion(acops);
            });
            $("#btnAddCat").click(function () {
                $("#txtCatName").val("");
                $("#AddCat").dialog("open");
            });
            $("#btnCatOk").click(function () {
                AddCategory();
            });
            $("#btnCatCancel").click(function () {
                dlgCat.dialog("close");
            });
            $("#btnStrOk").click(function () {
                SaveString();
            });
            $("#btnStrCancel").click(function () {
                dlgStr.dialog("close");
            });
        });
        function AddCategory() {
            $.ajaxSetup({
                data: { "name": $("#txtCatName").val() },
                complete: function (evt) {
                    if (evt.status == 200) {
                        dlgCat.dialog("close");
                        $("#accordion")
                            .accordion("destroy")
                            .load("cats.ashx", $.noop(), function () {
                                $(this).accordion(acops);
                                $(this).fadeIn();
                            });
                    }
                    else {
                        alert(evt.statusText);
                    }
                }
            });
            $.ajax("/admin/Strings/AddCat.ashx");
        }

        function LoadCat(obj, Id) {
            $.ajaxSetup({
                data: { "Id": Id }
            });
            $(obj).parent().next().load("CatDetail.ashx");
        }

        function AddString(CatId) {
            dlgStr.dialog("open");
            $("#StrId").val(-1);
            $("#CatId").val(CatId);
        }

        function SaveString() {
            dlgStr.dialog("close");
            $.ajaxSetup({
                data: {
                    "StrId": $("#StrId").val(),
                    "CatId": $("#CatId").val(),
                    "Name": $("#txtStrName").val(),
                    "Val": $("#txtStrVal").val()
                },
                complete: function () {
                    if (evt.status == 200) {
                        dlgStr.dialog("close");
                    }
                    else {
                        alert(evt.statusText);
                    }
                }
            });
            $.ajax("/admin/Strings/AddString.ashx");
        }
    </script>
    <style type="text/css">
        label{display:block; margin-top:8px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <input type="button" id="btnAddCat" value="Add Category" />
    <div id="accordion">
    </div>
    <div id="AddCat">
        <label for="txtCatName" style="">Name:</label>
        <input type="text" id="txtCatName" autofocus="true" maxlength="50" /><br />
        <input type="button" id="btnCatOk" value="Save" />
        <input type="button" id="btnCatCancel" value="Cancel" />
    </div>
    <div id="AddString">
        <input type="hidden" id="StrId" />
        <input type="hidden" id="CatId" />
        <label for="txtStrName">Name:</label>
        <input type="text" id="txtStrName" maxlength="50" />
        
        <label for="txtStrVal">Value:</label>
        <textarea id="txtStrVal" maxlength="1024" rows="3" cols="24"></textarea><br />
        <input type="button" id="btnStrOk" value="Save" />
        <input type="button" id="btnStrCancel" value="Cancel" />
    </div>
</asp:Content>

