using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class AlarmUi {

	private var x;
	private var y;
	private var alarmIconBlack;
	private var alarmIconGrey;
	function initialize(x_,y_,alarmIconBlack_,alarmIconGrey_){
		x = x_;
		y = y_;
		alarmIconBlack = alarmIconBlack_;
		alarmIconGrey = alarmIconGrey_;
	}


	function draw(dc){
		internalDraw(x,dc);
	}

	private function internalDraw(x,dc){
 
    	dc.drawBitmap(x, y, alarmState() ? alarmIconBlack : alarmIconGrey);

    }
    
    private function alarmState(){
       	var settings = Sys.getDeviceSettings();
       	
    	return settings.alarmCount > 0;
    }
}