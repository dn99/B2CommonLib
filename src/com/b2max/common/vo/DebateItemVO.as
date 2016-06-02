package com.b2max.common.vo
{
	[Bindable]
	public class DebateItemVO
	{
		public var index:int;			// 토론 순서
		public var state:int;			// 입론 0, 질의 1, 반론 2, 결론 3
		public var speaker:int;			// 찬성자 1, 반대자 2
		public var timeMin:Number;		// 분
		public var timeSec:Number;		// 초
		public var enable:int;			// 표시 0, 활성 1, 비표시 2
		
		public var timeRealMin:Number;	// REAL 분
		public var timeRealSec:Number;	// REAL 초
		
		public function DebateItemVO( index:int=-1, state:int=-1, speaker:int=-1, timeMin:int=0, timeSec:int=0, enable:int=0, timeRealMin=0, timeRealSec=0 )
		{
			this.index = index;
			this.state = state;
			this.speaker = speaker;
			this.timeMin = timeMin;
			this.timeSec = timeSec;
			this.enable = enable;
			
			this.timeRealMin = timeRealMin;
			this.timeRealSec = timeRealSec;
		}
		
		public function setVO( obj:Object ):void
		{
			if ( !obj ) return;
			
			this.index = obj.index;
			this.state = obj.state;
			this.speaker = obj.speaker;
			this.timeMin = obj.timeMin;
			this.timeSec = obj.timeSec;
			this.enable = obj.enable;
			
			this.timeRealMin = obj.timeRealMin;
			this.timeRealSec = obj.timeRealSec;
		}
	}
}

