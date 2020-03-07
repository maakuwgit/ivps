var POP = (function(args){

	var args = {}
	
	var storageIdSuffix = "-display"
	
	function getDefaultArgs(){
		return {
			/*
				name
					
				The unique name used to identify the pop up
				
				REQUIRED
			*/	
			name: "",
			/*
				contentUrl
					
				The location of the file used to load via an XMLHttpRequest. This
				file's content will be displayed inside the pop up.
			*/	
			contentUrl: "",
			/*
				content
					
				Displayed inside the pop up. Can be html.
			*/	
			content: "",
			displayEventOptions: {
				/*
					event
					
					When the pop up will display
					Options: load, scroll
				*/	
				event: "load",
				/*
					scrollDistance
					
					If the event is scroll then this sets the distance of the scroll
					that will trigger the pop up show event
				*/	
				scrollDistance: "0",
				/*
					delay
					
					The time after the event fires until the pop up display.
				*/	
				delay: 500,
			},
			displayOptions: {
				/*
					showEffect
					
					The annimation used to show the pop up
				*/	
				showEffect: "fadeIn",
				/*
					hideEffect
					
					The animation used to hide the pop up
				*/
				hideEffect: "fadeOut",
				/*
					closeBtn
					
					Displays the upper right hand close button if true
				*/
				closeBtn: true,
				/*
					overlay
					
					If true the overlay will display. 
				*/
				overlay: true,
				/*
					overlayClickable
					
					If true when the overlay is clicked it will close the pop up. If
					false the overlay will not show and overlayClickable will be false.
				*/
				overlayClickable: true,
				/*
					overlayPointerEvents
					
					True: Prevents elements under overlay from receiving mouse events.
					False: Allows elements under overlay to receive mouse events.
				*/
				overlayPointerEvents: true,
				/*
					start
					
					The date this pop will show. The default is to always show
				*/
				start: "",
				/*
					end
					
					The date this pop will stop showing. The default is to never stop
				*/
				end: "",
				/*
					overlayBackground
					
					Color of the overlay
				*/
				overlayBackground: "rgba(0,0,0,0.75)",
				/*
					closeBtnBackground
					
					Color of the upper right close button 
				*/
				closeBtnBackground: "rgba(0,0,0,0.8)",
				/*
					closeBtnHoverBackground
					
					Color of the upper right close button when mouse hovers over it
				*/
				closeBtnHoverBackground: "rgba(0,0,0,1)",
				/*
					popupBackground
					
					The color of the content container
				*/
				popupBackground: "#fff",
				/*
					popupDropShadow
					
					Color of the box-shadow
				*/
				popupBoxShadow: "0px 2px 6px rgba(0,0,0,.5)",
				/*
					position
					
					The position the pop up will appear in the browser. The default is center.
					Options: bottom-right, bottom-left, top-right, top-left
				*/
				
				position: "",
				/*
					neverShowAgain
					
					True: Adds a clickable element to the bottom of the popup
					False: 
				*/
				neverShowAgain: true,
				/*
					neverShowAgainLabel
					
					The text for the neverShowAgain element 
				*/
				neverShowAgainLabel: "Never show again"
			},
			session: {
				/*
					displayOnce
					
					If true the pop up will only display once per browser session.
				*/
				displayOnce: true,
			},
			location: {
				/*
					urls
					
					An array of urls or files that the pop up will display. If
					the array is empty the pop up will display on all pages
				*/
				urls: [],
				urlsToExclude: []
			},
			/*
					reset
					
					This removes all the display flags from the session and local storage.
					Which will result in the pop up showing again. This is mainly used for testing.
				*/
			reset: false,
		};
	}
	
	return {
		load: function(_args){
			
			// Set default values
			args = getDefaultArgs()
		
			// Set user defined values
			Object.assign(args.displayEventOptions, _args.displayEventOptions);
			delete _args.displayEventOptions
			
			Object.assign(args.displayOptions, _args.displayOptions);
			delete _args.displayOptions
			
			Object.assign(args.session, _args.session);
			delete _args.session	
			
			Object.assign(args.location, _args.location);
			delete _args.location	
			
			Object.assign(args, _args);
			
			reset()
			
			if(doNotShowAgain())return;
		
			// Check if the popup has not expired and is ready for action
			var now = new Date();
			var startingDate = Date.parse(args.displayOptions.start);
			var endingDate = Date.parse(args.displayOptions.end);
			
			// Don't load the popup unless it active.
			if(startingDate >= now.getTime()) {
				console.log("Popup has not started");
				return;
			}
			
			if(endingDate <= now.getTime()){
				console.log("Popup has expired");
				return;
			}
			
			if(args.displayOptions.overlay == false){
				args.displayOptions.overlayClickable = false;
			}
			
			if (document.readyState === "complete"){
				init();
			}
			else {
				window.onload = function() {
					init();
				}
			}
		},
		show: function(delay) {
			window.setTimeout(function(){show()}, parseInt(delay))
		},
		hide: function(delay) {
			window.setTimeout(function(){hide()}, parseInt(delay))
		},
		content: function(string) {
			var popupInner = document.querySelector('[data-popup="'+args.name+'"] .popup-inner .content');
			popupInner.innerHTML = string
		}
	}
	
	function init(){
		removePopupContainer();
		addPopupContainerStyles()
		addPopupContainer()
		loadPopupContent()
		addEventListners()
		if(args.displayEventOptions.event == "load"){
			if(parseInt(args.displayEventOptions.delay) > 0 ){
				window.setTimeout(function(){show()}, parseInt(args.displayEventOptions.delay))
			}
			else {
				show()
			}
		}
		if(args.displayEventOptions.event == "scroll"){
			var body = document.body,
				html = document.documentElement;
			var height = Math.min( body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight );
			var currentOffset
			window.addEventListener("scroll", function(e){
				var offset = getScrollOffsets();
				// Check if scroll direction in moving downward.
				if(currentOffset && currentOffset.y < offset.y){
					if(args.displayEventOptions.scrollDistance.indexOf('%') > -1){
					console.log(height, offset.y + window.innerHeight)
						if((offset.y + window.innerHeight) > ((parseInt(args.displayEventOptions.scrollDistance)*.01)*height)){
							window.setTimeout(function(){show()}, parseInt(args.displayEventOptions.delay))
						}
					}
					else if(offset.y > parseInt(args.displayEventOptions.scrollDistance)){
						window.setTimeout(function(){show()}, parseInt(args.displayEventOptions.delay))
					}
				}
				currentOffset = offset
			});
		}
	}
	
	function show(){
		display(document.querySelector(`[data-popup='`+args.name+`']`), "show")
	}
	
	function hide(){
		display(document.querySelector(`[data-popup='`+args.name+`']`), "hide")
	}
	
	function display(popup, state){
		if(popup){
			if(state === "show"){
				if(doNotShowAgain(popup) || !locationAllowed() || locationExculded())return;
				if(popup.getAttribute("data-session-display-once") == "true"){
					sessionStorage.setItem(popup.getAttribute("data-popup") + storageIdSuffix, "false")
				}
				popup.classList.remove("closed")
				popup.classList.add("opened")
				if(popup.getAttribute("data-display-overlay") != "false")
					document.querySelector("body").classList.add("noscroll")
				popup.classList.remove(popup.getAttribute("data-display-hide"))
				popup.classList.add(popup.getAttribute("data-display-show"))
			}
			else{
				popup.classList.remove("opened")
				popup.classList.add("closed")
				document.querySelector("body").classList.remove("noscroll")
				popup.classList.remove(popup.getAttribute("data-display-show"))
				popup.classList.add(popup.getAttribute("data-display-hide"))
			}
		}
		else {
			console.log("Missing popup element. Most likely 'Never show again' is active.")
		}
		reset()
	}
	
	function locationAllowed(){
		if(args.location.urls.length == 0) return true;
		
		var currentLocation = (window.location.href.split('#')[0]).split('?')[0]

		for (var i = 0; i < args.location.urls.length; i++) {
			if(args.location.urls[i] == currentLocation || currentLocation.endsWith(args.location.urls[i]) || currentLocation.endsWith(args.location.urls[i] + '/')) return true;
		}
		return false;
	}
	
	function locationExculded(){
		if(args.location.urlsToExclude.length == 0) return false;
		
		var currentLocation = (window.location.href.split('#')[0]).split('?')[0]

		for (var i = 0; i < args.location.urlsToExclude.length; i++) {
			if(args.location.urlsToExclude[i] == currentLocation || currentLocation.endsWith(args.location.urlsToExclude[i])  || currentLocation.endsWith(args.location.urlsToExclude[i] + '/')) return true;
		}
		return false;
	}
	
	function reset(){
		// Remove session values
		if(args.reset){
			sessionStorage.removeItem(args.name + storageIdSuffix)
		}
		
		// Remove persistent session values
		if(args.reset){
			localStorage.removeItem(args.name + storageIdSuffix)
		}
	}
	
	function doNotShowAgain(popup){
		if(!popup){
			if(args.session.displayOnce && sessionStorage.getItem(args.name + storageIdSuffix) == "false"){
				console.log("Never show again, for this session, is active. Set 'reset:true' to deactivate. [popup: "+args.name+"]");
				return true;
			}
			else if(localStorage.getItem(args.name + storageIdSuffix) == "false"){
				console.log("Never show again is active. Set 'reset:true' to deactivate. [popup: "+args.name+"]");
				return true;
			}
		}
		else {
			if(popup.getAttribute("data-session-display-once") == "true" && sessionStorage.getItem(popup.getAttribute("data-popup") + storageIdSuffix) == "false"){
				console.log("Never show again, for this session, is active. Set 'reset:true' to deactivate. [popup: "+popup.getAttribute("data-popup")+"]");
				return true;
			}
			else if(localStorage.getItem(popup.getAttribute("data-popup") + storageIdSuffix) == "false"){
				console.log("Never show again is active. Set 'reset:true' to deactivate. [popup: "+popup.getAttribute("data-popup")+"]");
				return true;
			}
		}
		return false;
	}
	
	function addEventListners(){
		removeEventListeners()
		// Any object with the property data-popup-open
		var openElems = document.querySelectorAll('[data-popup-open]');
		for (var i = 0; i < openElems.length; i++) {
			openElems[i].addEventListener('click', showEventListener, false);
		}
		var openElems = document.querySelectorAll('[data-popup-toggle]');
		for (var i = 0; i < openElems.length; i++) {
			openElems[i].addEventListener('click', toggleEventListener, false);
		}
		// Any object with the property data-popup-close
		var closeElems = document.querySelectorAll('[data-popup-close]');
		for (var i = 0; i < closeElems.length; i++) {
			closeElems[i].addEventListener('click', hideEventListener, false);
		}
		var closeElems = document.querySelectorAll('[data-popup-never-show-again]');
		for (var i = 0; i < closeElems.length; i++) {
			closeElems[i].addEventListener('click', neverShowAgainListener, false);
		}
		// The overlay element
		if(args.displayOptions.overlayClickable) {
			var overlayElems = document.querySelectorAll('[data-popup="'+args.name+'"]');
			for (var i = 0; i < overlayElems.length; i++) {
				overlayElems[i].addEventListener('click', overlayEventListener, false);
			}
		}
    }
    
    function removeEventListeners(){
    	var openElems = document.querySelectorAll('[data-popup-open]');
		for (var i = 0; i < openElems.length; i++) {
			openElems[i].removeEventListener('click', showEventListener, false);
		}
		var openElems = document.querySelectorAll('[data-popup-toggle]');
		for (var i = 0; i < openElems.length; i++) {
			openElems[i].removeEventListener('click', toggleEventListener, false);
		}
		// Any object with the property data-popup-close
		var closeElems = document.querySelectorAll('[data-popup-close]');
		for (var i = 0; i < closeElems.length; i++) {
			closeElems[i].removeEventListener('click', hideEventListener, false);
		}
		// Any object with the property data-popup-close
		var closeElems = document.querySelectorAll('[data-popup-never-show-again]');
		for (var i = 0; i < closeElems.length; i++) {
			closeElems[i].removeEventListener('click', neverShowAgainListener, false);
		}
		// The overlay elemnt
		if(args.displayOptions.overlayClickable) {
			var overlayElems = document.querySelectorAll('[data-popup="'+args.name+'"]');
			for (var i = 0; i < overlayElems.length; i++) {
				overlayElems[i].removeEventListener('click', overlayEventListener, false);
			}
		}
    }
    
    function showEventListener(e){
    	var targeted_popup = e.target.getAttribute("data-popup-open")
		display(document.querySelector(`[data-popup='`+targeted_popup+`']`), "show")
		e.preventDefault();
    }
    
    function toggleEventListener(e){
    	var targeted_popup = e.target.getAttribute("data-popup-toggle")
    	var popup = document.querySelector(`[data-popup='`+targeted_popup+`']`);
    	
    	if(popup.classList.contains("opened")){
    		display(popup, "hide")
    	}
    	else {
    		display(popup, "show")
    	}
    }
    
    function hideEventListener(e){
    	var targeted_popup = e.target.getAttribute("data-popup-close")
		display(document.querySelector(`[data-popup='`+targeted_popup+`']`), "hide")
		e.preventDefault();
    }
    
    function neverShowAgainListener(e){
    	var targeted_popup = e.target.getAttribute("data-popup-never-show-again");
    	if(targeted_popup){
    		localStorage.setItem(targeted_popup + storageIdSuffix, false);
    		display(document.querySelector(`[data-popup='`+targeted_popup+`']`), "hide")
    	}
    }
    
    function overlayEventListener(e){
		if(e.target.classList.contains('popup'))
			display(e.target, "hide")
		if(e.target.classList.contains('popup-inner'))
			display(e.target.parentNode, "hide")
    }
	
	function loadPopupContent(){
		if(args.contentUrl){
			httpRequest = new XMLHttpRequest();
			httpRequest.onreadystatechange = function(){
				// Process the server response here.
				if (httpRequest.readyState === XMLHttpRequest.DONE) {
				  if (httpRequest.status === 200) {
					var popupInner = document.querySelector('[data-popup="'+args.name+'"] .popup-inner .content');
					popupInner.innerHTML = httpRequest.responseText + popupInner.innerHTML
					addEventListners()
				  } else {
					//alert('There was a problem with the request.');
				  }
				}
			};
			httpRequest.open('GET', args.contentUrl, true);
			httpRequest.send();
		}
		if(args.content.length > 0){
			var popupInner = document.querySelector('[data-popup="'+args.name+'"] .popup-inner .content');
			popupInner.innerHTML += args.content
		}
	}
	
	function removePopupContainer(){
		var popup = document.querySelector('[data-popup="'+args.name+'"]');
		if(popup)
			popup.parentNode.removeChild(popup)
	}
	
	function addPopupContainer(){
		var elem = document.createElement('div');
		elem.className = "popup " + args.name + " " + args.displayOptions.position + " " + (args.displayOptions.overlay == false ? "hidden" : "");
		elem.setAttribute("data-popup",args.name)
		elem.setAttribute("data-display-show",args.displayOptions.showEffect)
		elem.setAttribute("data-display-hide",args.displayOptions.hideEffect)
		elem.setAttribute("data-display-overlay",args.displayOptions.overlay)
		elem.setAttribute("data-event-scroll-distance",args.displayEventOptions.scrollDistance)
		elem.setAttribute("data-event-delay",args.displayEventOptions.delay)
		elem.setAttribute("data-session-display-once",args.session.displayOnce)
		var popupInnerString = `
    		<div class="popup-inner" id="`+ args.name +`">
    			<div class="content">
    			</div>
    			<a class="popup-close" data-popup-close="`+ args.name +`" href="#">x</a>
    		
		`;
		if(args.displayOptions.neverShowAgain){
			popupInnerString += "<div class='never-show-again' data-popup-never-show-again='"+ args.name +"'>" + args.displayOptions.neverShowAgainLabel + "</div>"
		}
		popupInnerString += `</div>`
		elem.innerHTML = popupInnerString
		document.body.appendChild(elem);
	}
	
	function getScrollOffsets() {
		var doc = document, w = window;
		var x, y, docEl;
	
		if ( typeof w.pageYOffset === 'number' ) {
			x = w.pageXOffset;
			y = w.pageYOffset;
		} else {
			docEl = (doc.compatMode && doc.compatMode === 'CSS1Compat')?
					doc.documentElement: doc.body;
			x = docEl.scrollLeft;
			y = docEl.scrollTop;
		}
		return {x:x, y:y};
	}
	
	function addPopupContainerStyles(){
	
		
		if( document.querySelector("[data-style-for-popup="+args.name+"]") )return;
		
		var css = document.createElement("style");
		css.type = "text/css";
		css.setAttribute("data-style-for-popup", args.name);
		css.innerHTML =`
			/* Outer */
			.popup.`+args.name+` {
				visibility:hidden;
				position:fixed;
				top:0px;
				left:0px;
				right:0px;
				bottom:0px;
				background:` + args.displayOptions.overlayBackground + ` ;
				z-index: 1001;
  				display: flex;
  				align-items: center;
  				justify-content: center;
				height:100vh;
				width:100vw;
			}
			.popup.`+args.name+` .never-show-again {
				cursor:pointer;
				color:#aaa;
				text-align:left;
				font-family: sans-serif;
				padding:5px;
				margin-left:20px;
				font-size:12px;
				text-decoration:underline;
			}
			.popup.`+args.name+`.hidden {
				background:transparent;
				pointer-events:` + (args.displayOptions.overlayPointerEvents ? 'auto' : 'none') + `;
			}
			.popup.`+args.name+`.bottom-right {
				align-items: flex-end;
  				justify-content: flex-end;
			}
			.popup.`+args.name+`.bottom-left {
				align-items: flex-end;
  				justify-content: flex-start;
			}
			.popup.`+args.name+`.top-right {
				align-items: flex-start;
  				justify-content: flex-end;
			}
			.popup.`+args.name+`.top-left {
				align-items: flex-start;
  				justify-content: flex-start;
			}
			.popup.`+args.name+`.bottom-right .popup-inner .content,
			.popup.`+args.name+`.bottom-left .popup-inner .content,
			.popup.`+args.name+`.top-right .popup-inner .content,
			.popup.`+args.name+`.top-left .popup-inner .content{
				margin:0;
			}
			/* Inner */
			.`+args.name+` .popup-inner {
				position: relative;
				pointer-events: all;
			}
			.`+args.name+` .popup-inner .content {
				overflow:scroll;
				background:` + args.displayOptions.popupBackground + ` ;
				position: relative;
  				box-shadow: ` + args.displayOptions.popupBoxShadow + `;
  				margin:25px;
  				max-height:80vh;
			}
 			/* Close Button */
			.`+args.name+`.opened .popup-close {
				transition:ease 0.25s all;
			}
 			.`+args.name+`.opened .popup-close:hover {
    			transform:translate(50%, -50%) rotate(180deg);
    			background:` +  args.displayOptions.closeBtnHoverBackground + `;
    			text-decoration:none;
			}
			.`+args.name+` .popup-close {
				-width:30px;
				-height:30px;
				padding:5px 10px 7px 10px;
				display:inline-block;
				position:absolute;
				top:25px;
				transform:translate(50%, -50%);
				right:25px;
				border-radius:0;
				background:` +  args.displayOptions.closeBtnBackground + `;
				font-family:Arial, Sans-Serif;
				font-size:20px;
				text-align:center;
				color:#fff;
				text-decoration:none;
			}
			.noscroll { 
			  position: fixed; overflow-y:scroll
			}
			@keyframes fadeIn {
				from {
					opacity: 0;
					visibility: hidden;
				}
				to {
					opacity: 1;
					visibility: visible;
				}
			}
			@keyframes fadeOut {
				from{
					opacity: 1;
					visibility: visible;
				}
				to {
					opacity: 0;
					visibility: hidden;
				}
			}
			.fadeIn{
  				animation: fadeIn .5s ease-in 1 forwards;
			}
			.fadeOut{
  				animation: fadeOut .5s ease-in 1 forwards;
  				
			}
			@keyframes slideLeft {
				from {
					opacity: 1;
					visibility: hidden;
					left:-100vw;
				}
				to {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
			}
			@keyframes slideLeftOut {
				from {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
				75%{
					opacity:0;
				}
				to {
					opacity: 0;
					visibility: hidden;
					left:-100vw;
				}
			}
			@keyframes slideRight {
				from {
					opacity: 1;
					visibility: hidden;
					left:100vw;
				}
				to {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
			}
			@keyframes slideRightOut {
				from {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
				75%{
					opacity:0;
				}
				to {
					opacity: 0;
					visibility: hidden;
					left:100vw;
				}
			}
			@keyframes slideUp {
				from {
					opacity: 0;
					visibility: hidden;
					top:100vh;
				}
				to {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
			}
			@keyframes slideUpOut {
				from {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
				75%{
					opacity:0;
				}
				to {
					opacity: 0;
					visibility: hidden;
					top:-100vh;
				}
			}
			@keyframes slideDown {
				from {
					opacity: 1;
					visibility: hidden;
					top:-100vh;
				}
				to {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
			}
			@keyframes slideDownOut {
				from {
					opacity: 1;
					visibility: visible;
					left:inital;
				}
				75%{
					opacity:0;
				}
				to {
					opacity: 0;
					visibility: hidden;
					top:100vh;
				}
			}
			.slideLeftIn {
				animation: slideLeft 0.35s ease-in 1 forwards;
			}
			.slideLeftOut {
				animation: slideLeftOut 0.35s ease-out 1 backwards;
			}
			.slideRightIn {
				animation: slideRight 0.35s ease-in 1 forwards;
			}
			.slideRightOut {
				animation: slideRightOut 0.35s ease-out 1 backwards;
			}
			.slideUpIn {
				animation: slideUp 0.35s ease-in 1 forwards;
			}
			.slideUpOut {
				animation: slideUpOut 0.35s ease-out 1 backwards;
			}
			.slideDownIn {
				animation: slideDown 0.35s ease-in 1 forwards;
			}
			.slideDownOut {
				animation: slideDownOut 0.35s ease-out 1 backwards;
			}
		`;
		document.head.appendChild(css);
	}
	
}());