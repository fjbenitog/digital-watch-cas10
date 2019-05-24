using Toybox.Time.Gregorian as Calendar;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;

module DateTimeBuilder{

	function build(){
		var clockTime = System.getClockTime();
		var hour = clockTime.hour;
        var hourString = Lang.format("$1$", [calculateHour(hour)]);
        var minString = Lang.format("$1$", [ clockTime.min.format("%02d")]);
        var secString = Lang.format("$1$", [clockTime.sec.format("%02d")]);
        
        var now = Time.now();
        var info = Calendar.info(now, Time.FORMAT_SHORT);

        var monthStr = Lang.format("$1$", [info.month.format("%02d")]);
        var yearStr = Lang.format("$1$", [info.year.format("%04d")]);
        var dayStr = Lang.format("$1$", [info.day.format("%02d")]);
        var dayWeekStr = Calendar.info(now, Time.FORMAT_MEDIUM).day_of_week;
        
        return new DateTime(hourString,minString,secString,
        	dayWeekStr,yearStr,monthStr,dayStr,calculateMeridiam(hour));
	}
	
	function calculateHour(hour){
	    var settings = System.getDeviceSettings();
		if(!settings.is24Hour){
			if(hour == 0){
			 	hour = 12;
			} else if(hour > 12){
				hour = hour - 12;
			}
		}
		
		return hour;
	}
	
	function calculateMeridiam(hour){
		var settings = System.getDeviceSettings();
		if(!settings.is24Hour){
			return hour > 12 ? "PM" : "AM";
		}else{
			return "";
		}
	}

	class DateTime{
         private var hourString;
         private var minString;
         private var secString;

         private var monthStr;
         private var yearStr;
         private var dayStr;
         private var dayWeekStr;
         private var meridiam;
        
        function initialize(ihourString,iminString,isecString,
        	idayWeekStr,iyearStr,imonthStr,idayStr,imeridiam){
        	hourString=ihourString;
        	minString=iminString;
        	secString=isecString;
        	dayWeekStr=idayWeekStr;
        	yearStr=iyearStr;
        	monthStr=imonthStr;
        	dayStr=idayStr;
        	meridiam=imeridiam;
        }
        
        function getHour(){
        	return hourString;
        }
        
        function getMinutes(){
        	return minString;
        }
        
        function getSeconds(){
        	return secString;
        }
        
        function getDayOfWeek(){
        	return dayWeekStr;
        }
        
        function getYear(){
        	return yearStr;
        }
        
        function getMonth(){
        	return monthStr;
        }
        
        function getDay(){
        	return dayStr;
        }
        
        function getMeridiam(){
        	return meridiam;
        }
	}
}