<% @Import Namespace="System.Data" %>
<aside id="carouselImageSlider" class="carousel slide" data-ride="carousel" data-interval="5000" data-pause="hover">
	<div class="carousel-inner" role="listbox">
	<%
		Dim SilderData as DataTable =  ControllerFactory.ImageSlider.All
		Dim FirstItem = true
		Dim addClass = ""
		For Each dr As DataRow In SilderData.Rows
	
			If FirstItem Then
				FirstItem = false
				addClass = " active"  
			Else
				addClass = ""
			End If 
	%>
	<figure title="<%= dr("title") %>" alt="<%= dr("title") %>" class="carousel-item<%= addClass%> p-2" style="background:url(<%= dr("ImgSrc") %>);background-size:cover;background-position:center;height:50vh;">
	<% If( dr("Title").toString().length > 0 ) %>
		<figcaption class="carousel-caption d-none d-md-block">
			<h2><%= dr("Title") %></h2>
			<% If( dr("Description").toString().length > 0 ) %>
			<p><%= dr("Description") %></p>
			<% End If %>
		</figcaption>
	<% End If %>
	</figure>
	<%	
		Next
	%>
	</div>
<% If SilderData.Rows.Count > 1 Then %>
	<nav data-carousel-nav>
		<a class="carousel-control-prev" href="#carouselImageSlider" data-slide="prev" aria-label="Previous Slide">
			<svg class="carousel-control-prev-icon" aria-hidden="true">
				<use xlink:href="#icon__chevron--left"></use>
			</svg>
		</a>
		<a class="carousel-control-next" href="#carouselImageSlider" data-slide="next" aria-label="Next Slide">
			<svg class="carousel-control-next-icon" aria-hidden="true">
				<use xlink:href="#icon__chevron--right"></use>
			</svg>
		</a>
	</nav>
<% End If %>		
</aside>