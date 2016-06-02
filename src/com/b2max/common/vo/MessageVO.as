package com.b2max.common.vo
{
	[Bindable]
	public class MessageVO
	{
		public var roomID:String;
		public var userID:String;
		public var userName:String;
		public var sendTime:String;
		public var styledMessage:String;
		public var textMessage:String;
		public var isNotification:Boolean;
		
		public function MessageVO( obj:Object )
		{
			roomID = obj.roomID;
			userID = obj.userID;
			userName = obj.userName;
			sendTime = obj.sendTime;
			styledMessage = obj.styledMessage;
			textMessage = obj.textMessage;
			isNotification = obj.isNotification;
		}
	}
}

