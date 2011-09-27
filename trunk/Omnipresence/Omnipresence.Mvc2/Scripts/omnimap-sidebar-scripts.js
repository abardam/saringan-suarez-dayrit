//$('#home-default').live('click', function (evt) {
//    sidebarChange("Default");
//});

//$('#home-new-event').live('click', function (evt) {
//    sidebarChange("NewEvent");
//});

//function sidebarChange(partial) {
//    $('#sidebar').fadeOut(200, function () {
//        $.get('/Home/RenderPartial?name=' + partial, function (data) {
//            $('#sidebar').html(data);
//            $('#sidebar').fadeIn(200);
//        });
//    });
//}
function sideShow(d) { sideShowNew(d, null) }
function sideShowNew(d, func) {
    $('#sidebar-big').css({
        'background-image': 'url(\'/Content/Images/loading-gif.gif\')',
        'background-position': 'center',
        'background-repeat': 'no-repeat'
    });
    $("#sidebar").fadeOut(200, function () {
        $('#sidebar').html(d);
        $('#sidebar').fadeIn(200, func);
        $('#sidebar-big').css({
            'background-image': 'none',
            'background-position ': 'center',
            'background-repeat': 'no-repeat'
        });
    });
}
$('.sidebar-link,.control-container a').live("click", function (event) {
    event.preventDefault();
    $.get(event.currentTarget, function (d) {
        sideShow(d);
    });
});
$('.sidebar-button').live('click', function (event) {
    event.preventDefault();
    setNodeMode(true);
    $('.sidebar-button>img').removeClass('selected').addClass('unselected');
    $(this).children('img').removeClass('unselected').addClass('selected');
    //    $('img.selected').css('display', 'none');
    //    $('img.unselected').css('display', 'inline');

    //    jQuery('img.unselected', this).css('display', 'none');
    //    jQuery('img.selected', this).css('display', 'inline');

});
$('.helper').css('display', 'none');