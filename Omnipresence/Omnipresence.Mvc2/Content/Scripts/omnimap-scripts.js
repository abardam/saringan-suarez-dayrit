﻿function initialize() {
     realInitialize();
}

function loadScript() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
}

function formatLogo(controlUI, innerHtml) {
    controlUI.className = "controlLogo";
    var controlText = document.createElement('DIV');
    controlText.className = "controlText";
    controlText.innerHTML = innerHtml;
    controlUI.appendChild(controlText);
}
var map;
window.onload = loadScript;

function setMap2(divName, latLng) {
    var myOptions = {
        zoom: 16,
        center: latLng,
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    

    map = new google.maps.Map(document.getElementById(divName), myOptions);

    addMarker(latLng);
    /*
    var logoDiv = document.createElement('DIV');
    formatLogo(logoDiv, '<img src="../../Content/Images/omnilogo.png" />');
    logoDiv.index = 1;
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(logoDiv);*/

}

function setMap(divName) {
    var lat = $("div#" + divName).attr("data-lat");
    var lng = $("div#" + divName).attr("data-lng");
    var latlng = new google.maps.LatLng(lat, lng);
    setMap2(divName, latlng);
}
function getEventIcon(eventType) {
    return "/Content/Images/" + eventType + ".png";
}

function addMarker(latlng) {
        var marker = new google.maps.Marker({
            position: latlng,
            title: "Hello World!"
        });

        marker.setMap(map);
        marker.setIcon(getEventIcon("party"));
        /*google.maps.event.addListener(marker, 'click', function () {

            //closeBoxes();
            //displayInfoWindow(marker.number);
            currentMarker = marker.number;
            //updateRightPanel(markerArray[marker.number]);
            //showNewEvent();

        });*/
        //showNewEvent();
}