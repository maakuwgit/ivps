<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="admin_Login" %>

<!DOCTYPE html>

<html lang="en-us">
<head runat="server">
    <title></title>
    <link type="text/css" rel="stylesheet" href="/bootstrap/4.1.0/scss/bootstrap.css" media="screen">
</head>
<body>

    <div class="d-flex flex-column align-items-center justify-content-center">
    <div class="p-3">
    	<img title="" target="" rel="" class=" img-fluid" style="" src="/images/logo.png">
    </div>
    <div class="p-3">
    	<form id="form1" runat="server">
    	<div class="form-group">
    		<label for="txtUserName">Username</label>
    		<asp:TextBox runat="server" ID="txtUserName" class="form-control"></asp:TextBox>
    	</div>
    	<div class="form-group">
    		<label for="txtPassword">Password</label>
    		<asp:TextBox runat="server" TextMode="Password" ID="txtPassword" class="form-control"></asp:TextBox>
    	</div>
    	<div class="form-group">
    		<asp:Button runat="server" ID="btnLogIn" Text="Log In" CssClass="login form-control btn btn-primary " />
    	</div>
    	<div class="form-group text-center">
    		<asp:LinkButton ID="lnkLostPW" runat="server" Text="Forgot your password?"></asp:LinkButton>
    	</div>
    	<div class="form-group">
    		<span id="lblMsg" runat="server" class="login"></span>
    	</div>
    	</form>
    </div>
    </div>
</body>
</html>

