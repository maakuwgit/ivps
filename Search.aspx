<%@  Page Title="" Language="VB" MasterPageFile="~/site.master" EnableEventValidation="false" AutoEventWireup="false" CodeFile="Search.aspx.vb" Inherits="Search" ValidateRequest="false" %>




<asp:Content runat="server" ContentPlaceHolderID="head">
    <script src="js/stupidtable.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">


   <div class="c"> 
       <div class="g12">
    <h1>Product Search</h1>
    <h4>Select Search Criteria</h4>
	
	<asp:Label ID="Label1" runat="server" AssociatedControlID="dlCols" Text="Category:"></asp:Label><br />
	<asp:DropDownList ID="dlCols" runat="server" AutoPostBack="True">
	        <asp:ListItem Text="Name" Value="1" />
	        <asp:ListItem Text="Output" Value="2" />
	        <asp:ListItem Text="Freq" Value="3" />
	        <asp:ListItem Text="Pulse" Value="4" />
        <asp:ListItem Text="Duty" Value="5" />
        <asp:ListItem Text="Eff" Value="6" />
        <asp:ListItem Text="Voltage" Value="7" />
        <asp:ListItem Text="Matching" Value="8" />
	    </asp:DropDownList>
   
        <br /><br />
    <asp:Label runat="server" AssociatedControlID="txtSearch" Text="Search Term:"></asp:Label><br />
    <asp:TextBox runat="server" ID="txtSearch" Width="300" MaxLength="100"></asp:TextBox> 
    <br /><br />
   <asp:Button runat="server" Text="Search Now" ID="btnSearch" /> &nbsp; <a href="/search.aspx">Clear Results</a>
             <div id="Results" runat="server"></div>
        
        
    
    </div>
       </div>
    
</asp:Content>
        
  
