using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class DateDrawableSmall extends WatchUi.Drawable {
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
        dc.drawText(dc.getWidth()-10, (dc.getHeight()/8), font3, yearStr, Gfx.TEXT_JUSTIFY_RIGHT |  Gfx.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawDate(dc, dayStr, monthStr, dayWeekStr){
        //Draw Date
        var yPosition = dc.getHeight()-(dc.getHeight()/8)  + 4;
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()-30, yPosition, font3, dayStr, Gfx.TEXT_JUSTIFY_RIGHT|  Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dc.getWidth()-62, yPosition, Gfx.FONT_SMALL, "-", Gfx.TEXT_JUSTIFY_RIGHT|  Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dc.getWidth()-70, yPosition, font3, monthStr, Gfx.TEXT_JUSTIFY_RIGHT|  Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText((dc.getWidth()-80)/2, yPosition, font3, dayWeekStr.toLower(), Gfx.TEXT_JUSTIFY_CENTER|  Gfx.TEXT_JUSTIFY_VCENTER);
    }
}