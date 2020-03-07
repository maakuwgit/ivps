<div class="container-fluid">
    <div class="container">
    		<nav class="footer navbar navbar-expand-lg p-0">
				<ul class="navbar-nav m-auto no-bullet">
					<li class="nav-item">
					<%= WebSite.Link("Products").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("Reviews").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("News").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("Videos").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("FAQ").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("Partners").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("Company").addClass("nav-link").createElement() %>
					</li>
					<li class="nav-item">
					<%= WebSite.Link("Contact").addClass("nav-link").createElement() %>
					</li>
				</ul>
			</nav>
	</div>
	   <div class="container">
			<div class="row">
            	<p class="m-auto text-blue-dark"><%= getCopyrightStatement() %> | <%= WebSite.Link("Privacy Policy").createElement() %> | <%= WebSite.Link("Terms of Service").createElement() %></p>
            </div>
        </div>
</div>


