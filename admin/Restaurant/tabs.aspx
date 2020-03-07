<div class="container-fluid">
	<div class="row mb-5">
	<h1><%= modname %></h1>
	</div>
	<div class="row">
	<ul class="nav nav-pills w-100">
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "menu", "active", "") %>" href="<%= baseurl %>/menu">Menus</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "section", "active", "") %>" href="<%= baseurl %>/section">Sections</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "item", "active", "") %>" href="<%= baseurl %>/item">Items</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link">|</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "menusection", "active", "") %>" href="<%= baseurl %>/MenuSection">Menu Sections</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "sectionitem", "active", "") %>" href="<%= baseurl %>/MenuSectionItem">Menu Section Items</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link">|</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "size", "active", "") %>" href="<%= baseurl %>/itemsize">Item Sizes</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link <%= iif(active = "include", "active", "") %>" href="<%= baseurl %>/ItemInclude">Item Includes</a>
		  </li>
	</ul>
	</div>
</div>
<hr>
<script>
$(function(){

	$(".published").change(function() {
		if(this.checked) {
			$("#pv").val(1)
		}
		else {
			$("#pv").val(0)
		}
	});

	$(".published-ajax").click(function(e) {
		e.stopPropagation()
		var data = new FormData()
		data.append("id", $(this).data("id"))
		data.append("tbl", $(this).data("tbl"))
		if(this.checked) {
			//alert($(this).data("id"))
			data.append("published", 1)
		}
		else {
			//alert($(this).data("id"))
			data.append("published", 0)
		}
		post(data)
	});


	$('[data-toggle="tooltip"]').tooltip()
	
	$('[data-toggle="popover"]').popover({
	    container: 'body',
	    trigger: 'hover'
	  })
	  


	  $("#searchableTableText").on("keyup", function() {
	    	var value = $(this).val().toLowerCase();
	    	$("#searchableTable tbody tr").filter(function() {
	      		$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    	});
	  });



})

function post(data){
            $.ajax({
	  type: "POST",
	  enctype: 'multipart/form-data',
	  url: "<%= baseurl %>/edit.ashx",
	  data: data,
	  processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {

     
                console.log("SUCCESS : ", data);


            },
            error: function (e) {

                console.log("ERROR : ", e);
         

            }
	});
}
</script>

	