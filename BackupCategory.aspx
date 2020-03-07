<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="BackupCategory.aspx.vb" Inherits="Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
     <div class="container">
            <div class="row">
                <div class="col-md-12">
                    
                    <asp:Literal id="lblName" runat="server" />
                    <div id="gallery" class="gallery-list" runat="server"></div>
                </div>
            </div>
        </div>
   <%-- <section id="advertisement">
		<div class="container">
			<img src="images/shop/advertisement.jpg" alt="">
		</div>
	</section>--%>
    <asp:Literal id="LineContainerClass" runat="server" ></asp:Literal>
    <section id="products-top">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                        <h2 class="section-title-main" id="LineTitle" runat="server"></h2>
                        <div class="divider"></div>
                        <p id="LineDescription" runat="server"></p>
                </div>
                <div class="col-md-offset-2 col-md-4 hidden-sm hidden-xs">
                    <div class="widget important floating">
                        <h3>To speak with a licensed insurance agent call</h3>
                        <div class="aside-phone-wrap">
                            <p>
                            <i class="fa fa-mobile"></i>
                            <span class="call">Call</span>
                            1 248-689-4910 
                            </p>
                        </div>
                    </div><!--/.widget-->
                </div>
            </div>
        </div>
    </section>
    
	
	

                        

<section id="category-page">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div id="productLineContent" runat="server"></div>
            </div>
            <div class="col-md-4">
                <div id="productLineImages" runat="server"></div>
            </div>
        </div>
        <div class="row">
            <div class="wow fadeInUp animated" id="products-tab">
                <div class="tab-holder">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" id="productLines" runat="server"></ul>

                    <!-- Tab panes -->
                    <div class="tab-content" id="Cats" runat="server"></div>
                </div>
            </div>
        </div>
    </div>
</section>
</asp:Content>

