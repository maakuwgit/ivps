$(document).ready(function () {
    var url = window.location.pathname,
        carousel = $('[data-carousel]');

  //Dev Note: going to move this into the Backgrounder component for reusability
  //BEOF Backgrounder
  var vh,vw;
  //Media Query (match the _variables.scss breakpoints)
  var breakpoints = {};
  breakpoints.xxs = 399;
  breakpoints.xs  = 479;
  breakpoints.sm  = 767;
  breakpoints.md  = 991;
  breakpoints.lg  = 1199;
  breakpoints.xl  = 1599;

  //Padding *Dev Note* Should match the _variables.scss padding
  var padding_xsmall        = 18.5,
      padding_small         = 37,
      padding_medium        = 61,
      padding_large         = 106,
      padding_xlarge        = padding_small + padding_large;

  var prefooter     = '.ll-prefooter',
      primary_nav   = 'body > header.navbar',
      hero          = 'main > :first-child.hdg',
      sections      = $('main [data-component]');

  function rem_calc(num) {
    return num/16;
  }

  /**
   * IF your navbar is fixed
   * use this function
   */
  function checkAdminBar() {
    // if ( window.userLoggedIn ) {
    //   $('header.navbar').css('top', window.adminBarHeight);
    // }
  }

  // JavaScript to be fired on all pages
  //Basic Collapse toggle for dropdowns and toggle menus
  $('[data-toggle="collapse"]').on('click', function(e) {
    e.preventDefault();
    //if target element is not open already
    //find all open collapse elements and close them
    if ( !$(this).is('.collapsed') ) {
      if ( $('.collapsed[data-toggle="collapse"]').length > 0 ) {
        $('.collapsed[data-toggle="collapse"]').each(function(){
          $(this).trigger('click');
        });
      }
    }
    var target = $(this).data('target');
    $(this).toggleClass('collapsed');
    $(target).toggleClass('collapsed');
    if( $('header.navbar').hasClass('top') ) {
      $('header').removeClass('top');
    }else{
      $('header').addClass('top');
    }
  });

  /*
   * Collapse specificially for the nav. Utilizes .slideToggle()
   * for sliding animation for a more "out of the box" nice looking
   * mobile animation. Can easily be removed or altered for
   * more specific funcitonality.
   */
  $('[data-nav="collapse"]').on('click', function(e) {
    e.preventDefault();
    var target = $(this).data('target');
    $(this).toggleClass('open');
    $('body').toggleClass('locked');
    $(target).toggleClass('active');
    //$(target).slideToggle();
  });
  
  function closeModal(event) {
		$(this).removeClass('show');
  }
  
  $('[data-dismiss="modal"], [data-modal]').on('click.closeModal', closeModal);

  /*
   * Convert any element into a giant button
   */
  function clickthrough(e) {
    var target = $(this).find('a:first-of-type');
    e.preventDefault();
    if(target && target.length > 0){
      document.location.href = target.attr('href');
    }else{
      document.location.href = $(this).attr('data-clickthrough');
    }
  }

  $('[data-clickthrough]').each(function(args){
    $(this).on('click.clickthrough', clickthrough);
  });
  
  //Dev Note: going to move this into the Backgrounder component for reusability
  //BEOF Backgrounder

  function setSize(){
    vw = window.outerWidth;
    vh = window.outerHeight;
  }

  /* Dev Note: need an xs, xxs size, as well as new xxl xxxl */
  function getSize(){
    var size = 'small';
    if(vw >= breakpoints.xl){
      size = 'xl';
    }else if(vw >= breakpoints.lg && vw < breakpoints.xl) {
      size = 'lg';
    }else if(vw > breakpoints.sm && vw < breakpoints.lg) {
      size = 'md';
    }
    return size;
  }

  function refactor(e){
    setSize();
    var size = getSize();
    //Dev Note: Create a date attr for the size and only call 'makeBg' oncer per size.
    makeBg(size);
  }

  //Reads the "featured" image (class based) and sets the target background to whatever image is dynamically loaded then animates it in.
  function makeBg(size){
    if(!size){
      size = getSize();
    }

    $('[data-backgrounder]').each(function(args){

      var feat    = $(this).find('.feature');
      var target  = feat;//See if there's a featured image here, if not, just use the parent
      if(feat.length <= 0) {
        target = $(this);
      }

      var img     = false;

      if(feat.length > 0) {
        img = $(feat).find('img');
      }else{
        img = $(this).find('img');
      }

      if(img.length > 0) {
        var src = $(img).attr('src');
        if($(img).attr('data-src-xl') && size === 'xl') {
          src = $(img).attr('data-src-xl');
        }
        if($(img).attr('data-src-lg') && size === 'lg') {
          src = $(img).attr('data-src-lg');
        }
        if($(img).attr('data-src-md') && size === 'md') {
          src = $(img).attr('data-src-md');
        }
        if($(this).attr('style')){
            if(feat.length > 0) {
              $(feat).css('background-color',$(this).css('background-color'));
              $(feat).delay(300).fadeOut(300);
            }
            $(this).css({'background-image': 'url('+src+')'});
        }else{
          $(this).css({'background-image':'url('+src+')', 'background-color':$(this).css('background-color')});
          if(feat.length > 0) {
            $(feat).delay(300).fadeOut(300);
          }
        }
      }
    });
  }
  //EOF


  $(window).on('resize.refactor', refactor);
  refactor();
  
  window.addEventListener('load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
      	console.log('form.checkValidity() ', form.checkValidity() )
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
  
	let visitTypes = [];
	
	visitTypes[0] = {key:'this_visit_is_for_a_relative', value:'This visit is for a relative', html:`<div class="row seafoam">
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Patients First Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Patient First Name">
				<div class="invalid-feedback">
						Please provide a patients first name.
					</div>
			</div>
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Patients Last Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Patient Last Name">
				<div class="invalid-feedback">
						Please provide a patients last name.
					</div>
			</div>
		</div>`}
		
	visitTypes[1] = {key:'this_visit_is_for_a_business', value:'This visit is for a business', html:`	<div class="row goldenrod">
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Patients First Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Patient First Name">
				<div class="invalid-feedback">
						Please provide a patients first name.
					</div>
			</div>
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Patients Last Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Patient Last Name">
				<div class="invalid-feedback">
						Please provide a patients last name.
					</div>
			</div>
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Business Name" pattern="^[^-\s][a-zA-Z0-9_ \s-]{0,}$" type="text" required placeholder="Business Name">
				<div class="invalid-feedback">
						Please provide a business name.
					</div>
			</div>
			<div class="form-group col-lg-6 px-lg-1">
				<select name="Business Type" required>
					<option value="">Business Type</option>
					<option value="type0">Type 0</option>
					<option value="type1">Type 1</option>
					<option value="type2">Type 2</option>
					<option value="type3">Type 3</option>
				</select>
				<div class="invalid-feedback">
						Please provide a business type.
					</div>
			</div>
		</div>`}
		
	visitTypes[2] = {key:'this_visit_is_for_someone_else', value:'This visit is for someone else', html:`	<div class="row gold">
			<div class="form-group col-lg-12 px-lg-1">
				<input type="text" name="Pourpose of visit" pattern="^[^- \s][a-zA-Z0-9_ \s-]{0,}$" type="text" required placeholder="Purpose of the visit">
				<div class="invalid-feedback">
						Please provide a pourpose of visit.
					</div>
			</div>
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Patients First Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Patient First Name">
				<div class="invalid-feedback">
						Please provide a patients first name.
					</div>
			</div>
			<div class="form-group col-lg-6 px-lg-1">
				<input type="text" name="Patients Last Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Patient Last Name">
				<div class="invalid-feedback">
						Please provide a patients last name.
					</div>
			</div>
		</div>	`}
	
	let visitTypesSelect 	= document.querySelector('#visit_type');
	let slideoutBtns 			= document.querySelector('[data-slideout]');
	let housecallForm 		= document.querySelector('#housecall_contact');
	let slideout 					= document.querySelector('[data-slideout-container]');
	let recaptchaFeed 		= document.querySelector('form .recaptcha');
	let body 							= document.querySelector('body');
	
	for(var i = 0; i < visitTypes.length; i++) {
		var opt = document.createElement('option');
		opt.innerHTML = visitTypes[i].value;
		opt.value = visitTypes[i].value;
		visitTypesSelect.appendChild(opt);
	}
	
	$('[data-slideout]').on('click.toggleHousecallForm', toggleHousecallForm);
	$('button[type="cancel"]').on('click.hideHousecallForm', hideHousecallForm);
	
	function showVistTypeOptions(value){
		let foundMatch = false;
		let elem = document.querySelector('#extra_visit_type_info');
		for(var i = 0; i < visitTypes.length; i++){
			if(visitTypes[i].value == value){
				foundMatch = true;
				elem.innerHTML = visitTypes[i].html;
			}
		}
		if( !foundMatch )
			elem.innerHTML = "";
	}
	
	function hideHousecallForm(event){
		toggleHousecallForm();
	}
	
	function toggleHousecallForm(event){
		if( !event ){
			slideout.classList.remove('open');
			slideoutBtns.classList.remove('invisible');
			slideoutBtns.classList.remove('disabled');
			housecallForm.classList.remove('was-validated');
//			housecallForm.reset();
//			let elem = document.querySelector('#extra_visit_type_info');
//			elem.innerHTML = "";
			recaptchaFeed.classList.remove('invalid');
			$('body').scrollTop = 0;
		}else {
			slideout.classList.add('open');
			slideoutBtns.classList.add('invisible');
			slideoutBtns.classList.add('disabled');
		}
	}
  
  $('#housecall_contact').submit(function (e) {
		if(grecaptcha.getResponse() == "") {
			e.preventDefault();
			recaptchaFeed.classList.add('invalid');
		} else {
			recaptchaFeed.classList.remove('invalid');
		}
	});
	  
  function formSubmit(response){
  	console.log(response)
  }

  var activeBtn = $('[data-sidenav] a[href="'+ url +'"]');
  var wheelLinks = $('a.wheel');
  
  if( activeBtn ){
	  activeBtn.addClass('active');
	  if( wheelLinks.length ) {
	  	$('[data-sidenav] a[rawurl="services"]').addClass('active');
		  $('a.wheel[href="'+ url +'"]').addClass('active');
		}
	}
	
	
	// Demo by http://creative-punch.net
	var items = document.querySelectorAll('.circle a');

	for(var i = 0, l = items.length; i < l; i++) {
	  items[i].style.left = (50 - 70*Math.cos(-0.5 * Math.PI - 2*(1/l)*i*Math.PI)).toFixed(4) + "%";
  
	  items[i].style.top = (50 + 70*Math.sin(-0.5 * Math.PI - 2*(1/l)*i*Math.PI)).toFixed(4) + "%";
	}
	
	wheelLinks.on('click.loadServicePage', loadServicePage);

	function loadServicePage(event){
		var elem = event.target;
		event.preventDefault();
		
		var url = '/layoutone.ashx?id=' + $(elem).attr("linkid");
		
		for(var i = 0; i < wheelLinks.length; i++)
			wheelLinks[i].classList.remove('active');
			$(elem).addClass("active");
		try{
			$.get(url, function(data, status){
				$("[data-service-list]").html(data);
			});
		}
		catch(ev){
//			console.log(ev)
		}
		return false
	}

	$(carousel).carousel({
        interval: 3000,
        pause: "false"
      });

  //Animate everything with this one class
  $('body').addClass('loaded');
  
  var setAnimated = setTimeout(function(){
    $('body').addClass('animated');
    //Dev Note:
  }, 2000);
});