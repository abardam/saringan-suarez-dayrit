function initialize() {
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
var mainMarker;
window.onload = loadScript;

function setMap2(divName, latLng, isNew, all, title, category) {
    var myOptions = {
        zoom: 16,
        center: latLng,
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    

    map = new google.maps.Map(document.getElementById(divName), myOptions);


    if (!all) {
        if (!isNew) {
            mainMarker = addMarker(latLng, title, category);

        }
        else {
            google.maps.event.addListener(map, 'click', function (event) {
                if (mainMarker != null) {
                    mainMarker.setMap(null);
                }
                mainMarker = addMarker(event.latLng, "new", "newevent");

                document.getElementById("Latitude").value = event.latLng.lat();
                document.getElementById("Longitude").value = event.latLng.lng();
            });
        }
    }


    /*
    var logoDiv = document.createElement('DIV');
    formatLogo(logoDiv, '<img src="../../Content/Images/omnilogo.png" />');
    logoDiv.index = 1;
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(logoDiv);*/

}

function setMap(divName, title, category) {


    if(!title)
        title = "hello";
    if(!category)
        category = "party";



    var mapDiv = $("div#" + divName);
    var lat = mapDiv.attr("data-lat");
    var lng = mapDiv.attr("data-lng");
    var latlng = new google.maps.LatLng(lat, lng);

    var isNew = mapDiv.attr("new") == "true" || mapDiv.attr("new") != null;
    var all = mapDiv.attr("all") != null;

    setMap2(divName, latlng, isNew, all, title, category);
}
function getEventIcon(eventType) {
    return "/Content/Images/" + eventType + ".png";
}

function addClickableMarker(latlng, title, eventId, category) {

    if (!category)
        category = "party";
    var tempMarker = addMarker(latlng, title, category);

    google.maps.event.addListener(tempMarker, 'click', function () {
        goEvent(eventId);
    });

    return tempMarker;
}

function mapPanTo(latlng) {
    map.panTo(latlng);
}

function addMarker(latlng, title, category) {


    if(!category)
        category = "party";

        var marker = new google.maps.Marker({
            position: latlng,
            title: title
        });

        marker.setMap(map);
        marker.setIcon(getEventIcon(category));
        /*google.maps.event.addListener(marker, 'click', function () {

            //closeBoxes();
            //displayInfoWindow(marker.number);
            currentMarker = marker.number;
            //updateRightPanel(markerArray[marker.number]);
            //showNewEvent();

        });*/
        //showNewEvent();
        return marker;
}