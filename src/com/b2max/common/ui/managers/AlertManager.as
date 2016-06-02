package com.b2max.common.ui.managers
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.IFlexModuleFactory;

	/**
	 *  Alert 매니저, 원하는 위치에 Alert 배치
	 */ 
	public class AlertManager
	{
		private static var alert:Alert;
		
		/**
		 *  좌표 Alert Show
		 */ 
		public static function showPos( text:String = "", 
										title:String = "",
										flags:uint = 0x4 /* Alert.OK */, 
										parent:Sprite = null, 
										closeHandler:Function = null, 
										iconClass:Class = null, 
										defaultButtonFlag:uint = 0x4 /* Alert.OK */,
										moduleFactory:IFlexModuleFactory = null ):void
		{
			alert = Alert.show( text, title, flags, null, closeHandler, iconClass, defaultButtonFlag, moduleFactory );
			
//			var browserInfo:BrowserInfo = SiteUtil.getBrowserInfo();
//			var alertWidth:int = alert.width;
//			
//			var posX:int = browserInfo.browser_width / 2 - alert.width / 2 + browserInfo.browser_x;
//			var posY:int = browserInfo.browser_height / 2 - alert.height / 2 + browserInfo.browser_y;
//			
//			//trace("ALERT POS : ", posX, posY, "ALERT SIZE : ", alert.width, alert.height);
//			
//			alert.validateNow();
//			alert.move( posX, posY );
		}
		
		/**
		 *  좌표 Alert Show
		 */ 
		public static function show( text:String = "", 
									 title:String = "",
									 flags:uint = 0x4 /* Alert.OK */, 
									 parent:Sprite = null, 
									 closeHandler:Function = null, 
									 iconClass:Class = null, 
									 defaultButtonFlag:uint = 0x4 /* Alert.OK */,
									 moduleFactory:IFlexModuleFactory = null ):void
		{
			alert = Alert.show( text, title, flags, parent, closeHandler, iconClass, defaultButtonFlag, moduleFactory );
		}
	}
}

class PrivateClass 
{
	public function PrivateClass() {}
}