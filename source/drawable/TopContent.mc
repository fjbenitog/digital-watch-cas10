using Toybox.Graphics as Gfx;
using Toybox.WatchUi;
using Toybox.System;

class TopContent extends WatchUi.Drawable {
	private var font4;
	private var font5;
	var bluetoothUi;
	var batteryUi;
	var notificationUi;

	function initialize(options) {
	    Drawable.initialize(options);
	    var width = System.getDeviceSettings().screenWidth;
	    var height = System.getDeviceSettings().screenHeight;
	    var margin = (width - 195)/2;
	    
	    font4 = WatchUi.loadResource(Rez.Fonts.id_font_cas10);
    	font5 = WatchUi.loadResource(Rez.Fonts.id_font_cas10_2);
    	var bluetoothIconBlack = WatchUi.loadResource(Rez.Drawables.bluetooth_icon_black);
    	var bluetoothIconGrey = WatchUi.loadResource(Rez.Drawables.bluetooth_icon_grey);
    	bluetoothUi = new BluetoothUi(65,(height/6)+8,bluetoothIconBlack,bluetoothIconGrey);
    	
    	batteryUi = new BatteryUi(27,(height/6)+8,27,17);
    	
    	var notificationIconBlack = WatchUi.loadResource(Rez.Drawables.notification_icon_black);
    	var notificationIconGrey = WatchUi.loadResource(Rez.Drawables.notification_icon_grey);
    	notificationUi = new NotificationUi(90,(height/6)+9,notificationIconBlack,notificationIconGrey);
	}
	    
	function draw(dc) {
		batteryUi.draw(dc);
        bluetoothUi.draw(dc);
        notificationUi.draw(dc);
	}
}