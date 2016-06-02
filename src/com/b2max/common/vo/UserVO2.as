package com.b2max.common.vo
{	
	public class UserVO2
	{
		public var userID:String;
		public var userName:String;
		public var ip:String;
		public var device:String;
		public var startTime:String;
		
		public function UserVO2(userID:String, userName:String, ip:String, device:String, startTime:String):void
		{
			this.userID=userID;
			this.userName=userName;
			this.ip=ip;
			this.device=device;
			this.startTime=startTime;
		}
	}
}

