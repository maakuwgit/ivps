<% @Import Namespace="System.Data" %>
<link rel="stylesheet" type="text/css" href="/css/starability-minified/starability-all.min.css"/>
<div id="carouselReviews" class="carousel slide" data-ride="carousel" data-interval="7000" data-pause="hover">
<!-- Wrapper for slides -->
<div class="carousel-inner" role="listbox">
<div class="carousel-item active">
<div class="row">
<%
	Dim reviewsdata as DataTable =  ReviewsWidget.topRandom(9) 
	Dim rwFirstItem = true
	Dim rwGridCounter = 1
	Dim rwGridCount = 3
	For Each dr As DataRow In reviewsdata.Rows
%>


<% 
		If rwGridCounter > rwGridCount Then
			rwGridCounter = 1
	%>
		</div>
		</div>
		<div class="carousel-item">
		<div class="row" class="min-height">
	
	<%
		End If
	%>
	
<div class="col-lg-4 text-white d-flex align-items-stretch">
<div>
<p>
<a data-fancybox data-src="#<%= dr.item("id") %>-more" href="javascript:;" class="text-white-"><%= TruncateString(dr.Item("quote"), 250) %></a>
</p>
<div>
<% 
If Not dr.IsNull("RatingValue") Then
	Response.Write("<fieldset class=""starability-basic text-center"" style=""display:inline-block;width:auto;"">")
	For value As Integer = 1 To dr("RatingValue")
		Response.Write("<label></label>")
	Next
	Response.Write("</fieldset>")
End If
%>
</div>
<div class="text-left" style="font-style:italic;font-size:14px;font-weight:bold;"><%= dr.item("firstname") %> <%= dr.item("lastname") %></div>
</div>
</div>
<!-- Review Popup -->
<div style="display: none;" id="<%= dr.item("id") %>-more" class="col-11 col-lg-5">
	<% 
	If Not dr.IsNull("RatingValue") Then
		Response.Write("<fieldset class=""starability-basic text-center"" style=""display:inline-block;width:auto;"">")
		For value As Integer = 1 To dr("RatingValue")
			Response.Write("<label></label>")
		Next
		Response.Write("</fieldset>")
	End If
	%>
	<p data-selectable="true"><%= dr.Item("quote") %></p>
	<div class="text-left" style="font-style:italic;font-size:12px;font-weight:bold;"><%= dr.item("firstname") %> <%= dr.item("lastname") %></div>
</div>
<%	
	rwGridCounter = rwGridCounter + 1
	Next
%>



</div>
</div>
</div>
</div>




