using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian as Calendar;
using Toybox.System;


class DigitalWatchView extends WatchUi.WatchFace {
	
	var font;
	var font2;
	var font3;
	private var font5;
	var sleepMode = true;
	var alarmUi;

    function initialize() {   
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout( Rez.Layouts.WatchFace( dc ) );
    	font = WatchUi.loadResource(Rez.Fonts.id_font_digital);
    	font2 = WatchUi.loadResource(Rez.Fonts.id_font_digital_sec);
    	font3 = WatchUi.loadResource(Rez.Fonts.id_font_digital_date);
    	font5 = WatchUi.loadResource(Rez.Fonts.id_font_cas10_2);
    	
    	alarmUi = new AlarmUi(dc.getWidth()-31 - margin(dc), (dc.getHeight()/2)-26,10);

    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    
        var dateTime = DateTimeBuilder.build();
//
		drawTime(dc, dateTime.getHour(), dateTime.getMinutes(), dateTime.getSeconds(), dateTime.getMeridiam());
//        
//        drawDate(dc, dateTime.getDay(), dateTime.getMonth(), dateTime.getDayOfWeek());
//        
//        drawYear(dc, dateTime.getYear());
        
        alarmUi.draw(dc);
        
    }
    
    function drawTopGuiLine(dc){
    	//Guide Lines
		dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawLine(0  , (dc.getHeight()/6) + 5  , dc.getWidth()    , (dc.getHeight()/6) + 5 );
		dc.drawLine(0  , (dc.getHeight()/6) + 27  , dc.getWidth()    , (dc.getHeight()/6) + 27 );
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
    
    function onPartialUpdate(dc){
		sleepMode = true;
		var width = 36;
		var height = 46;
		var x = dc.getWidth() - margin(dc) - width;
		var y = (dc.getHeight()/2)-12;
		
    	dc.setClip(x, y, width, height);
    	
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.fillRectangle(x, y, width, height);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	
    	var dateTime = DateTimeBuilder.build();
    	drawSeconds(dc,dateTime.getSeconds(),false);
    	
    	dc.clearClip();
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
        var yPosition = dc.getHeight()/2  +  (dc.getFontHeight(font) - dc.getFontHeight(font2) - 2)/2 ;
        dc.drawText(dc.getWidth() - margin(dc), yPosition, font2, secString, Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
    
    }
    
    function drawTime(dc, hour, minute,sec,meridiam){
    	// Draw Time
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		if(meridiam != ""){
			dc.drawText(30, dc.getHeight()-2*(dc.getHeight()/3)-8, font5, meridiam, Gfx.TEXT_JUSTIFY_LEFT);
		}
		var margin = margin(dc);
		var yPosition = dc.getHeight()/2 + 3;
        dc.drawText(dc.getWidth()-50 - margin , yPosition, font, minute, Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dc.getWidth()-105 - margin, yPosition, font, ":", Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(dc.getWidth()-127 - margin, yPosition, font, hour, Gfx.TEXT_JUSTIFY_RIGHT| Gfx.TEXT_JUSTIFY_VCENTER);

        // Draw Seconds
        drawSeconds(dc,sec,sleepMode);
    }
    

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	sleepMode = false;
    	requestUpdate();
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
		sleepMode = true;
		requestUpdate();
    }
    
    function margin(dc){
    	return (dc.getWidth() - 195)/2;
    }

}
