$(function () {
    $("#image-slider-profile").slidesjs({
        width: 225,
        height: 300,
        pagination: {
            active: false
        }
    });
    $("#sidebar").find(".menu").click(function (i) {
        var val = $("#sidebar");
        i.preventDefault();
        if ($("#sidebar.visible").length) {
            val.removeClass("visible");
        } else {
            val.addClass("visible");
        }
    });
});