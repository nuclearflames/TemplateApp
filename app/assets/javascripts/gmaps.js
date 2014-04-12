$(function () {
    var
        locationsMarkers = {},
        locationsMap,
        far,
        distanceCircle,
        userLat = parseFloat($("#lat").text()),
        userLng = parseFloat($("#lng").text()),
        mapCenter = new google.maps.LatLng(51.5, -0.10),

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

        initalizeMap = function (location, complete) {
            var
                locationsMapOptions = {
                    center: mapCenter,
                    zoom: 8,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                locationsMap = new google.maps.Map(location, locationsMapOptions);

            google.maps.event.addDomListener(window, 'load', locationsMap);
            complete();
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

        fetchJsonRenderData = function () {
            this.data;
            $.ajax({
                url: "/search.json",
                success: function (result) {
                    this.data = result;
                },
                complete: function () {
                    fillMapIndex(this.data);
                    reloadUserProfiles();
                }
            });
        },

        fillMapIndex = function (data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].location.lat != "" && data[i].location.lng != "") {
                    if (far != null) {
                        createDistanceCircle();
                        calculateDistanceFromMarker(data[i], function(distance) {
                            if (distance <= far) {
                                locationsMarkers[data[i].alias].setVisible(true);
                            } else {
                                locationsMarkers[data[i].alias].setVisible(false);
                            }
                        });
                    } else {
                        //Runs on first load, adds all known markers
                        var marker = new google.maps.Marker({
                            position: new google.maps.LatLng(data[i].location.lat, data[i].location.lng),
                            map: locationsMap,
                            title: data[i].alias
                        });
                        locationsMarkers[data[i].alias] = marker;
                    }
                }
            }
        },

        createDistanceCircle = function () {
            //Clear old circle
            if (distanceCircle != null) {
                distanceCircle.setRadius(far * 1000);
                return;
            }
            var
                circleStyle = {
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: '#FF0000',
                    fillOpacity: 0.35,
                    center:  new google.maps.LatLng(userLat, userLng),
                    radius: far * 1000 //convert distance to km
                };

            distanceCircle = new google.maps.Circle(circleStyle);
            distanceCircle.setMap(locationsMap);

        },

        convertToRadians = function (degrees) {
            return degrees * (Math.PI/180);
        },

        calculateDistanceFromMarker = function (data, callback) {
            this.withinBounds = false;
            //Will calculate the distance between the markers and determine if they are within the distances specified
            var Radius = 6371,
                lat1 = data.location.lat,
                lng1 = data.location.lng,

                dLat = convertToRadians(lat1-userLat),
                dLon = convertToRadians(lng1-userLng),
                lat1 = convertToRadians(lat1),
                lat2 = convertToRadians(userLat);

                a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                    Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2),
                c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)),
                d = Radius * c;

                console.log(d);

            callback(d);
        },

        sliderMapRefresh = function (slider) {
            far = $("#far-distance").text($(slider).slider("values", 1)).text();

            fetchJsonRenderData();
        },

        generateRangeSlider = function (id) {
            $(id).slider({
                range: "min",
                value: 50,
                min: 0,
                max: 100,
                step: 1,
                stop: function () {
                    sliderMapRefresh($(".slider"));
                }
            });
        },

        profileTemplate = [
        "<div class=\"col-sm-3 index-wrapper\" id=\"<%= data.alias %>\">",
            "<div class=\"row\">",
                "<div class=\"col-sm-12 locationOverlayText\">",
                    "<h4><a href=\"/<%= data.alias %>\"><%= data.alias %></a></h4>",
                "</div>",
            "</div>",
            "<div class=\"row\">",
                "<div class=\"col-sm-12\">",
                    "<img alt=\"profile-image\" src=\"<%= data.avatar_url_thumb %>\">",
                "</div>",
            "</div>",
        "</div>"].join("\n"),

        //Sort function for the JSON array
        sortByKey = function (array, key) {
            return array.sort(function(a, b) {
                var x = a[key]; var y = b[key];
                return ((x < y) ? -1 : ((x > y) ? 1 : 0));
            });
        },
        
        reloadUserProfiles = function () {
            this.data;
            var url = "/search.json?";
            this.i = 1;
            for(var marker in locationsMarkers) {
                if (locationsMarkers[marker].visible != false) {
                    url += "&alias" + i + "=" + marker;
                    this.i++;
                }
            }

            $.ajax({
                url: url,
                success: function (result) {
                    this.data = result;
                },
                complete: function () {
                    $("#users").empty();
                    for(var key in this.data) {
                        $("#users").append(_.template(profileTemplate, this.data[key], {variable: "data"}));
                    }
                }
            });
        },

        init = function () {
            if ($(".maps").length) {
                initalizeMap($(".maps")[0], function () {
                    if ($("#locations-map-index").length) {
                        mapCenter = new google.maps.LatLng(userLat, userLng);
                        fetchJsonRenderData();
                        generateRangeSlider($("#distance-slider"));
                    }
                    if ($("#locations-map-new").length) {
                        gMapNew();
                    }
                });
            }
        };

    init: init();
});