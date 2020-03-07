<footer class="seafoam pattern container py-2">
	<div class="row between align-items-center">
		<small><%= Website.Company.CopyrightStatement %></small>
		<%
			Dim FooterMainMenuItems = ControllerFactory.Links.GetFooterMenuItems()
			If FooterMainMenuItems.Rows.Count > 0 Then
		%>
		<nav data-footer- class="ml-auto">
			<ul class="list-inline no-bullet m-auto">

				<% For Each Item As DataRow in FooterMainMenuItems.Rows %>
				
				<li class="list-inline-item text-dark">
					<%= WebSite.Link(Item("linkid")).addClass("").createElement() %>
				</li>

				<% Next %>

			</ul>
		</nav>
		<% End If %>
	</div>
</footer>