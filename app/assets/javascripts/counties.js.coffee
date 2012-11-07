# CoffeeScript for individual County pages

# Modal with Reveal
$(document).ready ->
    $("#buttonForModal").click ->
        $("#myModal").reveal()
    $("#index-table").tablesorter()
    $("#show-table").tablesorter()
    $(".button").raptorize
        enterOn: "konami-code" #timer, konami-code, click