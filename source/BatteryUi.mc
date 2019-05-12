using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class BatteryUi {

    function draw(x,y,width,height,dc){
        var battery = Sys.getSystemStats().battery;
    	var split = 2;
    	var block = 3;
    	var size = 6;
    	var lowBattery = 25;
    	var fullBattery = 100;
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawRectangle(x, y, width, height);
    	dc.fillRectangle(x+split+((size)*(block+1)), y+(2*split), 3, height-(4*split));
    	if(battery>lowBattery){
    		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    	}else{
    		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
    	}
    	for (var i = 0; i < (size*(battery/fullBattery)); i += 1){
    		dc.fillRectangle(x+split+(i*(block+1)), y+split, block, height-(2*split));
    	}
    }
}