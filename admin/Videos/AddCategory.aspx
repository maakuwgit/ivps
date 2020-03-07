<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddCategory.aspx.vb" Inherits="afgadmin_Gallery_Add" ValidateRequest="false" MasterPageFile="~/admin/Admin.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title></title>
    <style type="text/css">
        label{display:block; font-weight:bold; margin-top:10px;
            margin-bottom: 0px;
        }
        select{padding:1px;}
        .button{width:80px; margin:auto 10px;}
        em{font-weight:normal;}
    </style>
    <link type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/themes/redmond/jquery-ui.css" rel="Stylesheet" />
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/jquery-ui.js"></script>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="main">
    <h1>Add New Video Category</h1><hr />
    <asp:HiddenField ID="Id" runat="server" />
        <label for="txtImgName">Category Name</label>
        <asp:TextBox runat="server" ID="txtCatName" required="required"></asp:TextBox>

        <label for="txtImgDesc">Description</label>
        <asp:TextBox runat="server" ID="txtCatDesc" TextMode="MultiLine"></asp:TextBox>

        <br />
        <br />
        <asp:Button ID="btnSave" runat="server" Text="Save" />
        <input type="button" onclick="history.go(-1)" value="Cancel"/>
</asp:Content>