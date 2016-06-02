package com.b2max.common.ui.controls
{
	import flash.utils.Timer;
	
	public class IntervalTimer extends Timer
	{
		public var id:String;
		
		public function IntervalTimer( delay:Number, repeatCount:int=0 )
		{
			super( delay, repeatCount );
		}
	}
}