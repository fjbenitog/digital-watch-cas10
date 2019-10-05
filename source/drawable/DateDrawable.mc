using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class DateDrawable extends WatchUi.Drawable {
	var font3;
	private var height = System.getDeviceSettings().screenHeight;
	private var width = System.getDeviceSettings().screenWidth;
	var yearX = width-40;
	var yearY = (height/6);
	var dateY = 4*(height/6)+6;
	var dateX = width-30;
	function initialize(options) {
	    Drawable.initialize(options);
	    font3 = WatchUi.loadResource(Rez.Fonts.id_font_digital_date);
	    var yearX_ = options.get(:yearX);
        if(yearX_ != null) {
            yearX = yearX_;
        }
        var yearY_ = options.get(:yearY);
        if(yearY_ != null) {
            yearY = yearY_;
        }
        var dateY_ = options.get(:dateY);
        if(dateY_ != null) {
            dateY = dateY_;
        }
        var dateX_ = options.get(:dateX);
        if(dateX_ != null) {
            dateX = dateX_;
        }
	}
	    
	function draw(dc) {
		var dateTime = DateTimeBuilder.build();
        drawDate(dc, dateTime.getDay(), dateTime.getMonth(), dateTime.getDayOfWeek());
        drawYear(dc, dateTime.getYear());
	}
	
	 function drawYear(dc,yearStr){
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(yearX, yearY, font3, yearStr, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    function drawDate(dc, dayStr, monthStr, dayWeekStr){
        //Draw Date
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dateX, dateY, font3, dayStr, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dateX-32, dateY+(dc.getFontHeight(font3)/2), Gfx.FONT_SMALL, "-", Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dateX-40, dateY, font3, monthStr, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText((dateX-50)/2, dateY, font3, dayWeekStr.toLower(), Gfx.TEXT_JUSTIFY_CENTER);
    }
}