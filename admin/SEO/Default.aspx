<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="SEO_Default" %>

<asp:Content ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ContentPlaceHolderID="main" Runat="Server">
    <h1>Search Engine Optimization</h1>
    <hr>
	<div >
	<b>Add a page to the SEO Module</b>
	<p>
	Copy everything after the domain name, from the first slash (including the slash) through the end.
	Paste below, Save and Refresh the page.
	</p>
	</div>
	
	
	<div class="form-group">
		<label for="ctl00_main_lbPageAdd">Select Page</label>
        <asp:TextBox runat="server" ID="txtPageAdd" AutoPostBack="True" class="form-control col-lg-4"></asp:TextBox>
    </div>
    <div class="form-group">
		<asp:Button Text="Save New Page" runat="server" ID="btnPageAdd" class="btn btn-success my-3"/>
	</div>
	<hr>
    <div class="form-group">
        <label for="ctl00_main_lbPage">Select Page</label>
        <asp:ListBox runat="server" ID="lbPage"  AutoPostBack="True" class="form-control" Rows="20">
        </asp:ListBox>
    </div>
 

    
    <div class="form-group">
        <label class="block" for="ctl00_main_txtTitle">Title</label>
        <asp:TextBox runat="server" ID="txtTitle" MaxLength="1024" class="form-control col-lg-4"></asp:TextBox>
	</div>
    
    <div class="form-group">
        <label class="block" for="ctl00_main_txtDesc">Description</label>
        <asp:TextBox runat="server" ID="txtDesc" Rows="4" TextMode="MultiLine" MaxLength="1024" class="form-control"></asp:TextBox>
        <asp:Button  id="btnPageRemove" type="button" runat="server" Text="Remove Page" class="btn btn-warning my-3" OnClientClick="return confirm('Are you sure?')"/>
	</div>
    
    <div class="form-group">
        <label class="block" for="ctl00_main_txtKeywords">Keywords</label>
        <asp:TextBox runat="server" ID="txtKeywords" Rows="4" TextMode="MultiLine" MaxLength="1024" class="form-control"></asp:TextBox>
       </div>
     <div class="form-group">
        <label class="block" for="ctl00_main_txtStructuredData">StructuredData</label>
        <asp:TextBox runat="server" ID="txtStructuredData" Rows="4" TextMode="MultiLine" MaxLength="2048" class="form-control"></asp:TextBox>
       </div>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <input id="btnView" type="button" runat="server" value="View Page" class="btn btn-secondary my-3"/>
        </div><br />
		<a href="https://www.google.com/webmasters/markup-helper/" target="_blank">Structured Data Tool</a><br />
		<a href="https://search.google.com/structured-data/testing-tool" target="_blank">Structured Data Testing Tool</a> <br />
		<a href="http://www.rccwebmedia.com/images/StructuredDataExample.txt" target="_blank">Sample Local Business</a> (use link above to build other strucured data strings).
    
    

 <hr>
 
    
    <div class="form-group">
        <label class="block" for="ctl00_main_txtRobots">Robots.txt</label>
        <textarea runat="server" id="txtRobots" rows="10" class="form-control"></textarea><br />
        <asp:Button Text="Save Robots.txt" runat="server" ID="btnSaveRobots" class="btn btn-success my-3"/>
        <asp:Label runat="server" ID="lblRobots"></asp:Label>
    </div>
</asp:Content>