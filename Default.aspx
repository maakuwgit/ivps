<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<!-- #Include file="\PageWidgets\ImageSliderWidget.aspx" -->	
<!-- #Include file="\PageWidgets\DefaultServicesNav.aspx" -->
<div class="row col-12 ml-2 mt-2 mb-2 pr-2 pr-lg-0">
	<article class="d-flex flex-column col-12 col-md-6 pl-0 pr-1">
		<section class="card mb-2">
			<h2 class="h4">Core Values</h2>
			<hr>
			<ul>
				<li>Highest quality of care</li>
				<li>Treat all patients withe the utmost compassion</li>
				<li>Easily accessible to our patients and their families</li>
				<li>Uncompromising integrity and professionalism</li>
			</ul>
		</section>
		<section class="card">
			<h2 class="h4">Mission</h2>
			<hr>
			<p>Our mission is to provide prompt, high quality coordinated medical care delivered by healthcare practitioners in the home and improve both the health and quality of life of our patients.</p>
		</section>
	</article>
	<aside class="col-12 col-md-6 pr-lg-3 pr-2 pl-1 mt-2 mt-lg-0">
		<div class="card h-100 rounded-0 border-0 position-relative" style="background:#bec8da;">
			<div class="position-relative p-4 card border-0 right one">
				<h2 class="h3">Remember the House Call?</h2>
				<hr>
				<p>Just like the doctors of old, Integrated Visiting Physician Solutions, PC or IVPS know patients. by their first names. Imagine a doctor coming to your house and practicing 21st century medicine the good old fashion way. Our Doctors are caring, dedicated, and compassionate individuals who are highly trained in the treatment of geriatric and homebound patients.</p>
				<nav class="text-center">
					<a href="#housecall_contact" data-slideout class="btn">Request Housecall</a>
				</nav>
			</div>
			<img src="/images/house.png" class="position-absolute" style="bottom:0;left:0;" alt="A vector photo of a house and 2 trees">
			<img src="/images/doctor.png" class="position-absolute d-none d-lg-inline" style="bottom:0;right:0;z-index:5;" alt="A vector photo of a brown-haired doctor">
		</div>
	</aside>
</div>
</asp:Content>