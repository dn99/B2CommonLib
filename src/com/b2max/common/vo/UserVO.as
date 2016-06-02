package com.b2max.common.vo
{	
	import com.b2max.common.utils.CommonUtil;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class UserVO extends EventDispatcher
	{
		public var userID:String;						// userID
		public var userName:String;						// userName
		public var userLevel:int;						// userLevel - 방장/방원
		public var userType:int;						// userType	토론전용 - MC/찬성자/반대자/참관자 
		public var mode:int;							// UI mode - 일반유저/옵저버유저
		public var lobbyID:String;						// lobbyID
		
		public var ip:String;							// 접속IP
		public var host:String;							// 접속host이름
		public var os:String;							// 접속OS이름
		public var osBit:String;						// OS비트
		public var browser:String;						// 접속 브라우저
		public var browserVersion:String;				// 접속 브라우저 버전
		public var language:String;						// OS언어
		public var platformVersion:String;				// FlashPlayer, AIR 버전
		public var startTime:String;					// 최초 접속시간
		
		public var lengthUserName:String;				
		public var powerVO:PowerVO = new PowerVO();		// 권한VO
		public var voteYesNo:int = -1;					// 찬반여부
		public var mediaVO:MediaVO;						// 미디어정보
		public var eq:int;								// 음성이퀄라이저값
		
		public var isSTT:Boolean=false;					// 음성인식 on/off (다른User와 공유되는 값이 아니다.) 
		
		public function UserVO( obj:Object=null )
		{
			if ( !obj ) return;	
			
			this.userID = obj.userID;
			this.userName = obj.userName;
			this.userLevel = obj.userLevel;
			this.userType = obj.userType;
			this.mode = obj.mode;
			this.lobbyID = obj.lobbyID;
			
			this.ip = obj.ip;
			this.host = obj.host;
			this.os = obj.os;
			this.osBit = obj.osBit;
			this.browser = obj.browser;
			this.browserVersion = obj.browserVersion;
			this.language = obj.language;
			this.platformVersion = obj.platformVersion;
			this.startTime = obj.startTime;
			
			this.lengthUserName = CommonUtil.getLengthUserName( obj.userName );
			this.powerVO = new PowerVO( obj.powerVO );
			this.voteYesNo = obj.voteYesNo;
			this.mediaVO = new MediaVO(obj.mediaVO);
		}
	}
}