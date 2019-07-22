using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class NotificationUi {

	private var width = 20;
	private var height = 12;
	private var x;
	private var y;
	function initialize(x_,y_){
		x = x_;
		y = y_;
	}


	function draw(dc){
    	var color = notificationState() ? Gfx.COLOR_BLACK : Gfx.COLOR_LT_GRAY;
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);

		
    	dc.fillRoundedRectangle(x, y, width, height,2);
    	
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(x,y,x+width/2,y+height/2+1);
    	dc.drawLine(x+1,y,x+width/2+1,y+height/2+1);
    	
    	dc.drawLine(x+width/2,y+height/2+1,x+width,y);
    	dc.drawLine(x+width/2-1,y+height/2+1,x+width-1,y);
    	
    	dc.drawLine(x,y+height-1,x+width/2-3,y+height/2-1);
    	dc.drawLine(x+1,y+height-1,x+width/2-2,y+height/2-1);
    	
    	dc.drawLine(x+width/2+3,y+height/2-1,x+width,y+height);
    	dc.drawLine(x+width/2+2,y+height/2-1,x+width-1,y+height);
    	dc.setPenWidth(1);
	}
    
    private function notificationState(){
       	var settings = Sys.getDeviceSettings();
       	
    	return settings.notificationCount !=0;
    }
}