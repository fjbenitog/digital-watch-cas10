using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class DateDrawable extends WatchUi.Drawable {
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
	
	 function drawYear(dc,yearStr){
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()-40, (dc.getHeight()/6), font3, yearStr, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    function drawDate(dc, dayStr, monthStr, dayWeekStr){
        //Draw Date
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()-30, 4*(dc.getHeight()/6)+6, font3, dayStr, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()-62, 4*(dc.getHeight()/6)+8, Gfx.FONT_SMALL, "-", Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()-70, 4*(dc.getHeight()/6)+6, font3, monthStr, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText((dc.getWidth()-80)/2, 4*(dc.getHeight()/6)+6, font3, dayWeekStr.toLower(), Gfx.TEXT_JUSTIFY_CENTER);
    }
}