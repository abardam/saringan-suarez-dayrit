var map;
var myLatlng;
var numMarkers = 0;
var markerArray = new Array();
var nodeMode = false;

var currentOpenWindow; // div for holding the current open window
var eventTypeDiv; //div for holding the event type filter
var eventDateDiv; //div for holding the event date filter
var searchDiv;

var curEventType;

//this thing is for the event types
//each event has one type, with a unique icon for each
var TypeEnum = {
	disaster : "Disaster",
	traffic: "Traffic",
	party: "Party",
	talk: "Talk",
	none: "None"
}

function Node(marker) {
    this.title = "TITLE";
    this.description = "DESCRIPTION";
    this.comments = new Array();
    this.tags = new Array();
    this.marker = marker;
    this.number = 0;
    this.infobox = null;
    this.type = TypeEnum.none;
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
            infobox = null;
        }
    };
}

function initialize() {
    //myLatlng = new google.maps.LatLng(-25.363882, 131.044922);
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
    map.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(homeControlDiv);

    //formatting the window divs

    searchDiv = document.createElement('DIV');
    formatWindow(searchDiv, '<form action=""> <input type="text"></input> <input type="submit" value="Search" /> </form>');
    searchDiv.style.display = 'none';
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(searchDiv);
	
    eventTypeDiv = document.createElement('DIV');
    formatWindow(eventTypeDiv, '<button id="disasterType" onclick="eventTypeButtonClicked(this)">Disaster</button> <br> <button id="seminarType" onclick="eventTypeButtonClicked(this)">Seminar</button> <br> <button id="trafficType" onclick="eventTypeButtonClicked(this)">Traffic</button>');
    eventTypeDiv.style.display = 'none';
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(eventTypeDiv);

    eventDateDiv = document.createElement('DIV');
    formatWindow(eventDateDiv, '<a href="http://google.com">test</a>');
    eventDateDiv.style.display = 'none';
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(eventDateDiv);
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
        marker.setIcon(getEventIcon(curEventType));
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

    /*contentString += '<p><form name="comment" action="">'
    + '<textarea id="comment">Add new comment</textarea>'
    + '<input value ="Comment!" type="button" onclick="addComment(' + markerNum + ', this.form)"/>'
    + '</form></p>'*/

    contentString += '<p><form name="comment" action="/Home/About" method="post">'
                + '<textarea id="comment" name="comm">HARHAR</textarea> '
                + '<input type="hidden" name="markerNum" value="' + markerNum + '">'
				+ '<input type="submit"/>'
                + '</form></p>'

    contentString +=
				'<p><video width="300" height="250" controls="controls" autoplay="autoplay">'
				+ '<source src="http://upload.wikimedia.org/wikipedia/commons/9/9b/Pentagon_News_Sample.ogg" type="video/ogg" />'
				+ '</video></p>'
                + '</div>'


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

function openWindow(targetWindow) {
    if (currentOpenWindow != null) {
        if (currentOpenWindow != targetWindow) {
            currentOpenWindow.style.display = 'none';
        }
    }
    if (targetWindow.style.display == 'block') {
        targetWindow.style.display = 'none';
    }
    else {
        targetWindow.style.display = 'block';
        currentOpenWindow = targetWindow;
    }
}

window.onload = loadScript;

function HomeControl(controlDiv, map) {
    // Set CSS styles for the DIV containing the control
    // Setting padding to 5 px will offset the control
    // from the edge of the map
    controlDiv.style.padding = '5px';
    controlDiv.style.float = 'left';

    var controlUI;

    controlUI = document.createElement('DIV');
    formatButton(controlUI, 'Search for event', 'Find by name');
    controlDiv.appendChild(controlUI);

	google.maps.event.addDomListener(controlUI, 'click', function () {
        openWindow(searchDiv);
    });

    controlUI = document.createElement('DIV');
    formatButton(controlUI, 'Event date', 'Filter by date');
    controlDiv.appendChild(controlUI);

    google.maps.event.addDomListener(controlUI, 'click', function () {
        openWindow(eventDateDiv);
    });

    controlUI = document.createElement('DIV');
    formatButton(controlUI, 'Event type', 'Filter by type');
    controlDiv.appendChild(controlUI);

    google.maps.event.addDomListener(controlUI, 'click', function () {
        openWindow(eventTypeDiv);
    });


    controlUI = document.createElement('DIV');
    formatButton(controlUI, 'Post new event', 'Click to add a node');
    controlDiv.appendChild(controlUI);

    google.maps.event.addDomListener(controlUI, 'click', function () {
        nodeMode = true;
    });
}

// call this function on buttons para uniform yung style
function formatButton(controlUI, innerHtml, title) {
//    controlUI.style.backgroundColor = 'white';
//    controlUI.style.borderStyle = 'solid';
//    controlUI.style.borderWidth = '2px';
//    controlUI.style.cursor = 'pointer';
//    controlUI.style.textAlign = 'center';
//    controlUI.style.margin = '5px';
//    controlUI.style.marginBottom = '10px';
    //    controlUI.style.float = 'left';
    controlUI.className = "controlButton";
    controlUI.title = title;
    // Set CSS for the control interior
    var controlText = document.createElement('DIV');
//    controlText.style.fontFamily = 'Arial,sans-serif';
//    controlText.style.fontSize = '12px';
//    controlText.style.paddingLeft = '4px';
    //    controlText.style.paddingRight = '4px';
    controlText.className = "controlText";
    controlText.innerHTML = innerHtml;
    controlUI.appendChild(controlText);
}

//call this function on windows para uniform yung style
function formatWindow(controlUI, innerHtml) {
//    controlUI.style.backgroundColor = 'white';
//    controlUI.style.borderStyle = 'solid';
//    controlUI.style.borderWidth = '2px';
//    controlUI.style.cursor = 'pointer';
//    controlUI.style.textAlign = 'center';
//    controlUI.style.margin = '50px';
//        controlUI.style.padding = '10px';
    controlUI.className = "controlWindow";
    // Set CSS for the control interior
    var controlText = document.createElement('DIV');
//    controlText.style.fontFamily = 'Arial,sans-serif';
//    controlText.style.fontSize = '12px';
//    controlText.style.paddingLeft = '4px';
    //    controlText.style.paddingRight = '4px';
    controlText.className = "controlText";
    controlText.innerHTML = innerHtml;
    controlUI.appendChild(controlText);
}

function eventTypeButtonClicked(sender) {
    switch (sender.id)
    {
        case "disasterType":
            curEventType = TypeEnum.disaster;
            break;
        case "seminarType":
            curEventType = TypeEnum.talk;
            break;
        case "trafficType":
            curEventType = TypeEnum.traffic;
            break;
        default:
            break;
    }
}

function getEventIcon(eventType) {
    switch (eventType) {
        case TypeEnum.disaster:
            return "/Content/Images/disaster.png";
        case TypeEnum.talk:
            return "/Content/Images/talk.png";
        case TypeEnum.traffic:
            return "/Content/Images/traffic.png";
        default:
            return "/Content/Images/circle.png";
            break;
    }
}