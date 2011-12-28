//how to use. input the id of the html select elements representing the month, day, year. and then the original value of month as a string.

function setDatePicker(monthId, dayId, yearId, dateMonth) {
    var monthSelect = document.getElementById(monthId);
    var yearSelect = document.getElementById(yearId);
    monthSelect.onchange = setDaysEvent;
    yearSelect.onchange = setDaysEvent;

    monthSelect.setAttribute("month-id", monthId);
    monthSelect.setAttribute("day-id", dayId);
    monthSelect.setAttribute("year-id", yearId);

    yearSelect.setAttribute("month-id", monthId);
    yearSelect.setAttribute("day-id", dayId);
    yearSelect.setAttribute("year-id", yearId);

    for (var i = 0; i < monthSelect.length; i++) {
        if (monthSelect.options.item(i).text == dateMonth) {
            monthSelect.selectedIndex = i;
            break;
        }
    }

    monthSelect.remove(12);

    setDays(monthId, dayId, yearId);

};

function setDaysEvent(event) {

    var dayId = event.currentTarget.getAttribute("day-id");
    var monthId = event.currentTarget.getAttribute("month-id");
    var yearId = event.currentTarget.getAttribute("year-id");

    setDays(monthId, dayId, yearId);
}

function setDays(monthId, dayId, yearId) {

    var daySelect = document.getElementById(dayId);
    var monthSelect = document.getElementById(monthId);
    var yearSelect = document.getElementById(yearId);

    var selectedYear = yearSelect.options.item(yearSelect.selectedIndex).value;


    var numDays;
    switch (monthSelect.selectedIndex) {
        case 0:
        case 2:
        case 4:
        case 7:
        case 9:
        case 11:
            numDays = 31;
            break;
        case 3:
        case 5:
        case 6:
        case 8:
        case 10:
            numDays = 30;
            break;
        default:
            if (selectedYear % 4 == 0 && (selectedYear % 100 != 0 || selectedYear % 400 == 0)) {
                numDays = 29;
            }
            else {
                numDays = 28;
            }
    }
    while (daySelect.length < numDays) {
        var option = document.createElement("option");
        option.text = (daySelect.length + 1);
        daySelect.add(option);
    }
    while (daySelect.length > numDays) {
        daySelect.remove(daySelect.length - 1);
    }

};