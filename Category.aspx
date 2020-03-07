<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false"
    CodeFile="Category.aspx.vb" Inherits="Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
    <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <asp:Literal id="lblName" runat="server" />
                </div>
            </div>
        </div>
    <div id="top-banner-and-menu">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-6 homebanner-holder">
                    <div class="wow fadeInDown">
                        <div id="CatContent" runat="server"></div>
                    </div>
               
            </div>
            <div class="col-xs-12 col-md-4 col-md-offset-2 sidemenu-holder">
                <!-- ================================== TOP NAVIGATION ================================== -->
                <%--<div class="side-menu animate-dropdown">
                    <div class="head"><i class="fa fa-list"></i>All Products</div>
                    <nav role="navigation" class="yamm megamenu-horizontal">
                        <ul class="nav" id="sideNavProductCats" runat="server"></ul>
                    </nav>
                </div>--%>
                <div class="widget important floating">
                    <h3>Get answers to <span class="sm-newline">questions</span> you have now!</h3>
                    <div class="aside-phone-wrap">
                        <p>
                        <i class="fa fa-mobile"></i>
                        <span class="call"></span>
                        1-248-689-4910
                        </p>
                    </div>
                       
                </div><!--/.contact-->
                <!-- /.side-menu -->
                <!-- ================================== TOP NAVIGATION : END ================================== -->
            </div>
            </div>
            <!-- /.homebanner-holder -->
        </div>
        <!-- /.container -->
    </div>
    <section id="category-page">
        <div class="wow fadeInUp" id="products-tab">
            <div class="container">
                <div class="tab-holder">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" id="productCat" runat="server"></ul>

                    <!-- Tab panes -->
                    <div class="tab-content" id="Products" runat="server"></div>
                </div>
            </div>
        </div>
    </section>
    <script>


        $(document).ready(function () {

            $("#owl-demo").owlCarousel({

                navigation: false, // Show next and prev buttons
                slideSpeed: 300,
                paginationSpeed: 400,
                autoPlay: true,
                singleItem: true

                // "singleItem:true" is a shortcut for:
                // items : 1,
                // itemsDesktop : false,
                // itemsDesktopSmall : false,
                // itemsTablet: false,
                // itemsMobile : false

            });

        });


    </script>
</asp:Content>
