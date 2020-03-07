<% @Import Namespace="System.Data" %>
<div class="container" >
<h1 class="p-3 text-center">OUR WORK</h1>
<div class="row-">

<div class="d-lg-flex d-flex-column flex-wrap text-center">

<button class="fltr-controls btn btn-outline-primary mt-1 mt-lg-0" id="all" type="button">All</button>
<%
	Dim data as DataTable =  GalleryWidget.GetGalleriesForCategory(1) 
	For Each dr As DataRow In data.Rows
%>

			<button type="button" class="fltr-controls btn btn-outline-primary mt-1 mt-lg-0" id="<%= dr.item("id") %>"><%= dr.Item("Name") %></button>

<%	
	Next
%>

</div>
</div>
</div>
<div class="container-fluid">
<div class="d-flex-column- text-center js-grid my-shuffle shuffle row">
<%
	Dim images as DataTable =  GalleryWidget.GetImagesForCategory(4) 
	For Each dr As DataRow In images.Rows
%>
	<figure class="js-item column- shuffle-item shuffle-item--visible col-6 col-md-3" data-groups='["<%= dr.item("galleryid") %>"]'>
	<div class="aspect aspect--16x9">
        <div class="aspect__inner">
		<a href="/GetThumb.ashx?w=800&id=<%= dr.Item("id") %>" data-fancybox="group-<%= dr.item("galleryid") %>" data-type="image" style="cursor:pointer"><img src="/GetThumb.ashx?w=300&id=<%= dr.Item("id") %>" class="g wow bounceIn aspect aspect--16x9 aspect__inner p-3 gid-img gid-<%= dr.item("galleryid") %>" style="height: 100%;" obj.alt="obj.alt"></a>
	</div>
	</div>
	</figure>
	<%	
	Next
%>
</div>
</div>

<link href="/js/fancybox/jquery.fancybox.min.css" rel="stylesheet">
<script src="/js/fancybox/jquery.fancybox.min.js" type="text/javascript"></script>

<script src="/js/shuffle.min.js"></script>
<script>
var myShuffle;
$(function(){
var Shuffle = window.Shuffle;

myShuffle = new Shuffle(document.querySelector('.my-shuffle'), {
  itemSelector: '.js-item',
  sizer: '.my-sizer-element',
  buffer: 1,
});

$(".fltr-controls").on("click", function(){
	myShuffle.filter($(this).attr("id"));
})

});
</script>
<style>
.fltr-controls {
	cursor:pointer;
	font-size:1rem;
}
/* quick grid */
.container {
  width: 93%;
  margin: auto;
}

/* Bootstrap-style columns */
.column {
  position: relative;
  float: left;
  min-height: 1px;
  width: 25%;
  padding-left: 4px;
  padding-right: 4px;
  
  /* Space between tiles */
  margin-top: 8px;
}

.col-span {
  width: 50%;
}

.my-sizer-element {
  width: 8.33333%;
}

/* default styles so shuffle doesn't have to set them (it will if they're missing) */
.my-shuffle {
  position: relative;
  overflow: hidden;
}

/* Ensure images take up the same space when they load */
/* https://vestride.github.io/Shuffle/images */
.aspect {
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 100%;
  overflow: hidden;
}

.aspect__inner {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}

.aspect--16x9 {
  padding-bottom: 56.25%;
}

.aspect--9x80 {
  padding-bottom: calc(112.5% + 8px);
}

.aspect--32x9 {
  padding-bottom: calc(28.125% - 3px);
}

img.g {
  display: block;
  width: 100%;
  
  max-width: none;
  height: 100%;
  object-fit: cover;
}

/* Small reset */
*,
::before,
::after {
  box-sizing: border-box;
}

figure {
  margin: 0;
  padding: 0;
}
</style>

