using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian as Calendar;


class DigitalWatchView extends WatchUi.WatchFace {
	
	var font;
	var font2;
	var font3;
	var font4;
	var font5;
	var sleepMode = true;
	var bluetoothUi;
	var alarmUi;
	var batteryUi;
	var notificationUi;


    function initialize() {   
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	font = WatchUi.loadResource(Rez.Fonts.id_font_digital);
    	font2 = WatchUi.loadResource(Rez.Fonts.id_font_digital_sec);
    	font3 = WatchUi.loadResource(Rez.Fonts.id_font_digital_date);
    	font4 = WatchUi.loadResource(Rez.Fonts.id_font_cas10);
    	font5 = WatchUi.loadResource(Rez.Fonts.id_font_cas10_2);
    	
    	var bluetoothIconBlack = WatchUi.loadResource(Rez.Drawables.bluetooth_icon_black);
    	var bluetoothIconGrey = WatchUi.loadResource(Rez.Drawables.bluetooth_icon_grey);
    	bluetoothUi = new BluetoothUi(65,(dc.getHeight()/6)+8,bluetoothIconBlack,bluetoothIconGrey);
    	
    	alarmUi = new AlarmUi(dc.getWidth()-36, (dc.getHeight()/2)-26,10);
    	
    	batteryUi = new BatteryUi(27,(dc.getHeight()/6)+8,27,17);
    	
    	var notificationIconBlack = WatchUi.loadResource(Rez.Drawables.notification_icon_black);
    	var notificationIconGrey = WatchUi.loadResource(Rez.Drawables.notification_icon_grey);
    	notificationUi = new NotificationUi(90,(dc.getHeight()/6)+9,notificationIconBlack,notificationIconGrey);
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	drawBackground(dc);
    
        var dateTime = DateTimeBuilder.build();

		drawTime(dc, dateTime.getHour(), dateTime.getMinutes(), dateTime.getSeconds(), dateTime.getMeridiam());
        
        drawDate(dc, dateTime.getDay(), dateTime.getMonth(), dateTime.getDayOfWeek());
        
        drawYear(dc, dateTime.getYear());
        
        batteryUi.draw(dc);
        
        bluetoothUi.draw(dc);
        
        alarmUi.draw(dc);
        
        notificationUi.draw(dc);
        
//        drawTopGuiLine(dc);
        
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
    
    function drawTime(dc, hour, minute,sec,meridiam){
    	// Draw Time
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		if(meridiam != ""){
			dc.drawText(30, dc.getHeight()-2*(dc.getHeight()/3)-8, font5, meridiam, Gfx.TEXT_JUSTIFY_LEFT);
		}

        dc.drawText(dc.getWidth()-50, (dc.getHeight()/3)-5, font, minute, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()-105, (dc.getHeight()/3)-5, font, ":", Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()-127, (dc.getHeight()/3)-5, font, hour, Gfx.TEXT_JUSTIFY_RIGHT);

        // Draw Seconds
        var secString = "";
        if(sleepMode == true){
        	dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        	secString = "88";
        }else{
        	secString = sec;
        	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        }	
        dc.drawText(dc.getWidth()-5, (dc.getHeight()/2)-20, font2, secString, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    function drawBackground(dc){
        
	    var width, height;
        var screenWidth = dc.getWidth();


        width = dc.getWidth();	
        height = dc.getHeight();


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
