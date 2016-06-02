package com.b2max.common.domain
{
	[Bindable]
	[RemoteClass(alias="com.b2max.solution.b2conference.domain.AttachFileVO")]
	public class AttachFileVO
	{
		public var idx:int;
		public var siteIdx:int;
		public var fileName:String;
		public var realName:String;
		public var orderNo:int;
		public var regDate:String;
		public var modDate:String;
		public var regUserId:String;
		public var modUserId:String;
		public var delYn:String;
		
		public var name:String;
		public var extension:String;
		public var size:Number;
	}
}

