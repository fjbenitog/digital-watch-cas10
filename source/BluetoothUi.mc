using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class BluetoothUi {

	enum {
		NotInitialized,
		NotConnected,
		Connected
	}

	function draw(x,y,dc){
    	var state = bluetoothState();
    	if(state == NotInitialized) {
    		return;
    	}
    	
    	var color;
    	if(state == Connected){
    		color = Gfx.COLOR_DK_BLUE;
    	}else{
    		color = Gfx.COLOR_LT_GRAY;
    	}
    	
    	
		var width = 7;
		var height = 9;
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		dc.fillEllipse(x + width, y + height, width, height);
	
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		
		var x0 = x + width; // Middle Point     
		var x1 = x0 + 5;    // Max Right
		var x2 = x0 - 6;    // Max Left
		
		var y0 = y+2;              // Max Up
		var y1 = y + (2*height)-1; // Max Botton
		var y2 = y0 + 5;           // 
		var y3 = y1 - 5;
		
		
		dc.drawLine(x0, y0, x0, y1); //Middle Line
		dc.drawLine(x0, y0, x1, y2); // Small Top
		dc.drawLine(x0, y1, x1, y3); // Small Bottom
		
		dc.drawLine(x1, y2, x2, y3); // Big Top-Bottom
		dc.drawLine(x1, y3, x2, y2); // Big Bottom-Top
		
		//Guide Lines
//			dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
//			dc.drawLine(0  , y               , dc.getWidth()    , y );
//			dc.drawLine(0  , y + 2*height    , dc.getWidth()    , y + 2*height  );

    }
    
    private function bluetoothState(){
    	var settings = Sys.getDeviceSettings();
        var state = null;
		if (settings has : connectionInfo)
		{
			// Check the connection state v3.0.0
			var bluetoothState = settings.connectionInfo[:bluetooth].state ;

			if(bluetoothState == Sys.CONNECTION_STATE_CONNECTED){
    			state = Connected;
    		}else if(bluetoothState == Sys.CONNECTION_STATE_NOT_CONNECTED){
    			state = NotConnected;
    		}else{
    			state = NotInitialized;
    		}
        	
        }else {
        	if(settings.phoneConnected){
        		state = Connected;
        	}else{
        		state = NotConnected;
        	}
        }
        return state;
    }
}