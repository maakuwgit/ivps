$(document).ready(function () {
  var url = window.location.pathname;  

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
  
  
  $('.navbar a[href="'+ url +'"]').addClass('active');

  //Animate everything with this one class
  $('body').addClass('loaded');
  var setAnimated = setTimeout(function(){
    $('body').addClass('animated');
    //Dev Note:
  }, 2000);
});