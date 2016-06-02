package com.b2max.common.vo
{

	[Bindable]
	public class PowerVO
	{	
		public var isPowerChat:Boolean = true;
		public var isPowerBoard:Boolean = true;
		public var isPowerDoc:Boolean = true;
		
		public function PowerVO( obj:Object=null )
		{
			if ( !obj ) return;
			
			this.isPowerChat = obj.isPowerChat;
			this.isPowerBoard = obj.isPowerBoard;
			this.isPowerDoc = obj.isPowerDoc;
		}
	}
}

