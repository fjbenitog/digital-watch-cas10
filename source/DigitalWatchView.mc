using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;


class DigitalWatchView extends Ui.WatchFace {
	
	var font;
	var font2;
	var font3;
	var font4;
	var font5;
	var sleepMode = true;

    function initialize() {   
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	font = Ui.loadResource(Rez.Fonts.id_font_digital);
    	font2 = Ui.loadResource(Rez.Fonts.id_font_digital_sec);
    	font3 = Ui.loadResource(Rez.Fonts.id_font_digital_date);
    	font4 = Ui.loadResource(Rez.Fonts.id_font_cas10);
    	font5 = Ui.loadResource(Rez.Fonts.id_font_cas10_2);
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	drawBackground(dc);
    
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour]);
        var minString = Lang.format("$1$", [ clockTime.min.format("%02d")]);
        var secString = Lang.format("$1$", [clockTime.sec.format("%02d")]);
        
        var now = Time.now();
        var info = Calendar.info(now, Time.FORMAT_SHORT);

        var monthStr = Lang.format("$1$", [info.month.format("%02d")]);
        var yearStr = Lang.format("$1$", [info.year.format("%04d")]);
        var dayStr = Lang.format("$1$", [info.day.format("%02d")]);
        var dayWeekStr = Calendar.info(now, Time.FORMAT_MEDIUM).day_of_week;
        	
        var battery = Sys.getSystemStats().battery;

		drawTime(dc, hourString, minString);
        
        drawDate(dc, dayStr, monthStr, dayWeekStr);
        
        drawYear(dc, yearStr);
        
        drawBattery(dc,battery);

    }
    
    function drawBattery(dc,battery){
    	var x = 27;
    	var y = (dc.getHeight()/6)+8;
    	var width = 27;
    	var height = 17;
    	var split = 2;
    	var block = 3;
    	var size = 6;
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawRectangle(x, y, width, height);
    	dc.fillRectangle(x+split+((size)*(block+1)), y+(2*split), 3, height-(4*split));
    	if(battery>25){
    		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    	}else{
    		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
    	}
    	for (var i = 0; i < (size*(battery/100)); i += 1){
    		dc.fillRectangle(x+split+(i*(block+1)), y+split, block, height-(2*split));
    	}
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
    
    function drawTime(dc, hour, minute){
    	// Draw Time
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()-50, (dc.getHeight()/3)-5, font, minute, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()-105, (dc.getHeight()/3)-5, font, ":", Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()-127, (dc.getHeight()/3)-5, font, hour, Gfx.TEXT_JUSTIFY_RIGHT);

        // Draw Seconds
        var secString = "";
        if(sleepMode == true){
        	dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        	secString = "88";
        }else{
        	var clockTime = Sys.getClockTime();
        	secString = Lang.format("$1$", [clockTime.sec.format("%02d")]);
        	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        }	
        dc.drawText(dc.getWidth()-5, (dc.getHeight()/2)-20, font2, secString, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    function drawBackground(dc){
        
	    var width, height;
        var screenWidth = dc.getWidth();
        var clockTime = Sys.getClockTime();
        var hour;
        var min;

        width = dc.getWidth();	
        height = dc.getHeight();

        var now = Time.now();

        // Clear the screen
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.fillRectangle(0,0,width, height);
        
        // Top banner
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,0,width, height/6);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width/2, 5, font4, "CAS1.0", Gfx.TEXT_JUSTIFY_CENTER);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width/2, 20, font5, "LAP MEMORY 60", Gfx.TEXT_JUSTIFY_CENTER);
        
        //Bottom banner
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,height-(height/6),dc.getWidth(), height/6);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width/2, height-32, font5, "10 YEAR BATTERY", Gfx.TEXT_JUSTIFY_CENTER);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width/2, height-20, font5, "RESET", Gfx.TEXT_JUSTIFY_CENTER);
        
        // Split top
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,height-2*(height/3)-5,dc.getWidth(), 8);
        
        // Split bottom
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,height-2*(height/6)-3,dc.getWidth(), 8);
	
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

}
