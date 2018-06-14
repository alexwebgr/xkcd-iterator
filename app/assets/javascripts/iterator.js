$(document).on('turbolinks:load', function () {
    var comicWrapper = $(".comicWrapper")[0];
    var mc = new Hammer(comicWrapper);

    mc.get('swipe').set({ direction: Hammer.DIRECTION_ALL });

    mc.on("swipeleft", function() {
        Turbolinks.visit($(".controls .next").attr("href"));
    });

    mc.on("swiperight", function() {
        Turbolinks.visit($(".controls .previous").attr("href"));
    });
});