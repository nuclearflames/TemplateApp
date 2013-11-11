$(function () {
    $("#image-slider-profile").slidesjs({
        width: 225,
        height: 300,
        pagination: {
            active: false
        }
    });
    $(".sidebar .menu").click(function (i) {
        i.preventDefault();
        if ($(".sidebar.visible").length) {
            $(".sidebar").removeClass("visible");
            $(".sidebar .col-sm-2").hide();
        } else {
            $(".sidebar").addClass("visible");
            $(".sidebar .col-sm-2").show();
        }
    });
});