<header class="col-12" id="page-header">
	<h1>
<% 
	Dim PageTitle = Website.Content.GetTitleOfPage(Website.Router.QueryString("id"))
	If PageTitle.ToString().Length() > 0 Then 
%>
	<%= PageTitle %>
<% Else %>
	<%= WebSite.Link(Website.Router.QueryString("id")).GetLabel()%>
<% End If %>
	</h1>
	<hr>
	<form runat="server">
		<asp:TextBox type="number" name="coverage_area_search" placeholder=" Search by Zipcode" ID="txtZipSearch" runat="server" pattern="[0-9]{5}"></asp:TextBox> 
		<asp:button runat="server" class="btn btn--icon" id="btnSearch" text="Go!">
		</asp:button>
	</form>
</header> 