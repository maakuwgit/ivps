<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

<header class="pl-3" style="background-color:#681786;">
<h1 class="w-100 text-center text-white">Integrated Visiting Physician Solution</h1>
<hr class="mx-auto">
</header>
<!-- #Include file="\PageWidgets\ImageSliderWidget.aspx" -->	
<div class="d-flex w-100 bg-brown justify-content-between p-2 flex-wrap">
		<%= Website.Link(16).AddClass("text-white hp text-center d-flex flex-column col-lg col-6").CreateElement() %>
		<%= Website.Link(22).AddClass("text-white hp text-center d-flex flex-column col").CreateElement() %>
		<%= Website.Link(18).AddClass("text-white hp text-center d-flex flex-column col-lg col-6").CreateElement() %>
		<%= Website.Link(17).AddClass("text-white hp text-center d-flex flex-column col").CreateElement() %>
		<%= Website.Link(21).AddClass("text-white hp text-center d-flex flex-column col-lg col-6").CreateElement() %>
		<%= Website.Link(15).AddClass("text-white hp text-center d-flex flex-column col").CreateElement() %>
		<%= Website.Link(23).AddClass("text-white hp text-center d-flex flex-column col-lg col-6").CreateElement() %>
		<%= Website.Link(19).AddClass("text-white hp text-center d-flex flex-column col").CreateElement() %>
		<%= Website.Link(20).AddClass("text-white hp text-center d-flex flex-column col-lg col-6").CreateElement() %>
		<%= Website.Link(14).AddClass("text-white hp text-center d-flex flex-column col").CreateElement() %>
</div>
<div class="row col-12 ml-2 mt-2 mb-2 pr-2 pr-lg-0">
	<div class="col-lg-6 pl-0 pr-1">
		<div class="card mb-2">
			<h4>Core Values</h4>
			<hr>
			<ul class="" style="list-style-position: inside">
				<li>Highest quality of care</li>
				<li>Treat all patients withe the utmost compassion</li>
				<li>Easily accessible to our patients and their families</li>
				<li>Uncompromised integrity and professionalism</li>
			</ul>
		</div>
		<div class="card">
			<h4>Mission</h4>
			<hr>
			<p>Our mission is to provide prompt, high quality coordinated medical care delivered by healthcare practitioners in the home and improve both the health and quality of life of our patients.</p>
		</div>
	</div>
	<div class="col-lg-6 pr-lg-3 pr-2 pl-1 mt-2 mt-lg-0">
		<div class="card h-100 rounded-0 border-0 position-relative" style="background:#bec8da;">
			<div class="position-relative p-4 card border-0 right one" style="">
				<h4>Remember the House Call?</h4>
				<hr>
				<p>
					Just like the doctors of old, Integrated Visiting Physician Solutions, PC or IVPS know patients. by their first names. Imagine a doctor coming to your house and practicing 21st century medicine the good old fashion way. Our Doctors are caring, dedicated, and compassionate individiuals who are highly trained in the treatment of geriatric and homebound patients.
				</p>
				<nav class="text-center">
					<a href="#request_housecall" data-slideout class="btn" onclick="toggleHousecallForm()">Request Housecall</a>
				</nav>
			</div>
			<img src="/images/house.png" class="position-absolute" style="bottom:0;left:0;">
			<img src="/images/doctor.png" class="position-absolute d-none d-lg-inline" style="bottom:0;right:0;z-index:100;">
		</div>
	</div>
</div>

<!--article class="col-12">
	<%= GetContent("Home")%>
</article-->

<style>
main .viewport .carousel .carousel-item{width:calc(100vw - 5rem)}
.hp .icon{width:40px;height:40px;display:block;margin: .25rem auto !important;color:#d1c094;}
.card .right.one{background:rgba(255,255,255,.85);z-index:10;}
@media (min-width: 1280px){
	main .viewport{padding-left:12.5vw !important;margin-right: -32px;}
	main .viewport.collapsed {padding-left:4rem !important;}
	main .viewport .carousel .carousel-item{width:calc(1600px - 12.5vw)}
	main .viewport.collapsed .carousel .carousel-item{width:calc(1600px - 4rem)}
	.card .right.one{margin-right:15%;}
}
.hp{font-size:.7rem;}
.card{border:1px solid rgba(156, 85, 182, 0.33);border-radius:5px;padding:1rem;}
header nav#request-housecall-nav{display:none;}
</style>
</asp:Content>