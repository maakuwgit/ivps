<% @Import Namespace="System.Data" %>
<%
	If  Forms.EventTracking.Label.toString().length = 0 Then
		Forms.EventTracking.Label = Request.RawUrl.Replace("/", " ") & " Page"
	End If
	Forms.Email.FormName = "IVPS Housecall Request"
%>
<form method="POST" action="/email.ashx" id="housecall_contact" class="needs-validation" novalidate>

	<input type="hidden" name="<%= Forms.Email.LANDING_PAGE %>" value="<%= Forms.StringToBase64(Forms.LandingPage.BuildUrl()) %>">
	<input type="hidden" name="<%= Forms.Email.MAILING_LIST %>" value="<%= Forms.StringToBase64(Forms.Email.MailingList) %>">
	<input type="hidden" name="<%= Forms.Email.NAME %>" value="<%= Forms.StringToBase64(Forms.Email.FormName) %>">
	<input type="hidden" name="<%= Forms.SESSION_GUID %>" value="<%= Forms.SessionGuid %>">
	<noscript>
		<input type="hidden" name="noscript" value="true">
	</noscript>
	
	<legend class="row mb-3">
		<span class="h1 col px-lg-1">We just need a little bit of information</span>
	</legend>
	
	<div class="row">
		<div class="form-group col-lg-6 px-lg-1">
			<select aria-label=="Visit Type" name="Visit Type" onchange="showVistTypeOptions(this.options[this.selectedIndex].value)" id="visit_type">
				<option value="self" selected>This visit is for myself</option>
			</select> 
		</div>
		<label class="form-group col-lg-6 px-lg-1">
			<span>Preferred Contact</span>
			<input class="form-control" type="radio" name="preferred_contact" id="preferred_contact--phone" value="phone">
			<input class="form-control" type="radio" name="preferred_contact" id="preferred_contact--email" value="email">
			<div class="invalid-feedback">
				Please provide a first name.
			</div>
		</label>
	</div>
	
	<div id="extra_visit_type_info">
	</div>

	<div class="row">
		<div class="form-group col-lg-4 px-lg-1">
			<input type="text" aria-label="First Name" name="First Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="First Name" class="form-control">
			<div class="invalid-feedback">
					Please provide a first name.
				</div>
		</div>
		<div class="form-group col-lg-4 px-lg-1">
			<input type="text" aria-label="Last Name" name="Last Name" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Last Name" class="form-control">
			<div class="invalid-feedback">
					Please provide a last name.
				</div>
		</div>
		<div class="form-group col-lg-4 px-lg-1">
			<input type="email" aria-label="Email" name="Email"  pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" required placeholder="Email" class="form-control">
			<div class="invalid-feedback">
					Please provide an email.
				</div>
		</div>
	</div>
	
	<div class="row">
		<div class="form-group col-lg-4 px-lg-1">
			<input type="tel" aria-label="Phone" name="Phone"  pattern="^[^-\s][_0-9\-@.\s]{6,}$" required placeholder="Phone" class="form-control">
			<div class="invalid-feedback">
					Please provide a phone number.
				</div>
		</div>
		<div class="form-group col-lg-4 px-lg-1">
			<input type="text" aria-label="Zipcode" name="Zipcode" pattern="^[^-\s][_0-9\-@.\s]{4,}$" required placeholder="Zipcode" class="form-control">
			<div class="invalid-feedback">
					Please provide a Zipcode.
				</div>
		</div>
		<div class="form-group col-lg-4 px-lg-1">
			<select aria-label="State" name="State" required class="form-control">
				<option value="">State</option>
				<option value="AL">Alabama</option>
				<option value="AK">Alaska</option>
				<option value="AZ">Arizona</option>
				<option value="AR">Arkansas</option>
				<option value="CA">California</option>
				<option value="CO">Colorado</option>
				<option value="CT">Connecticut</option>
				<option value="DE">Delaware</option>
				<option value="DC">District Of Columbia</option>
				<option value="FL">Florida</option>
				<option value="GA">Georgia</option>
				<option value="HI">Hawaii</option>
				<option value="ID">Idaho</option>
				<option value="IL">Illinois</option>
				<option value="IN">Indiana</option>
				<option value="IA">Iowa</option>
				<option value="KS">Kansas</option>
				<option value="KY">Kentucky</option>
				<option value="LA">Louisiana</option>
				<option value="ME">Maine</option>
				<option value="MD">Maryland</option>
				<option value="MA">Massachusetts</option>
				<option value="MI">Michigan</option>
				<option value="MN">Minnesota</option>
				<option value="MS">Mississippi</option>
				<option value="MO">Missouri</option>
				<option value="MT">Montana</option>
				<option value="NE">Nebraska</option>
				<option value="NV">Nevada</option>
				<option value="NH">New Hampshire</option>
				<option value="NJ">New Jersey</option>
				<option value="NM">New Mexico</option>
				<option value="NY">New York</option>
				<option value="NC">North Carolina</option>
				<option value="ND">North Dakota</option>
				<option value="OH">Ohio</option>
				<option value="OK">Oklahoma</option>
				<option value="OR">Oregon</option>
				<option value="PA">Pennsylvania</option>
				<option value="RI">Rhode Island</option>
				<option value="SC">South Carolina</option>
				<option value="SD">South Dakota</option>
				<option value="TN">Tennessee</option>
				<option value="TX">Texas</option>
				<option value="UT">Utah</option>
				<option value="VT">Vermont</option>
				<option value="VA">Virginia</option>
				<option value="WA">Washington</option>
				<option value="WV">West Virginia</option>
				<option value="WI">Wisconsin</option>
				<option value="WY">Wyoming</option>
			</select>
			<div class="invalid-feedback">
					Please provide a state.
				</div>
		</div>
	</div>
	
	<div class="row">
		<div class="form-group col-lg-6 px-lg-1">
			<input type="text" aria-label="Primary Insurance" name="Primary Insurance" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="Primary Insurance" class="form-control">
			<div class="invalid-feedback">
					Please provide primary insurance.
				</div>
		</div>
		<div class="form-group col-lg-6 px-lg-1">
			<input type="text" aria-label="How did you hear about us" name="How did you hear about us" pattern="^[^-\s][a-zA-Z0-9_\s-]{0,}$" type="text" required placeholder="How did you hear about us?" class="form-control">
			<div class="invalid-feedback">
					Please tell us how you heard of us.
				</div>
		</div>
	</div>
	
	<div class="row">
		<div class="form-group col-12 px-lg-1">
			<textarea aria-label="Comments"  name="Comments" required placeholder="Please provide a brief description of your symptoms" class="form-control"></textarea>
			<div class="invalid-feedback">
					Please provide the reason for contacting.
				</div>
		</div>
	</div>
	
	<div class="row g-recaptcha" data-sitekey="6Lc8U68UAAAAABpyuPgjp2mWnDt5LY-HRupra-rV"></div>
	<div class="recaptcha feedback pb-3">ReCaptcha not clicked.</div>
	
	<nav class="row justify-content-between">
		<button type="cancel" class="btn btn--chocolate-drk m-0">Cancel</button>
		<button type="submit" class="btn btn-primary m-0" >Submit</button>
	</nav>
</form>