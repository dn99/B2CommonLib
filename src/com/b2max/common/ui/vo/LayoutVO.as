package com.b2max.common.ui.vo
{
	[Bindable]
	public class LayoutVO
	{
		public var layoutMode:String;		// 모드타입
		public var layoutName:String;		// 모드 이름
		public var layoutIndex:int;			// 인덱스
		public var layoutSetName:String;	// 조합된 모드 이름

		public function LayoutVO( layoutMode:String="", layoutName:String="", layoutIndex:int=0 )
		{
			this.layoutMode = layoutMode;
			this.layoutName = layoutName;
			this.layoutIndex = layoutIndex;
		}
		
		public function setVO( obj:Object ):void
		{
			if ( !obj ) return;
			
			this.layoutMode = obj.layoutMode;
			this.layoutName = obj.layoutName;
			this.layoutIndex = obj.layoutIndex;
		}
	}
}

