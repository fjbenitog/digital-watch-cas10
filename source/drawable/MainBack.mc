using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class MainBack extends WatchUi.Drawable {
	private var font4;
	private var font5;
	private var banner = true;
	private var bannerTop = true;
	private var bannerBottom = true;
	private var splitHeight = 8;
	private var height = System.getDeviceSettings().screenHeight;
	private var splitTopY = height-2*(height/3)-5;
	private var splitBottonY = height-2*(height/6)-3;
	
	
	function initialize(options) {
	    Drawable.initialize(options);
	    font4 = WatchUi.loadResource(Rez.Fonts.id_font_cas10);
    	font5 = WatchUi.loadResource(Rez.Fonts.id_font_cas10_2);
    	var banner_ = options.get(:banner);
        if(banner_ != null) {
            banner = banner_;
        }
        var bannerTop_ = options.get(:bannerTop);
        if(bannerTop_ != null) {
            bannerTop = bannerTop_;
        }
        var bannerBottom_ = options.get(:bannerBottom);
        if(bannerBottom_ != null) {
            bannerBottom = bannerBottom_;
        }
        var splitHeight_ = options.get(:splitHeight);
        if(splitHeight_ != null) {
            splitHeight = splitHeight_;
        }
        var splitTopY_ = options.get(:splitTopY);
        if(splitTopY_ != null) {
            splitTopY = splitTopY_;
        }
        var splitBottonY_ = options.get(:splitBottonY);
        if(splitBottonY_ != null) {
            splitBottonY = splitBottonY_;
        }
	}
	    
	function draw(dc) {
	 
	    var width, height;
        var screenWidth = dc.getWidth();


        width = dc.getWidth();	
        height = dc.getHeight();


        // Clear the screen
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.fillRectangle(0,0,width, height);
        
        if(banner){
        	if(bannerTop){
	        // Top banner
		        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
		        dc.fillRectangle(0,0,width, height/6);
		        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		        dc.drawText(width/2, 5, font4, "CAS1.0", Gfx.TEXT_JUSTIFY_CENTER);
		        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
		        dc.drawText(width/2, 20, font5, "LAP MEMORY 60", Gfx.TEXT_JUSTIFY_CENTER);
	        }
	        
	        if(bannerBottom){
	        //Bottom banner
		        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
		        dc.fillRectangle(0,height-(height/6),dc.getWidth(), height/6);
		        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
		        dc.drawText(width/2, height-32, font5, "10 YEAR BATTERY", Gfx.TEXT_JUSTIFY_CENTER);
		        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		        dc.drawText(width/2, height-20, font5, "RESET", Gfx.TEXT_JUSTIFY_CENTER);
	        }
        }
        
        // Split top
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,splitTopY,dc.getWidth(), splitHeight);
        
        // Split bottom
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,splitBottonY,dc.getWidth(), splitHeight);
	
	}
}