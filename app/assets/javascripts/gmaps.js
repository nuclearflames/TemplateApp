$(function () {
    var
        locationsMarkers = [],
        locationsMap,
        mapCenter = new google.maps.LatLng(51.62, -0.3),

        geoCodeFromLatLng = function (latlng) {
            var
                geoCoder = new google.maps.Geocoder();

            geoCoder.geocode({'latLng': latlng}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    $("#location_lat").val(latlng.lat());
                    $("#location_lng").val(latlng.lng());
                    for (var i = 0; i < results.length; i++) {
                        for (var j = 0; j < results[i].types.length; j++) {
                            if (results[i].types[j].toString() === "postal_code") {
                                $("#location_postcode").val(results[i].formatted_address);
                            }
                            if (results[i].types[j].toString() === "political") {
                                $("#location_country").val(results[i].formatted_address);
                            }
                            if (results[i].types[j].toString() === "administrative_area_level_2") {
                                $("#location_city").val(results[i].formatted_address);
                            }
                            if (results[i].types[j].toString() === "administrative_area_level_3") {
                                $("#location_town").val(results[i].formatted_address);
                            }
                            if (results[i].types[j].toString() === "street_address") {
                                $("#location_street").val(results[i].formatted_address);
                            }
                        }
                    }
                }
            });
        },

        initalizeMap = function (location, callback) {
            var
                locationsMapOptions = {
                    center: mapCenter,
                    zoom: 8,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                locationsMap = new google.maps.Map(location, locationsMapOptions);

            google.maps.event.addDomListener(window, 'load', locationsMap);
            callback();
        },

        gMapIndex = function () {
            this.data;
            $.ajax({
                url: "/search.json",
                success: function (result) {
                    this.data = result;
                },
                complete: function () {
                    fillMapIndex(this.data);
                }
            });
        },

        fillMapIndex = function (data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].location.lat != "") {
                    var marker = new google.maps.Marker({
                        position: new google.maps.LatLng(data[i].location.lat, data[i].location.lng),
                        map: locationsMap,
                        title: data[i].alias
                    });
                    locationsMarkers.push(marker);
                }
            }
        },

        gMapNew = function () {

            var marker = new google.maps.Marker({
                    position: mapCenter,
                    map: locationsMap,
                    title: "Set Me at your location",
                    draggable: true
                });
            google.maps.event.addListener(marker, 'dragend', function () { geoCodeFromLatLng(marker.position) });
        },


        sliderhMapRefresh = function (slider) {
            $("#near-distance").text($(slider).slider("values", 0));
            $("#far-distance").text($(slider).slider("values", 1));
        },

        generateRangeSlider = function (id) {

            $(id).slider({
                range: true,
                min: 0,
                max: 50,
                step: 1,
                values: [ 0, 50 ],
                slide: function () {
                    gMapIndex();
                    sliderhMapRefresh($(".slider"));
                }
            });
        },



        init = function () {
            if ($(".maps").length) {
                initalizeMap($(".maps")[0], function () {
                    if ($("#locations-map-index").length) {
                        gMapIndex();
                        if ($(".slider").length) {
                            if($("#distance-slider").length) {
                                generateRangeSlider($("#distance-slider"));
                            }
                        }
                    }
                    if ($("#locations-map-new").length) {
                        gMapNew();
                    }
                });
            }
        };

    init: init();
});