<script>
// Copyright 2014-2017 The Bootstrap Authors
// Copyright 2014-2017 Twitter, Inc.
// Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
  var msViewportStyle = document.createElement('style')
  msViewportStyle.appendChild(
	document.createTextNode(
	  '@-ms-viewport{width:auto!important}'
	)
  )
  document.head.appendChild(msViewportStyle)
}

$(document).ready(function () {
	// Set the correct header nav item to active
	var url = window.location.pathname;  
	$('.navbar-nav a[href="'+ url +'"]').addClass('active');
	$('.nav .nav-item a[href="'+ url +'"]').addClass('active');
});
</script>