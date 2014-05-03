$(function () {
    var 

        profileAccordian = function () {
            var accord = $(".profile-accordian");
            accord.accordion({
                heightStyle: "content",
                collapsible: true
            });
        },
        imageSlider = function () {
            $("#image-slider-profile").slidesjs({
                width: 225,
                height: 300,
                pagination: {
                    active: false
                }
            });
        },
        responsiveMenu = function () {
            $("#menu-button").click(function (i) {
                var val = $("#sidebar"),
                    cont = $("#content");
                i.preventDefault();
                if ($("#sidebar.sidebar-visible").length) {
                    val.removeClass("sidebar-visible");
                    cont.removeClass("sidebar-visible");
                } else {
                    val.addClass("sidebar-visible");
                    cont.addClass("sidebar-visible");
                }
            });
        },
        //The start page is 2 as the default is set to 1
        scrollPagePointer = 2
        infiniteScroll = function () {
            if ($("#news-index-scroller").length && $("#news-index-scroller").visible() == true) {
                var loopLimit = 20,
                    data;
                for (i=scrollPagePointer; i < loopLimit; i++) {
                    $.ajax({
                        url: "/news?page=" + i,
                        async: false,
                        success: function (result) {
                            data = result;
                            data = $(data).find(".news-object");
                            //Loading spinner                      
                            $("#news-wrapper").append("<i class=\"fa fa-spinner\"></i>");
                            //Append the news
                            $("#news-wrapper").append(data);
                            //Remove the load spinner
                            $("#news-wrapper").find(".fa-spinner").remove();
                        },
                        complete: function () {
                            scrollPagePointer++;
                            if (data.length == 0 || $("#news-index-scroller").visible() == false) {
                                i = loopLimit;
                            }
                        }
                    });
                }
            }
        },

        init = function() {
            $(window).load(function () {
                infiniteScroll();
                responsiveMenu();
                imageSlider();
                profileAccordian();
            });
            $(window).resize(function () {
                infiniteScroll();
            });
            $(window).scroll(function () {
                infiniteScroll();
            });
        };

    init:init();
});