<% @Import Namespace="System.Data" %>
<%

Dim dt As DataTable = PromoWidget.All()
If dt.Rows.Count > 0 Then 
%>

<%
For Each dr As DataRow In dt.Rows
	Dim HasImage = My.Computer.FileSystem.FileExists(MapPath("/images/promo/p" & dr.Item("Id") & dr.Item("ImgExt")))
	Dim HasPDF = My.Computer.FileSystem.FileExists(MapPath("/images/promo/" & dr.Item("Id") & ".pdf"))
	Dim HasContent = dr.Item("Desc").ToString().Trim().length > 0
%>
<div class="col-lg flex-fill p-3 text-center">
<% If HasImage Then %>
<div class="mb-1">
<a href="/images/promo/p<%= dr.Item("Id") %><%= dr.Item("ImgExt") %>">
<img src="/images/promo/p<%= dr.Item("Id") %><%= dr.Item("ImgExt") %>" class="img-fluid border" style="max-height:400px;"/>
</a>
</div>
<% End If %>

<% If HasContent Then %>
<div  class="pt-2"><%= nl2br(dr.Item("Desc")) %></div>
<% End If %>

<% If HasPDF Then %>
<div class="pt-2"><a href="/images/promo/<%= dr.Item("Id") %>.pdf">Download</a></div>
<% End If %>
<% If Not HasPDF AndAlso HasImage Then %>
<div class="pt-2"><a href="/images/promo/p<%= dr.Item("Id") %><%= dr.Item("ImgExt") %>">Click to Enlarge</a></div>
<% End If %>

<div class="text-secondary" style="font-size:.85rem;">Ends: <%= dr.Item("EndDT").ToShortDateString %></div>
</div>
<%
Next
%>

<%
End If

%>