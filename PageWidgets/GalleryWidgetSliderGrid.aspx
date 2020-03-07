<% @Import Namespace="System.Data" %>
<div id="MenuGalleryImageSlider" class="carousel slide" data-ride="carousel" data-interval="5000" data-pause="hover">
<!-- Wrapper for slides -->
<div class="carousel-inner" role="listbox">
<div class="carousel-item active">
<div class="row">
<%
	Dim images as DataTable =  GalleryWidget.GetImagesForCategory(1) 
	Dim numofimages = images.Rows.Count 
	Dim gridCounter = 1
	Dim gridCount = 6
	For Each dr As DataRow In images.Rows
	
%>
	<% 
		If gridCounter > gridCount Then
			gridCounter = 1
	%>
		</div>
		</div>
		<div class="carousel-item">
		<div class="row">
	<%
		Else
	%>
	
	<%
		End If
	%>
        <div class="col-lg-2 my-3 menu-item m-auto" style="min-height:165px;">
		<a href="/GetThumb.ashx?w=800&id=<%= dr.Item("id") %>" data-caption="<%= dr.Item("name") %>: <%= dr.Item("description") %>" data-fancybox="group-<%= dr.item("galleryid") %>" data-type="image" style="cursor:pointer;position:relative;min-height:165px;border:5px solid #fff;background: rgba(255,255,255,.85);" class="menu-gallery-fancybox d-flex shadow-sm">
		<img title="<%= dr("name") %>" alt="<%= dr("name") %>" src="/GetThumb.ashx?h=150&id=<%= dr.Item("id") %>" class="img-fluid  m-auto p-3">
		<div class="overlay">
    			<div class="text"><%= dr.Item("name") %></div>
  		</div>
		</a>
	</div>
<%	
	gridCounter = gridCounter + 1
	Next
%>
<%
if numofimages Mod gridCount < 0 Then
Dim remainder = ( gridCount Mod (numofimages Mod gridCount))
If remainder > 0 Then
For counter = 1 To remainder
%>
 <!--div class="col-lg-4 my-3 menu-item">
 <img src="/images/gallery-img-placeholder.png" style="border:5px solid transparent;" class="img-fluid">
 </div-->
<%
Next
End If
End If
%>
</div>
</div>
</div>
<!--a class="carousel-control-prev" href="#MenuGalleryImageSlider" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span></a> <a class="carousel-control-next" href="#MenuGalleryImageSlider" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span></a--> 
</div>

<link href="/js/fancybox/jquery.fancybox.min.css" rel="stylesheet">
<script src="/js/fancybox/jquery.fancybox.min.js" type="text/javascript"></script>

<script>
$(".menu-gallery-fancybox").fancybox({
    afterClose: function() {
        console.info( 'FancyBox Closed');        
        $('#MenuGalleryImageSlider').carousel("cycle")
    },
    beforeShow: function(){
    	console.info( 'FancyBox Opened');        
    	$('#MenuGalleryImageSlider').carousel("pause")
    }
});
</script>

<style>


.menu-item .overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: rgba(0,0,0,.5);
  word-break: break-all;
}

.menu-item:hover .overlay {
  opacity: 1;
}

.menu-item .text {
	width:95%;
  color: white;
  font-size: 16px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
}
</style>
