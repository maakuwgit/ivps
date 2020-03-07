<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.2/dist/jquery.fancybox.min.css" />
<script src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.2/dist/jquery.fancybox.min.js"></script>
<style>
.fancybox-bg, .fancybox-show-caption, .fancybox-caption{-background:rgba(255, 255, 255, 0.75);}
.fancybox-caption{color:#fff;}
.fancybox-caption:before{background-image:none;}
.fb-caption-title{font-weight: bold;font-size:1rem;}
.fb-caption-description{margin-top:.75rem;}
</style>
<script>
$(function(){
	$('.lightbox img, .lightbox .lightbox-element').each( function() {
	    	var $img = $(this),
	    	href = $img.data('url'),
	    	caption = $img.data('caption'),
	    	caption_element_id = $img.data('caption-element-id')
	    	
	        	if( !href )
	        		href = $img.attr('src');
	        	if(!caption)
	        		caption = ""
	        	if(caption_element_id){
	        		var clone = $('#' + caption_element_id)
	        		caption = clone.html()
	        	}
	        		
	    	$img.wrap('<a href="' + href + '" class="fancybox-link" data-fancybox="images" data-caption=\'' + caption + '\'></a>');
	});
	$(".fancybox-link").fancybox({
		// Use this when enabled on slider
		backFocus: false
	});
});
</script>

