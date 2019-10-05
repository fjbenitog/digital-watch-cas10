using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class TimeDrawable extends WatchUi.Drawable {
	var font3;
	function initialize(options) {
	    Drawable.initialize(options);
	    font3 = WatchUi.loadResource(Rez.Fonts.id_font_digital_date);
	}
	    
	function draw(dc) {
		var dateTime = DateTimeBuilder.build();
        drawDate(dc, dateTime.getDay(), dateTime.getMonth(), dateTime.getDayOfWeek());
        drawYear(dc, dateTime.getYear());
	}
}