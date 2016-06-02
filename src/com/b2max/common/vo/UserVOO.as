package com.b2max.common.vo
{	
	import com.b2max.common.utils.CommonUtil;
	
	import flash.events.EventDispatcher;

	[Bindable]
	public class UserVOO extends EventDispatcher
	{
		public var userID:String;
		public var userName:String;
		public var ip:String;
		public var device:String;
		public var startTime:String;
		public var userLevel:int;
		public var userType:int;
		public var mode:int;
		public var lengthUserName:String;
		public var powerVO:PowerVO = new PowerVO();
		public var voteYesNo:int = -1;
		public var isVideoView:Boolean;
		public var isVideoControl:Boolean;
		
		public function UserVOO( obj:Object=null )
		{
			if ( !obj ) return;	
			
			this.userID = obj.userID;
			this.userName = obj.userName;
			this.ip = obj.ip;
			this.device = obj.device;
			this.startTime = obj.startTime;
			this.userLevel = obj.userLevel;
			this.userType = obj.userType;
			this.mode = obj.mode;
			this.lengthUserName = CommonUtil.getLengthUserName( obj.userName, 6 );
			this.powerVO = obj.powerVO;
			this.voteYesNo = obj.voteYesNo;
			this.isVideoView = obj.isVideoView;
			this.isVideoControl = obj.isVideoControl;

		}

	}
}

