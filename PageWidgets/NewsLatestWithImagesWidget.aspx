<% @Import Namespace="System.Data" %>
<div class="row">
<%
	Dim data as DataTable =  NewsWidget.top(50) 
	For Each dr As DataRow In data.Rows
%>
	<div class="col-12 col-lg-4 mb-3">
		<div class="p-3 bg-white- h-100 shadow" style="border:3px solid rgba(255,255,255, 1);background:rgba(255,255,255,.7);">
		<!--div class="col-12" style="display:<%= iif(dr.Item("img").ToString().length > 0, "block", "none") %>">
		<a href="<%= Website.Link("News").Url()%>/<%= dr.Item("Id") %>/<%= ReplaceAlphanumericCharacters(dr.Item("Title")) %>">
		<img src='/NewsImg.ashx?id=<%= dr.Item("Id") %>&w=800' class='img-fluid mb-3 mt-3'/>
		</a>
		</div-->
		<div class="col-12">
		<h5 class="mb-0"><a href="<%= Website.Link("News").Url()%>/<%= dr.Item("Id") %>/<%= ReplaceAlphanumericCharacters(dr.Item("Title")) %>"><%= dr.Item("Title")  %></a></h5>
		<small><%= FormatDateTime(dr.Item("PubDate"), DateFormat.LongDate) %></small>
		<p><%= WordLimit(dr.Item("Description"), 20, "")  %></p>
		<a href="<%= Website.Link("News").Url()%>/<%= dr.Item("Id") %>/<%= ReplaceAlphanumericCharacters(dr.Item("Title")) %>">Read More <i class="fas fa-caret-right"></i></a>
		</div>
		</div>
	</div>
<%	
	Next
%>
</div>

