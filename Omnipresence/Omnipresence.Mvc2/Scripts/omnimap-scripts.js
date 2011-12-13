// Leland Code to integrate Sidebar
function eventInfo_reset() {
}

function eventInfo_newEvent(eventinfo) {
    $('#event_name').text(eventinfo.title);
    $('#event_location').text("" + eventinfo.position);
    $('#event_description').text(eventinfo.description);
    $('#sel_type').val(eventinfo.type);
}

function eventInfo_error(headline, errormsg, otherinformation) {
}

function eventInfo_toggleFunction() {
}

﻿// Leland Code to integrate Sidebar
function eventInfo_reset() {
}

function eventInfo_newEvent(eventinfo) {
}

function eventInfo_error(headline, errormsg, otherinformation) {
}

function eventInfo_toggleFunction() {
}

//Jay New Code
$(document).ready(
    function () {
        $('.toggle').toggle();
        $('#changeEventTypeButton').click(
            function () { changeEventTypeButtonClicked(); }
        );

        $('#editDescriptionTextArea').focusin(
            function (event) {
                textAreaFocusIn($(event.target));
            }
        );

        $('#editDescriptionTextArea').focusout(
            function (event) {
                textAreaFocusOut($(event.target), "Enter new description");
            }
        );

        $('#commentTextArea').focusin(
            function (event) {
                textAreaFocusIn($(event.target));
            }
        );

        $('#commentTextArea').focusout(
            function (event) {
                textAreaFocusOut($(event.target), "Enter new comment");
            }
        );

        $('.edit').editable('http://www.example.com/save.php', {
            indicator: 'Saving...',
            tooltip: 'Click to edit...'
        });
        $('.edit_area').editable('http://www.example.com/save.php', {
            type: 'textarea',
            cancel: 'Cancel',
            submit: 'OK',
            indicator: '<img src="img/indicator.gif">',
            tooltip: 'Click to edit...'
        });

        for (value in TypeEnum) {
            var newOpt = document.createElement("option");
            newOpt.value = TypeEnum[value];
            newOpt.text = TypeEnum[value];

            $('#sel_type').append(newOpt);
        }

        $('#sel_type').change(function (event) {
            changeType(currentMarker, $("#sel_type option:selected").val());
        }
        ).change();


        //resize

        //alert('alert');
        var    dheight = $('html').height(),
            cbody = $('#contentbody').height(),
            wheight = $(window).height(),
            cheight = wheight - dheight + cbody;
            
        if (wheight > dheight){
            $('#contentbody').height(cheight);
        }
        
        $(window).resize(function(){
            wheight = $(window).height();
            noscroll();
            changepush();
        });

        function noscroll(){
           if (wheight > dheight) {
                $('html').addClass('noscroll');
           }

            else if (wheight <= dheight) {
                $('html').removeClass('noscroll');
            }
            
            else {}

        }

        function changepush(){
           if (wheight > dheight) {
                   $('#contentbody').height(wheight-dheight+cbody);
           }
            
        }

    }
);



function textAreaFocusIn(textArea) {
    textArea.text('');
}

function textAreaFocusOut(textArea, what) {
    if (textArea.text() == '') {
        textArea.text(what);
    }
}

function changeEventTypeButtonClicked() {
    alert("haha");
}

//Enzo Original Code
var map;
var myLatlng;
var numMarkers = 0;
var markerArray = new Array();
var nodeMode = false;
var currentMarker;

var currentOpenWindow; // div for holding the current open window
var eventTypeDiv; //div for holding the event type filter
var eventDateDiv; //div for holding the event date filter
var searchDiv;

//this thing is for the event types
//each event has one type, with a unique icon for each
var TypeEnum = {
    disaster: "Disaster",
    traffic: "Traffic",
    party: "Party",
    talk: "Talk",
    none: "None"
}

var curEventType = TypeEnum.none;

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

function setNodeMode(n){
    nodeMode = n;
}

function commentToHTML(comment) {
    return "<p> <strong>" + comment.username + ": </strong>" + comment.content + "</p>";
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

function initialize(){
    alert("hello!");
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
        markerArray[numMarkers].type = curEventType;
        google.maps.event.addListener(marker, 'click', function () {

            //closeBoxes();
            //displayInfoWindow(marker.number);
            currentMarker = marker.number;
            //updateRightPanel(markerArray[marker.number]);
            //showNewEvent();

        });
        numMarkers++;
        nodeMode = false;
        showNewEvent();
    }
}

function modifyTextArea(markerNum) {
    alert(markerNum);
}

function updateRightPanel(node) {
    eventInfo_newEvent(node);
}

function displayInfoWindow(markerNum) {
    //currentMarker = markerNum;
    //eventInfo_newEvent(markerArray[markerNum]);
    /*
    var contentString = '<div id = "content">'
    + '<p class="title">'
    + '<h1>' + markerArray[markerNum].title
    + '<button id="upVote" name="upvoteButton" type="button">++</button>'
    + '<button name="downvoteButton" type="buttom">--</button>'
    + '</h1>'
    + '</p>'

    + '<p class="position">'
    + '<strong>Location: </strong><br>'
    + markerArray[markerNum].position
    + '</p>'

    + '<div id="type_selector">'
    + '<form name="edit_type">'
    + '<select name="sel_type">'

    for (value in TypeEnum) {
    contentString += '<option '


    if (markerArray[markerNum].type == TypeEnum[value]) {
    contentString += 'selected '
    }

    contentString += 'value="' + value +'">' + TypeEnum[value]

    }

    contentString += '</select>'
    + '<input type="button" value="Change" onClick="changeType(' + markerNum + ', this.form)">';
    + '</form>'
    + '</div>'

    contentString += '<p class="description">'
    + '<strong>Description: </strong>'
    + '<div id="description">'
    + markerArray[markerNum].description
    + '</div>'
    + '</p>'

    + '<p class="editDescription">'
    + '<form name="edit' + markerNum + '" action="" >'
    + '<textarea id="edit">Enter new description</textarea> '
    + '<input value ="Edit!" type="button" onclick="editDescription(' + markerNum + ', this.form)"/>'
    + '</form>'
    + '</p>'

    + '<div> <strong>Comments</strong> </div>'
    + '<div id="comments">'
    for (var i = 0; i < markerArray[markerNum].comments.length; i++) {
    var comment = markerArray[markerNum].comments[i];
    contentString += commentToHTML(comment);
    };

    contentString += '</div>'

    contentString += '<p><form name="comment" action="">'
    + '<textarea id="comment">Add new comment</textarea>'
    + '<input value ="Comment!" type="button" onclick="addComment(' + markerNum + ', this.form)"/>'
    + '</form></p>'

    /*contentString += '<p><form name="comment" action="/Home/About" method="post">'
    + '<textarea id="comment" name="comm">HARHAR</textarea> '
    + '<input type="hidden" name="markerNum" value="' + markerNum + '">'
    + '<input type="submit"/>'
    + '</form></p>'*/

    /*contentString +=
    '<p><video width="300" height="250" controls="controls" autoplay="autoplay">'
    + '<source src="http://upload.wikimedia.org/wikipedia/commons/9/9b/Pentagon_News_Sample.ogg" type="video/ogg" />'
    + '</video></p>'
    + '</div>'*/

    /*
    var infowindow = new google.maps.InfoWindow({
    content: contentString
    });

    infowindow.open(map, markerArray[markerNum].marker);

    markerArray[markerNum].infobox = infowindow;

    $('#comment').focus(
    function focused() {
    alert("adsg");
    this.text = "";
    }
    );

    $('#upVote').click(
    function clicked() {
    alert("hahahaha");
    }
    );*/
}


function editDescription(markerNum, form) {
    markerArray[markerNum].description = form.edit.value;
    $('#description').html(form.edit.value);
    return false;
}

function addComment(markerNum, form) {
    var comment = new Comment("Enzo");
    comment.content = form.comment.value;
    markerArray[markerNum].comments.push(comment);
    $('#comments').append(commentToHTML(comment));
    return false;
}

function changeType(markerNum, newValue) {
    markerArray[markerNum].type = newValue;  /*form.sel_type.options[form.sel_type.selectedIndex].value;*/
    markerArray[markerNum].marker.setIcon(getEventIcon(markerArray[markerNum].type));
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
    //var controlText = document.createElement('DIV');
    //    controlText.style.fontFamily = 'Arial,sans-serif';
    //    controlText.style.fontSize = '12px';
    //    controlText.style.paddingLeft = '4px';
    //    controlText.style.paddingRight = '4px';
    //controlText.className = "controlText";
    //controlText.innerHTML = innerHtml;
    //controlUI.appendChild(controlText);
    var controlButton = document.createElement('A');
    controlButton.className="button";
    
    var controlSpan = document.createElement('SPAN');
    controlSpan.innerHTML = innerHtml;
    controlButton.appendChild(controlSpan);
    controlUI.appendChild(controlButton);
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

function formatLogo(controlUI, innerHtml) {
    controlUI.className = "controlLogo";
    var controlText = document.createElement('DIV');
    controlText.className = "controlText";
    controlText.innerHTML = innerHtml;
    controlUI.appendChild(controlText);
}

function eventTypeButtonClicked(sender) {
    /*switch (sender.id)
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
    }*/

    curEventType = TypeEnum[sender.id];
}

function getEventIcon(eventType) {
    /*switch (eventType) {
    case TypeEnum.disaster:
    return "/Content/Images/disaster.png";
    case TypeEnum.talk:
    return "/Content/Images/talk.png";
    case TypeEnum.traffic:
    return "/Content/Images/traffic.png";
    default:
    return "/Content/Images/circle.png";
    break;
    }*/
    return "/Content/Images/" + eventType + ".png";
}
/*
function panTo(latLng){
    map.panTo(latLng);
}*/
function setMap(divName, latLng) {
    var myOptions = {
        zoom: 16,
        center: latLng,
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    if(map != null){
        delete map;
    }

    map = new google.maps.Map(document.getElementById(divName), myOptions);
    
    var logoDiv = document.createElement('DIV');
    formatLogo(logoDiv,'<img src="../../Content/Images/omnilogo.png" />');
    logoDiv.index=1;
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(logoDiv);

}
function setMapDiv(divName) {
    alert(divName);
    var lat = $("div#"+divName).attr("data-lat");
    var lng = $("div#"+divName).attr("data-lng");
    var latlng = new google.maps.LatLng(lat, lng);
    setMap(divName, latlng);
};