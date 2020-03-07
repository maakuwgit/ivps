<div class="g-recaptcha" data-sitekey="6LeRPmAUAAAAALXSq0A9pdDc6Fc7AXVGAK_XskQX" data-callback="formSubmit"></div>
<div class="recaptcha feedback pb-3">ReCaptcha not clicked.</div>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
     $('#contact').submit(function (e) {
		if(grecaptcha.getResponse() == "") {
			e.preventDefault();
			$('.recaptcha.feedback').addClass('invalid')
			grecaptchaFailed()``
		  } else {
			$('.recaptcha.feedback').removeClass('invalid')
			grecaptchaPassed()
		  }
	  });
      function formSubmit(response){
      	console.log(response)
      }
</script>
<style>
	.recaptcha.feedback{
		display:none;
	}
	.recaptcha.invalid{
		display:block;
		margin-top: .25rem;
		font-size: .875rem;
		color: #dc3545;
	}
</style>