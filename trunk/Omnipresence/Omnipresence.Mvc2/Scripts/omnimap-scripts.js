var map;
var myLatlng;
var numMarkers = 0;
var markerArray = new Array();
var nodeMode = false;

function Node(marker) {
    this.title = "Katipunan Traffic";
    this.description = "Hello world!";
    this.comments = new Array();
    this.marker = marker;
    this.number = 0;
    this.infobox = null;
    this.position = marker.position;
}

function Comment(username) {
    this.username = username;
    this.content = "...";
}

function closeBoxes() {
    for (var i = 0; i < markerArray.length; i++) {
        var infobox = markerArray[i].infobox;
        if (infobox != null) {
            infobox.close();
        }
    };
}

function initialize() {
    myLatlng = new google.maps.LatLng(14.639064, 121.077758);
    var myOptions = {
        zoom: 16,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.HYBRID
    }

    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    google.maps.event.addListener(map, 'click', function (event) {
        addRandomMarker(event.latLng);
        closeBoxes();
    });

    // Create the DIV to hold the control and call the HomeControl() constructor
    // passing in this DIV.
    var homeControlDiv = document.createElement('DIV');
    var homeControl = new HomeControl(homeControlDiv, map);

    homeControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);
}

function loadScript() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
}

function addRandomMarker(latlng) {
    if (nodeMode) {
        var marker = new google.maps.Marker({
            position: latlng,
            title: "Hello World!",
            number: numMarkers
        });
        marker.setMap(map);
        markerArray[numMarkers] = new Node(marker);
        google.maps.event.addListener(marker, 'click', function () {

            closeBoxes();
            displayInfoWindow(marker.number);

        });
        numMarkers++;
        nodeMode = false;
    }
}

function modifyTextArea(markerNum) {
    alert(markerNum);
}

function displayInfoWindow(markerNum) {
    var contentString = '<div id = "content">'
                + '<p class="title">'
                + '<h1>' + markerArray[markerNum].title
                + '<button name="upvoteButton" type="button">++</button>'
                + '<button name="downvoteButton" type="buttom">--</button>'
                + '</h1>'
                + '</p>'

                + '<p class="position">'
                + '<strong>Location: </strong><br>'
                + markerArray[markerNum].position
                + '</p>'

				+ '<p class="description">'
                + '<strong>Description: </strong>'
				+ markerArray[markerNum].description
				+ '</p>'

				+ '<p class="editDescription">'
                + '<form name="edit' + markerNum + '" action="" >'
                + '<textarea id="edit">Enter new description</textarea> '
				+ '<input value ="Edit!" type="button" onclick="editDescription(' + markerNum + ', this.form)"/>'
                + '</form>'
                + '</p>'

				+ '<p> <strong>Comments</strong> </p>'

    for (var i = 0; i < markerArray[markerNum].comments.length; i++) {
        var comment = markerArray[markerNum].comments[i];
        contentString += "<p> <strong>" + comment.username + ": </strong>" + comment.content + "</p>";
    };

    contentString += '<p><form name="comment' + markerNum
				+ '" action="" > <textarea id="comment'
				+ '">Add new comment</textarea> '
				+ '<input value ="Comment!" type="button" onclick="addComment(' + markerNum
				+ ', this.form)"/></form></p>'

    contentString +=
				'<p><video width="300" height="250" controls="controls" autoplay="autoplay">'
				+ '<source src="http://upload.wikimedia.org/wikipedia/commons/9/9b/Pentagon_News_Sample.ogg" type="video/ogg" />'
				+ '</video></p>'
                +'</div>'


    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    infowindow.open(map, markerArray[markerNum].marker);

    markerArray[markerNum].infobox = infowindow;
}

function editDescription(markerNum, form) {
    markerArray[markerNum].description = form.edit.value;
    closeBoxes();
    return false;
}

function addComment(markerNum, form) {
    var comment = new Comment("Enzo");
    comment.content = form.comment.value;
    markerArray[markerNum].comments.push(comment);
    closeBoxes();
    return false;
}

window.onload = loadScript;

function HomeControl(controlDiv, map) {
    // Set CSS styles for the DIV containing the control
    // Setting padding to 5 px will offset the control
    // from the edge of the map
    controlDiv.style.padding = '5px';

    // Set CSS for the control border
    var controlUI = document.createElement('DIV');
    controlUI.style.backgroundColor = 'white';
    controlUI.style.borderStyle = 'solid';
    controlUI.style.borderWidth = '2px';
    controlUI.style.cursor = 'pointer';
    controlUI.style.textAlign = 'center';
    controlUI.title = 'Click to add a node';
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior
    var controlText = document.createElement('DIV');
    controlText.style.fontFamily = 'Arial,sans-serif';
    controlText.style.fontSize = '12px';
    controlText.style.paddingLeft = '4px';
    controlText.style.paddingRight = '4px';
    controlText.innerHTML = 'Add node';
    controlUI.appendChild(controlText);

    // Setup the click event listeners: simply set the map to Chicago
    google.maps.event.addDomListener(controlUI, 'click', function () {
        nodeMode = true;
    });
}

