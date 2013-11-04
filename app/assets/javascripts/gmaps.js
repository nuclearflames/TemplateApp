$(function () {
    var map, mapOptions;
    function gMap() {
        mapOptions = {
          center: new google.maps.LatLng(-34.397, 150.644),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        },
        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    }
    google.maps.event.addDomListener(window, 'load', gMap);

    var locationsMap, locationsMapOptions, locationsMarkers = [], data;
    function gMap() {

        $.ajax({
            url: "search.xml",
            success: function (result) {
                data = result;
            }
        });
        locationsMapOptions = {
          center: new google.maps.LatLng(-34.397, 150.644),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        },

        locationsMap = new google.maps.Map(document.getElementById("locations-map"), locationsMapOptions);

        for (var i = 0; data.length; i++) {
            if (data[i].latlng) {
                var marker = newgoogle.maps.Marker({
                    position: data[i].latlng,
                    map: locationsMap,
                    title: data[i].alias
                });
                locationsMarkers.add(marker);
            }
        }
    }
    google.maps.event.addDomListener(window, 'load', locationsMap);

});