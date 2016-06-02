package com.b2max.common.vo
{
	[Bindable]
	public class DataInfoVO
	{
		public var info:*;
		public var infoName:String;
		public var infoIndex:int;
		public var disable:Boolean;
		
		public function DataInfoVO( info:*=null, infoName:String="", infoIndex:int=-1 )
		{
			this.info = info;
			this.infoName = infoName;
			this.infoIndex = infoIndex;
		}
	}
}

