using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class TimeDrawable extends WatchUi.Drawable {
	private var font;
	private var font2;
	private var font5;
	private var alarmUi;
	private var meridiamY = 0;
	
	var paddingY = 0;
	
	function initialize(options) {
	    Drawable.initialize(options);
	    font = WatchUi.loadResource(Rez.Fonts.id_font_digital);
    	font2 = WatchUi.loadResource(Rez.Fonts.id_font_digital_sec);
    	font5 = WatchUi.loadResource(Rez.Fonts.id_font_cas10_2);
    	var paddingY_ = options.get(:paddingY);
        if(paddingY_ != null) {
            paddingY = paddingY_;
        }
        var meridiamY_ = options.get(:meridiamY);
        if(meridiamY_ != null) {
            meridiamY = meridiamY_;
        }
	}
	    
	function draw(dc) {
		var alarmUi = new AlarmUi(dc.getWidth()-31 - margin(dc), (dc.getHeight()/2)-26 + paddingY,10);
		var dateTime = DateTimeBuilder.build();
		
		drawTime(dc, dateTime.getHour(), dateTime.getMinutes(), dateTime.getSeconds(), dateTime.getMeridiam());
        alarmUi.draw(dc);
	}
	
	function drawSeconds(dc,sec,mode){
        var secString = "";
        if(mode == true){
	    	dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
	    	secString = "88";
        }else{
        	secString = sec;
        	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        }	
        var yPosition = dc.getHeight()/2  +  (dc.getFontHeight(font) - dc.getFontHeight(font2) - 2)/2 + paddingY;
        dc.drawText(dc.getWidth() - margin(dc), yPosition, font2, secString, Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
    
    }
    
    private function drawTime(dc, hour, minute,sec,meridiam){
    	// Draw Time
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		if(meridiam != ""){
			dc.drawText(30, dc.getHeight()-2*(dc.getHeight()/3)-8 + meridiamY, font5, meridiam, Gfx.TEXT_JUSTIFY_LEFT);
		}
		var margin = margin(dc);
		var yPosition = dc.getHeight()/2 + 3 + paddingY;
        dc.drawText(dc.getWidth()-50 - margin , yPosition, font, minute, Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dc.getWidth()-105 - margin, yPosition, font, ":", Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dc.getWidth()-127 - margin, yPosition, font, hour, Gfx.TEXT_JUSTIFY_RIGHT| Gfx.TEXT_JUSTIFY_VCENTER);

        // Draw Seconds
        drawSeconds(dc,sec,sleepMode);
    }
    
    private function margin(dc){
    	return (dc.getWidth() - 195)/2;
    }
}