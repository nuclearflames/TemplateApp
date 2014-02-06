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
    var 
        //The start page is 2 as the default is set to 1
        scrollPagePointer = 2
        infiniteScroll = function () {
            if ($("#news-index-scroller").length && $("#news-index-scroller").visible() == true) {
                for (i=scrollPagePointer; i < 20; i++) {
                    var data;
                    $.ajax({
                        url: "/news?page=" + i,
                        success: function (result) {
                            data = result;
                            data = $(data).find(".news-object");
                            $("#news-wrapper").append($(data));
                        },
                        complete: function () {
                            scrollPagePointer++;
                            console.log(data);
                        }
                    });
                    if ($(data).length == 0 || $("#news-index-scroller").visible() == false) {
                        break;
                    }
                }
            }
        },

    init = function() {
        $(window).load(function () {
            infiniteScroll();
        });
        $(window).resize(function () {
            infiniteScroll();
        });
        $(window).scroll(function () {
            infiniteScroll();
        });
    };

    init();
});