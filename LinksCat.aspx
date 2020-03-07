<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="LinksCat.aspx.vb" Inherits="Links" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
			
<section id="blog" class="container">
	<asp:Repeater runat="server" ID="Category">
		<ItemTemplate>
			<div class="wow fadeInDown">
				<h1><%#Eval("Name") %></h1>
			</div>

		</ItemTemplate>
	</asp:Repeater>	
		<section>
				<div class="blog">
					 <div class="col-md-9 col-xs-12 row">
							<asp:Repeater runat="server" ID="Links" OnItemDataBound="Repeater_ItemDataBound">
								<ItemTemplate>
								<div class="col-md-12 col-sm-12 col-xs-12 link__item__content" style="margin-bottom:3rem;">
									<div class="row">
										<div class="col-xs-1" style="min-height-:10rem;">
											<img src='<%#Eval("ImgSrc") %>'  class="img-responsive"/>
										</div>
										<div class="col-xs-11 no-float">
											<div class="col-xs-12">
											<h2 style="margin-top:0"><%#Eval("Name") %></h2>
											</div>
											<div class="col-xs-12">
												<%# Eval("Description")%>
											</div>
											<div class="col-xs-12">
											<a target="_blank" href="http://<%# Eval("Link")%>"><%# Eval("Link")%></a>
											</div>
										</div>
									</div>
								</div>
								</ItemTemplate>
								<FooterTemplate>
								    <asp:Label ID="lblErrorMsg" runat="server" CssClass="errMsg" Text="<h3>No links in this category</h3>" Visible="false"></asp:Label>
								</FooterTemplate>
							</asp:Repeater>
						</div>
						<div class="col-md-3 col-xs-12">
							<div class="col-xs-12"><a href="/Links.aspx"><i class="fa fa-chevron-left"></i> Back to Links</a></div>
							<div class="col-xs-12 row"><hr></div>
							<div class="col-xs-12"><h3>Categories</h3></div>
							<asp:Repeater runat="server" ID="Categories">
								<ItemTemplate>
									<div class="col-xs-12">
										<a href="/LinksCat.aspx?id=<%#Eval("Id") %>"><%#Eval("Name") %></a>
									</div>
								</ItemTemplate>
							</asp:Repeater>
							<div class="col-xs-12 row"><hr></div>
						</div>

						<aside class="col-md-4">
						</aside>  
			
				</div>
			</section>

</section>
        
    </div>

</asp:Content>