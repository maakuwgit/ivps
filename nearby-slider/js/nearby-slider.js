(function ( $ ) {
   $.fn.nearbySlider = function() {
     
     
    
   
    var slideCount
	var slideWidth
	var slideHeight
	var sliderUlWidth
	var proportion= false;
	var autoPlay = true;
	var autoPlayTimerId = false;
	var autoPlayDelay = 3000
	var animationLength = 500
	var inactiveSlideOpacity = .5
	var sliding = false

	$('#slider ul li:nth-child(1)').addClass('active')
    	
    	$('#slider ul li:last-child').prependTo('#slider ul');
	
	$( window ).resize(function() {
	  init()
	});
	
	init()
	
	function init(){
		console.log($.find('ul li')[0])
		slideCount = $.find('ul li').length;
		slideWidth = $('#slider ul li').width();
		
	
		slideHeight = "100%";//$('#slider ul li').height();
		sliderUlWidth = slideCount * slideWidth;
		
		if(!proportion) {
			// Define the initial proportion. Use this when window resizes.
			// This should help with responsive images.
			proportion = slideWidth / slideHeight
		} else {
			slideHeight = slideWidth / proportion
			$('#slider ul li').css({height: slideHeight})
		}
	
		$('#slider').css({ width: slideWidth, height: slideHeight });
	
		$('#slider ul').css({ width: sliderUlWidth, marginLeft: - slideWidth, height: slideHeight });
		
		$('.control_next, .control_prev').css({'line-height': slideHeight + 'px'});
		
		$("#slider ul li").on( "swipeleft", function( event ) {
				  			if(!sliding)
				  				moveRight()	
				  		 } )
				  		 
		$("#slider ul li").on( "swiperight", function( event ) {
				  			if(!sliding)
				  				moveLeft()	
				  		 } )
				  		 
		$("#slider ul li").on( "mouseenter", function( event ) {
				  				stopAutoPlay()
				  		 } )
				  		 
		$("#slider ul li").on( "mouseleave", function( event ) {
				  				startAutoPlay()
				  		 } )
		
		if(autoPlay)
			startAutoPlay()
	}
	
	$('#checkbox').change(function(){
		toggleAutoPlay()
	});
  
	
	function toggleAutoPlay(){
		if(autoPlayTimerId){
			stopAutoPlay()
		}
		else{
			startAutoPlay()
		}
	}
	
	function startAutoPlay(){
		stopAutoPlay()
		autoPlayTimerId = setInterval(function () {
			moveRight();
		}, autoPlayDelay);
	}
	
	function stopAutoPlay(){
		clearInterval(autoPlayTimerId)
		autoPlayTimerId = false;
	}
  

    function moveLeft() {
    	sliding = true
    	//console.log("move-left")
        $('#slider ul').animate({
            left: + slideWidth
        }, animationLength, function () {
        
        	$('#slider ul li:last-child').css({opacity: 0})
        	$('#slider ul li:last-child').animate({
				opacity: inactiveSlideOpacity
			}, animationLength, function () {})
            $('#slider ul li:last-child').prependTo('#slider ul');
            $('#slider ul').css('left', '');
           // $('#slider ul li:nth-child(1)').removeClass('active').css({opacity: .5})
            $('#slider ul li:nth-child(3)').removeClass('active').animate({
				opacity: inactiveSlideOpacity
			}, animationLength, function () {})
            $('#slider ul li:nth-child(2)').addClass('active').css({opacity: 1})
            sliding = false
        });
    };

    function moveRight() {
    	sliding = true
    	//console.log("move-right")
    	if(slideCount > 3)
    		$('#slider ul li:last-child').css({opacity: 0});
    		
        $('#slider ul').animate({
            left: - slideWidth
        }, animationLength, function () {
			
			if(slideCount > 3) {
				$('#slider ul li:last-child').animate({
					opacity: inactiveSlideOpacity
				}, animationLength, function () {})
            	$('#slider ul li:first-child').appendTo('#slider ul');
            } else {
            	$('#slider ul li:first-child').appendTo('#slider ul');
            	$('#slider ul li:last-child').css({opacity: 0});
            	$('#slider ul li:last-child').animate({
					opacity: inactiveSlideOpacity
				}, animationLength, function () {})
            }
			
			$('#slider ul li:nth-child(1)').removeClass('active').animate({
				opacity: inactiveSlideOpacity
			}, animationLength, function () {})
				
            $('#slider ul li:nth-child(2)').addClass('active').css({opacity: 1})
            $('#slider ul').css('left', '');
            sliding = false
        });
    };

$('a.control_prev').on('click', function () {
	stopAutoPlay()
	moveLeft()	
	startAutoPlay()
    });
    
    $('a.control_next').on('click', function () {
        stopAutoPlay()
        moveRight()	
        startAutoPlay()
    });
     
     
     }
     
     
     
      return this;
 

}( jQuery ));
