function clearMarkers() {
	for(i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers.length = 0;
}

function resizeMap() {
	var top = $('#map_canvas').offset().top;
	var height = $(window).height();
	$('#map_canvas').height(height - top - 10);
}

function realReloadData(url) {
	clearMarkers();
	$.getJSON(url, function(data) {
		var bounds = new google.maps.LatLngBounds();
		for(i = 0; i < data.length; i++) {
			var latLng = new google.maps.LatLng(data[i]['latitude'], data[i]['longitude']);
			var marker = new google.maps.Marker({ position: latLng, map: map, title: data[i]['dt'] });
			markers.push(marker);
			bounds.extend(latLng);
		}
		if(markers.length > 0) {
			map.fitBounds(bounds);
		}
	});
}

var map;
var markers = [];

$(function() {
	var mapOptions = {
		center: new google.maps.LatLng(0, 0),
		zoom: 3,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

	$('select').change(function() { reloadData(); });
	$('#btnGo').click(function() { reloadData(); });
	$('#btnShow').click(function() { reloadData(); });
	$(window).resize(function() { resizeMap(); });
	resizeMap();
});
