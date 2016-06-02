package com.b2max.common.vo
{
	[Bindable]
	public class TimeVO
	{
		public var timeHour:int;
		public var timeMin:int;
		public var timeSec:int;

		public function TimeVO( obj:Object=null )
		{
			if ( !obj ) return;
			
			timeHour = obj.timeHour;
			timeMin = obj.timeMin;
			timeSec = obj.timeSec;
		}
	}
}

