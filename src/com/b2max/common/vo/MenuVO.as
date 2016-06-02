package com.b2max.common.vo
{
	import flash.display.DisplayObject;
	
	[Bindable]
	public class MenuVO
	{
		public var label:String;
		public var type:String;
		public var data:MenuPropVO;
		
		public var selected:Boolean;
		
		public function MenuVO( label:String="", type:String="", data:MenuPropVO=null )
		{
			this.label = label;
			this.type = type;
			this.data = data;
		}
	}
}