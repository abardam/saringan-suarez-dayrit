$('#home-default').live('click', function (evt) {
    sidebarChange("Default");
});

$('#home-new-event').live('click', function (evt) {
    sidebarChange("NewEvent");
});

function sidebarChange(partial) {
    $('#sidebar').fadeOut(200, function () {
        $.get('/Home/RenderPartial?name=' + partial, function (data) {
            $('#sidebar').html(data);
            $('#sidebar').fadeIn(200);
        });
    });
}