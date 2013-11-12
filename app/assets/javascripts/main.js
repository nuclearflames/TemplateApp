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
            $(".sidebar div").hide();
        } else {
            $(".sidebar").addClass("visible");
            $(".sidebar div").show();
        }
    });
});