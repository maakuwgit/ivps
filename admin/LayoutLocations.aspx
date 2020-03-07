<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Layout.aspx.vb" Inherits="Layout" %>
<% @Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

        	<div class="container p-5">
        		<div class="row"> 
			<div class="col-12">
				<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
			</div>
		</div>
	</div>
	
  <style>
    /* Always set the map height explicitly to define the size of the div
     * element that contains the map. */
    #map {
      height: 100%;
    }
    /* Optional: Makes the sample page fill the window. */
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
    }
 </style>
	<div class="container-fluid px-lg-5">
	    <div class="mx-lg-5 row py-2 ">
			<div class="col-lg-2 col-10 p-lg-0 pr-0">
				<select id="radiusSelect" label="Radius" class="custom-select custom-select-sm">
					<option value="100">100 mile radius</option>
					<option value="50">50 mile radius</option>
					<option value="30">30 mile radius</option>
					<option value="20">20 mile radius</option>
					<option value="10" selected>10 mile radius</option>
			   </select>
			</div>	   
			<div class="col-lg-2 col-2 p-lg-0 pl-0 text-right text-lg-left">
				<button id="currentLocation" class="btn btn-sm bg-white" title="Current Location"><i class="fas fa-map-marker-alt text-primary fa-lg"></i></button>
			</div>
    		</div>
    </div>
    <div class="container-fluid px-lg-5 mb-5">
    		<div class="mx-lg-5 border">
    			<div class="row font-size-75 m-0">
    				<div class="col-lg-3 p-0 bg-white order-1 col-12 result-pane">
    				 	<div class="d-flex border"><input type="text" id="addressInput" class="form-control border-0" placeholder="Enter a location" size="15"/><button id="searchButton" value="" class="btn btn-primary rounded-0" title="Search"><i class="fas fa-search"></i></button></div>
    					<ul class="list-group d-none d-lg-block" id="locationList" >
    					</ul>
    				</div>
    				<div class="col-lg-9 p-0 order-2 col-12 map-container">
    					<div id="map" ></div>
    				</div>
    			</div>
    		</div>
    		<div class="row d-lg-none">
    			<div class="col-12 mt-3">
	    			<select id="locationSelect" style="visibility: hidden" class="custom-select custom-select-sm"></select>
	    		</div>
	    	</div>
    </div>
    
    		
    
    <script>
      var map;
      var markers = [];
      var infoWindow;
      var locationSelect;
      var locationList;
      var currentLocation;
      var currentLocationMarker;
      var currentLocationPoint;
      var radiusSelect;

	 /*
     	Init Map
     */
     function initMap() {
          
          map = new google.maps.Map(document.getElementById('map'), {
            center: new google.maps.LatLng(41.850033, -87.6500523),
            zoom: 4,
            mapTypeId: 'roadmap',
            mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU}
          });
          
          infoWindow = new google.maps.InfoWindow();

          searchButton = document.getElementById("searchButton").onclick = searchLocations;

          locationSelect = document.getElementById("locationSelect");
          locationList = document.getElementById("locationList");
          currentLocation = document.getElementById("currentLocation");
          radiusSelect = document.getElementById("radiusSelect");
          
          locationSelect.onchange = function() {
            var markerNum = locationSelect.options[locationSelect.selectedIndex].value;
            if (markerNum != "none"){
              google.maps.event.trigger(markers[markerNum], 'click');
            }
          };
          
          currentLocation.onclick = function(){
          	showCurrentLocation()
          	document.getElementById("addressInput").value = ""
          };
          
          radiusSelect.onchange = function() {
            	var address = document.getElementById("addressInput").value;
            	if(address.trim().length > 0 )
            		searchLocations()
            	else
            		showCurrentLocation()
          };
          
          loadLocation()
          
        }
        
     function loadLocation(){
     	var address = getUrlParameter("q")
		if(address){
			document.getElementById("addressInput").value = address
			searchLocations()
		}	
		else{
			showCurrentLocation()
		}
     }
     
     function getUrlParameter(name) {
	    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
	    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
	    var results = regex.exec(location.search);
	    return results === null ? false : decodeURIComponent(results[1].replace(/\+/g, ' '));
	};
        
     function showCurrentLocation(){
     		// Try HTML5 geolocation.
		   if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
			  var pos = {
			    lat: position.coords.latitude,
			    lng: position.coords.longitude
			  };

			  map.setCenter(pos);
			  map.setZoom(11)
			  //
			  // Search location
			  //center.lat() + '&lng=' + center.lng()
			  currentLocationPoint = {
			  	lat: function(){
			  		return pos.lat
			  	},
			  	lng: function(){
			  		return pos.lng
			  	}
			  }
			  
			  searchLocationsNear(currentLocationPoint);
			  
			  addCurrentLocationMarker()
			  
			}, function() {
			  handleLocationError(true, infoWindow, map.getCenter());
			});
		   } else {
			// Browser doesn't support Geolocation
			handleLocationError(false, infoWindow, map.getCenter());
		   }
        
     }
     
     function addCurrentLocationMarker(){
     	if( ! currentLocationMarker ){
     		currentLocationMarker = new google.maps.Marker({
				position: map.getCenter(),
				icon: {
				  path: google.maps.SymbolPath.CIRCLE,
				  scale: 5
				},
				draggable: false,
				map: map
			});
	   	}
     }
        
     function handleLocationError(browserHasGeolocation, infoWindow, pos) {
       	infoWindow.setPosition(pos);
        	infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        	infoWindow.open(map);
      }
        
     
     /*
     	Search Locations
     */
     function searchLocations() {
         var address = document.getElementById("addressInput").value;
         var geocoder = new google.maps.Geocoder();
         geocoder.geocode({address: address}, function(results, status) {
           if (status == google.maps.GeocoderStatus.OK) {
           	console.log(results)
            	searchLocationsNear(results[0].geometry.location);
           } else {
             alert(address + ' not found');
           }
         });
       }

       function clearLocations() {
         infoWindow.close();
         for (var i = 0; i < markers.length; i++) {
           markers[i].setMap(null);
         }
         markers.length = 0;

         locationSelect.innerHTML = "";
         var option = document.createElement("option");
         option.value = "none";
         option.innerHTML = "See all results:";
         locationSelect.appendChild(option);
         
         locationList.innerHTML = "";
       }

	/*
	Adds markers to map
	*/
       function searchLocationsNear(center) {
         var radius = document.getElementById('radiusSelect').value;
         var searchUrl = 'ClosestMarkers.ashx?lat=' + center.lat() + '&lng=' + center.lng() + '&radius=' + radius;
         downloadUrl(searchUrl, function(data) {
           var xml = parseXml(data);
           
           var markerNodes = xml.documentElement.getElementsByTagName("marker");
           var bounds = new google.maps.LatLngBounds();
           
           clearLocations();
           
           for (var i = 0; i < markerNodes.length; i++) {
             var id = markerNodes[i].getAttribute("id");
             var name = markerNodes[i].getAttribute("name");
             var address = markerNodes[i].getAttribute("address");
             var distance = parseFloat(markerNodes[i].getAttribute("distance"));
             var city = markerNodes[i].getAttribute("city");
             var state = markerNodes[i].getAttribute("state");
             var zip = markerNodes[i].getAttribute("zip");
             var phone = markerNodes[i].getAttribute("phone");
             
             var latlng = new google.maps.LatLng(parseFloat(markerNodes[i].getAttribute("lat")),parseFloat(markerNodes[i].getAttribute("lng")));

             createOption(name, distance, i);
             createMarker(latlng, name, address, city, state, zip, phone, distance);
             createListItem(i, name, distance, address, city, state, zip, phone)
             bounds.extend(latlng);
           }
           
           map.fitBounds(bounds);
           locationSelect.style.visibility = "visible";
           
           locationSelect.onchange = function() {
             var markerNum = locationSelect.options[locationSelect.selectedIndex].value;
             google.maps.event.trigger(markers[markerNum], 'click');
           };
           
           // No results returned
           if( markerNodes.length == 0){
           	var message = "Did not find any retail stores near your location"
           	map.setCenter(center);
           	infoWindow.setPosition(map.getCenter());
			infoWindow.setContent('<div class="font-size-125">' + message + '</div>');
			infoWindow.open(map);
			createNoResultsListItem(message)
           }
           
         });
       }

       function createMarker(latlng, name, address, city, state, zip, phone, distance) {
       	var directionsUrl = "https://www.google.com/maps/dir/Current+Location/" + name + ", " + address + ", " + city + ", " + state + ", " + zip
          var html = "<div class='p-1'><div class='font-weight-bold mb-1 font-size-125'>" + name + "</div> <div class='font-size-115'>" + address + "<br>" + city + " " + state + ", " + zip + "</div><div class='mt-1 font-size-115'><a href='tel:"+phone+"'>" + formatPhoneNumber(phone) + "</a></div><div class='mt-2 font-size-125'><a href='" + directionsUrl + "' target='_blank' title='Get Directions'><span>" + distance + " miles <i class='fas fa-directions'></i></span></a></div></div>";
          var marker = new google.maps.Marker({
            map: map,
            position: latlng
          });
          google.maps.event.addListener(marker, 'click', function() {
            	infoWindow.setContent(html);
            	infoWindow.open(map, marker);
          });
          markers.push(marker);
        }

       function createOption(name, distance, num) {
          var option = document.createElement("option");
          option.value = num;
          option.innerHTML = name;
          locationSelect.appendChild(option);
       }
       
       function createListItem(num, name, distance, address, city, state, zip, phone) {
          var li = document.createElement("li");
          li.style.cursor = "pointer";
          li.onclick = function() {
            var markerNum = num
            var items = locationList.querySelectorAll(".list-group-item")
            for(var i = 0; i < items.length; i++){
            	items[i].classList.remove("active")
            	items[i].classList.remove("text-white")
            	items[i].querySelector("a").classList.remove("text-white")
            }
            
            var item = this.querySelector(".list-group-item")
            item.classList.add("active")
            item.classList.add("text-white")
            item.querySelector("a").classList.add("text-white")
            
            if (markerNum != "none"){
              google.maps.event.trigger(markers[markerNum], 'click');
            }
          };
          li.classList.add("rounded-0")
 		locationList.appendChild(li);
 		var directionsUrl = "https://www.google.com/maps/dir/Current+Location/" + name + ", " + address + ", " + city + ", " + state + ", " + zip
 		
 		//"https://www.google.com/maps?q=` + name + ` ` + address + ` ` + city + ` ` + state + ` ` + zip + `"
 		
          li.innerHTML = `<div  class="list-group-item list-group-item-action flex-column align-items-start">
    								<div class="d-flex w-100 justify-content-between">
      							<div class="font-weight-bold pb-1">` + name + `</div>
      							<a href="` + directionsUrl +  `" target="_blank" title="Get Directions"><span>` + distance + ` miles <i class="fas fa-directions"></i></span></a>
    								</div>
    								<p class="mb-1">` + address + `<br>` + city + ` ` + state + `, ` + zip + `<br><span onclick="window.location='tel:` + phone + `'">` + formatPhoneNumber(phone) + `</span></p>
  								</div>
  								`;
       }
       
       function createNoResultsListItem(message){
       	console.log(message)
       	var li = document.createElement("li");
       	locationList.appendChild(li);
       	 li.innerHTML = `<div class="p-3"><div class="text-center text-dark pb-1">` + message + `</div></div>`;
       }

       function downloadUrl(url, callback) {
          var request = window.ActiveXObject ?
              new ActiveXObject('Microsoft.XMLHTTP') :
              new XMLHttpRequest;

          request.onreadystatechange = function() {
            if (request.readyState == 4) {
              request.onreadystatechange = doNothing;
              callback(request.responseText, request.status);
            }
          };

          request.open('GET', url, true);
          request.send(null);
       }

       function parseXml(str) {
          if (window.ActiveXObject) {
            var doc = new ActiveXObject('Microsoft.XMLDOM');
            doc.loadXML(str);
            return doc;
          } else if (window.DOMParser) {
            return (new DOMParser).parseFromString(str, 'text/xml');
          }
       }

     function doNothing() {}
       
     function formatPhoneNumber(phoneNumberString) {
		  var cleaned = ('' + phoneNumberString).replace(/\D/g, '')
		  var match = cleaned.match(/^(1|)?(\d{3})(\d{3})(\d{4})$/)
		  if (match) {
		    var intlCode = (match[1] ? '+1 ' : '')
		    return [intlCode, '(', match[2], ') ', match[3], '-', match[4]].join('')
		  }
		  return ""
	}
       
  </script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCqYwczA6YKqiPxphJylgdthyp3uhnNPCw&callback=initMap"></script>
	
</asp:Content>