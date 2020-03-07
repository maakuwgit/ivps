<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="About.aspx.vb" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

	<!-- #Include file="\PageWidgets\AlternatePageHeader.aspx" -->	
	<article class="col-12">
    <div class="row">
  		<div class="col-12">
  		<%
  			Dim ContentId = Request(Forms.LandingPage.CONTENT_ID_KEY)

  			Dim Title = Request(Forms.LandingPage.TITLE_KEY)
  			Dim EventTrackingLabel = Request(Forms.EventTracking.EVENT_TRACKING_LABEL_KEY)
  			Dim EventTrackingAction = Request(Forms.EventTracking.EVENT_TRACKING_ACTION_KEY)
  			Dim EventTrackingValue = Request(Forms.EventTracking.EVENT_TRACKING_VALUE_KEY)
  		%>
  			<% If Not ContentId Is Nothing AndAlso ContentId.ToString.Length > 0 Then %>
     			<%= GetContent(ContentId) %>
     		<% else if  not Website.Router.QueryString("id") is nothing then%>
     			<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
     		<% else %>
     			<%= GetContent("Thank You") %>
     		<% end if %>
     		</div>
		</div>
	</article>
		
		<script>
			if( typeof ga !== 'undefined'){
				console.log("Thank You Page:", "ga is defined - event sent")
				ga('send', 'event', '<%=EventTrackingAction %>', '<%=EventTrackingLabel %>', '<%=EventTrackingValue %>');
			}
			else {
				console.log("Thank You Page:", "ga is NOT defined - no event sent")
			}
		</script>
		
</asp:Content>