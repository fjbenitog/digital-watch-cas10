using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class MainBackSmall extends WatchUi.Drawable {


	function initialize(options) {
	    Drawable.initialize(options);
	}
	    
	function draw(dc) {
	 
	    var width, height;
        var screenWidth = dc.getWidth();


        width = dc.getWidth();	
        height = dc.getHeight();


        // Clear the screen
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.fillRectangle(0,0,width, height);
       
        
        // Split top
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,(height/8) + 16,dc.getWidth(), 6);
        
        // Split bottom
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,height-(height/8) - 16,dc.getWidth(), 6);
	
	}
}