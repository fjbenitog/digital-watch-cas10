using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class MainBack extends WatchUi.Drawable {
	private var font4;
	private var font5;

	function initialize(options) {
	    Drawable.initialize(options);
	    font4 = WatchUi.loadResource(Rez.Fonts.id_font_cas10);
    	font5 = WatchUi.loadResource(Rez.Fonts.id_font_cas10_2);
	}
	    
	function draw(dc) {
	 
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
}