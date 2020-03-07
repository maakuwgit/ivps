<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="/Videos.aspx.vb" Inherits="Videos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    
    
	<!-- #Include file="\PageWidgets\AlternatePageHeader.aspx" -->	

    <div class="d-flex flex-column d-lg-block">
    <!-- Scroller -->
    <div class="d-flex w-100 bg-lg-black flex-column flex-lg-row order-lg-1 order-2">
    <div class="flex-shrink-1 bg-lg-black text-white d-lg-flex align-items-center justify-content-center d-none" onclick="scrollVideos(-18)" style="cursor:pointer;">
    <svg class="icon" style="pointer-events: none;width:40px;height:40px;"><use href="#icon__chevron--left"></use></svg>
    </div>
    <div class=" flex-grow-1 row flex-lg-nowrap py-1" style="overflow-x:auto;scroll-behavior: smooth;scrollbar-width: none" id="videoScroller">
    	<%
    		Dim FirstVideoUrl = Nothing
    		Dim FirstVideoName = Nothing
    		Dim FirstVideoDescription = Nothing
    		For Each Video In Videos.Rows
    			Dim vidUrl = Video("Code")
    			Dim Parts = vidUrl.Trim().Split("/")
    			Dim vidId = Parts(Parts.length-1)
          	vidUrl = "https://www.youtube.com/embed/" & vidId
          	If FirstVideoUrl Is Nothing Then
          		FirstVideoUrl = vidUrl
          	End If
          	If FirstVideoName Is Nothing Then
          		FirstVideoName = Video("Name")
          	End If
          	If FirstVideoDescription Is Nothing Then
          		FirstVideoDescription = Video("Description")
          	End If
    	%>
    		<div class="col-lg-2 d-lg-block d-flex p-lg-0 my-2 my-lg-0">
    		<div class="position-relative col-6 col-lg-auto" onclick="loadVideoInContainer(this)">
    			<div class="position-relative">
    				<img src="https://img.youtube.com/vi/<%= vidId %>/0.jpg" class="img-fluid w-100"  title="<%= Video("Name") %>" data-video-url="<%= vidUrl %>" data-video-title="<%= Video("Name") %>" data-video-description="<%= Video("Description") %>">
    			    	<div class="position-absolute  text-danger" style="cursor:pointer;top: 50%;left: 50%;transform: translate(-50%, -50%);cursor:pointer;z-index:100;pointer-events:none;">
    					<svg class="icon video hover" style="pointer-events: none;height:50px;width:50px"><use href="#icon__playback--solid"></use></svg>
    				</div>
    			</div>
    			<div class="position-absolute d-none video-overlay text-danger d-lg-flex align-items-center justify-content-center" onmouseover="videoThumbnailHover(this)" onmouseout="videoThumbnailHover(this)" onclick="videoThumbnailClick(this)" style="top:0;right:0;left:0;bottom:0;cursor:pointer;">
    			</div>
    		</div>
    		<div class="col-6 d-lg-none pl-0">
			<div class="h5 font-weight-bold"><%= Video("Name") %></div>
			<%= WordLimitContainer(Video("Description"), 5, vidId) %>
		</div>
    		</div>
    		<hr class="col-6 d-lg-none"> 
 	<%
    		Next
    	%>
    	</div>
    	<div class="flex-shrink-1 bg-black text-white d-lg-flex align-items-center justify-content-center d-none" onclick="scrollVideos(18)" style="cursor:pointer;">
    	<svg class="icon" style="pointer-events: none;width:40px;height:40px;"><use href="#icon__chevron--right"></use></svg>
    	</div>
    </div>
    
    <!-- Player -->
	<div class="col-auto my-3 order-lg-2 order-1">
		<div class="embed-responsive embed-responsive-16by9 border border-dark"><iframe  src="<%= FirstVideoUrl %>?rel=0" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen id="mainVideoFrame"></iframe></div>
		<div>
			<h4 id="videoName" class="mt-3"><%= FirstVideoName %></h4>
			<p id="videoDescription"><%= FirstVideoDescription %></p>
		</div>
	</div>
	</div>
	<script>
		function scrollVideos(percent){
			let videoScroller = document.querySelector('#videoScroller')
			let distance = (percent/100) * videoScroller.scrollWidth
			videoScroller.scrollLeft += distance
		}
		function loadVideoInContainer(elem){
			loadVideo(elem.querySelector('img'))
		}
		function loadVideo(elem){
			let mainVideoFrame = document.querySelector('#mainVideoFrame')
			mainVideoFrame.src = elem.dataset.videoUrl + '?rel=0&autoplay=1'
			let VideoNameElement = document.querySelector('#videoName')
			let VideoDescriptionElement = document.querySelector('#videoDescription')
			VideoNameElement.innerHTML = elem.dataset.videoTitle
			VideoDescriptionElement.innerHTML = elem.dataset.videoDescription
			mainVideoFrame.scrollIntoView();
		}
		function videoThumbnailHover(element){
			if(!element.classList.contains('active')){
				element.classList.toggle('hover')
				if(element.classList.contains('hover')){
					element.style.background = 'rgba(0,0,0,.5)'
				}
				else {
					element.style.background = 'none'
				}
			}
		}
		function videoThumbnailClick(elem){
			let VideoOverlayElement = document.querySelectorAll('.video-overlay')
			for(var i = 0; i < VideoOverlayElement.length; i++){
				VideoOverlayElement[i].style.background = 'none'
				VideoOverlayElement[i].classList.remove('active', 'hover')
			}
			elem.style.background = 'rgba(104,23,134,.5)'
			elem.classList.add('active')
		}
	</script>

</asp:Content>

