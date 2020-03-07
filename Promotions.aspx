<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Promotions.aspx.vb" Inherits="Promotions" %>


<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <section class="container">
       
        <div class="wow fadeInDown">
			    <%= GetContent("Promotions")%>
        </div>
        
        <section class="promotions">
            <div class="row">
                 <div class="col-md-12">
                    <div id="dvPromo" runat="server"></div>
                 </div>
            </div>
        </section>
    </section>
        
            
     
        

    <script>
        $(".promolink a").addClass("sel");
    </script>
</asp:Content>

