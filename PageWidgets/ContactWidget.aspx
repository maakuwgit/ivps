<% @Import Namespace="System.Data" %>
<%
	If  Forms.EventTracking.Label.toString().length = 0 Then
		Forms.EventTracking.Label = Request.RawUrl.Replace("/", " ") & " Page"
	End If
	If  Forms.Email.FormName.toString().length = 0 Then
		Forms.Email.FormName = Request.RawUrl.Replace("/", " ") 
	End If
%>
<form method="POST" action="/email.ashx" id="contact" class="pb-5 needs-validation" novalidate>

	<input type="hidden" name="<%= Forms.Email.LANDING_PAGE %>" value="<%= Forms.StringToBase64(Forms.LandingPage.BuildUrl()) %>">
	<input type="hidden" name="<%= Forms.Email.MAILING_LIST %>" value="<%= Forms.StringToBase64(Forms.Email.MailingList) %>"-->
	<input type="hidden" name="<%= Forms.Email.NAME %>" value="<%= Forms.StringToBase64(Forms.Email.FormName) %>">
	<input type="hidden" name="<%= Forms.SESSION_GUID %>" value="<%= Forms.SessionGuid %>">
	<noscript>
		<input type="hidden" name="noscript" value="true">
	</noscript>
	<div class="form-group">
		<label for="name">Name</label>
		<input type="text" name="name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" id="name" class="form-control" type="text" required>
		<div class="invalid-feedback">
        			Please provide a name.
      		</div>
	</div>
	<div class="form-group">
		<label for="phone">Phone</label>
		<input type="phone" name="phone"  pattern="^[^-\s][_0-9\-@.\s]{6,}$" id="phone" class="form-control" required>
		<div class="invalid-feedback">
        			Please provide a phone number.
      		</div>
	</div>
	<div class="form-group">
		<label for="email">Email</label>
		<input type="email" name="email"  pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" id="email" class="form-control" required>
		<div class="invalid-feedback">
        			Please provide an email address.
      		</div>
	</div>
	<div class="form-group">
		<label for="comments">Message</label>
		<textarea name="comments"  id="comments" class="form-control" required></textarea>
		<div class="invalid-feedback">
        			Please provide the reason for contacting.
      		</div>
	</div>
	<div class="g-recaptcha" data-sitekey="6Lc8U68UAAAAABpyuPgjp2mWnDt5LY-HRupra-rV" data-callback="formSubmit"></div>
	<div class="recaptcha feedback pb-3">ReCaptcha not clicked.</div>
	<button type="submit" class="btn btn-primary text-white  px-5" ><i class="far fa-envelope"></i> Send</button>
</form>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
// Example starter JavaScript for disabling form submissions if there are invalid fields
(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();
</script>
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
    .g-recaptcha {
    	margin-bottom:1rem;
    }
    .has-float-label input:placeholder-shown:not(:focus)+*, .has-float-label select:placeholder-shown:not(:focus)+*, .has-float-label textarea:placeholder-shown:not(:focus)+* {
    	font-size:100%;
    	top:.8em;
    }
    #contact input, #contact textarea{
    	background-color: rgba(255, 255, 255, .9);
    }
    #contact label{
    	font-weight:500;
    }
    </style>
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


