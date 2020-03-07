<% @Import Namespace="System.Data" %>
<a class="navbar-toggler text-white" data-toggle="sidenav" aria-label="Toggle navigation" title="Click to collapse the navigation">
	<svg class="icon"><use xlink:href="#icon__chevron--left"></use></svg>
</a>
<nav data-sidenav class="navbar p-0" aria-expanded="false">
	<div data-toggle>
		<%
			Dim MainMenuItems = ControllerFactory.Links.GetMainMenuItems()
			For Each Item As DataRow in MainMenuItems.Rows
		%>
			<%= WebSite.Link(Item("linkid")).addClass("nav-link").createElement() %>
		<%
			Next
		%>
	</div>
</nav>
<script>	
		document.addEventListener("DOMContentLoaded", function(){
			$("a[data-toggle='sidenav']").on('click', function(e){
				$(this).toggleClass("collapsed")
				$("nav[data-sidenav]").toggleClass("collapsed")
				let href = $(this).hasClass('collapsed') ? "#icon__chevron--right" : "#icon__chevron--left"
				let useElement = $(this)[0].firstElementChild.firstElementChild
				$(useElement).attr("href", href);
				$("main .viewport").toggleClass("collapsed")
			})
		});
	</script>