using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class AlarmUi {

	private var x;
	private var y;
	private var witdh;
	private var height;
	function initialize(x_,y_,height_){
		x = x_;
		y = y_;
		witdh = 30;
		height = height_;
	}


	function draw(dc){
		internalDraw(x,dc);
	}

	private function internalDraw(x,dc){
	 	var color = alarmState() ? Gfx.COLOR_BLACK : Gfx.COLOR_LT_GRAY;
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(x, y, witdh, height);
 		dc.setPenWidth(2);

 		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.drawArc(x, y + height/2 , 8, Gfx.ARC_COUNTER_CLOCKWISE, -55, 55);
		dc.drawArc(x, y + height/2 , 13, Gfx.ARC_COUNTER_CLOCKWISE, -35, 35);
		dc.drawArc(x, y + height/2 , 18, Gfx.ARC_COUNTER_CLOCKWISE, -20, 20);
		dc.drawArc(x, y + height/2 , 22, Gfx.ARC_COUNTER_CLOCKWISE, -15, 15);
		dc.setPenWidth(6);
		dc.drawArc(x, y + height/2 , 27, Gfx.ARC_COUNTER_CLOCKWISE, -15, 15);

    	dc.setPenWidth(1);

    }
    
    private function alarmState(){
       	var settings = Sys.getDeviceSettings();
       	
    	return settings.alarmCount > 0;
    }
}