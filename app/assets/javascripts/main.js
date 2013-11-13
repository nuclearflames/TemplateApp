$(function () {
    $("#image-slider-profile").slidesjs({
        width: 225,
        height: 300,
        pagination: {
            active: false
        }
    });
    $(".main-sidebar").find(".menu").click(function (i) {
        var val = $(".main-sidebar");
        i.preventDefault();
        if ($(".main-sidebar.visible").length) {
            val.removeClass("visible");
        } else {
            val.addClass("visible");
        }
    });
});