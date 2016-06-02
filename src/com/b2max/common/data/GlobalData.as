////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.data
{
	import com.b2max.common.domain.AuthInfoVO;
	import com.b2max.common.domain.AuthenticateDomain;
	import com.b2max.common.managers.MasterManager;
	import com.b2max.common.vo.LabelVO;
	import com.b2max.common.vo.OrgVO;
	import com.b2max.common.vo.PowerVO;
	import com.b2max.common.vo.RoomVO;
	import com.b2max.common.vo.UserVO;
	
	import flash.net.NetConnection;
	
	import mx.collections.ArrayList;
	
	/** 
	 *  전역 데이타
	 */ 
	[Bindable]
	public class GlobalData
	{
		public static var designUI:String;
		
		public static var isOlogDebug:Boolean = false;
		public static var isOlogDebug_Lobby:Boolean = false;
		public static var isOlogDebug_ObserverMode:Boolean = false;
		public static var isOlogDebug_Chat:Boolean = false;
		
		
		public static var MODE:int = 0;								// 0 : 일반모드, 1: Observer모드
		
		public static var eq:Object = {};
		public static var nc:NetConnection;

		public static var targetRoomVO:RoomVO;
		public static var isLogged:Boolean = false;
		
		public static var isScreenSharing:Boolean = false;
		public static var selectedLang:String = "ko";
		
		// 데이타 정보
		public static var data:Object = {};
		
		public static var authInfoVO:AuthInfoVO;					// 웹에서 솔루션 호출하며 담아온 파라미터 데이타 정보 - isLMS / isAuth
		public static var logonAuthInfoVO:AuthenticateDomain;		// 솔루션 로그인으로 웹인증 요청 이후 인증유저 정보
		public static var s2optionArr:Array = [];					// 웹옵션 S2
		public static var s6optionArr:Array = [];					// 웹옵션 S6
		
		/**
		 * 웹옵션코드 존재 여부 반환
		 */ 
		public static function hasExistCode( optionArr:Array, code:String ):Boolean
		{
			var isExistCode:Boolean = false;
			for each ( var c:String in optionArr )
			{
				if ( c == code ) 
				{
					isExistCode = true;
					break;
				}
			}
			return isExistCode;
		}
		
		
		/**
		 * LMS 체크여부
		 */ 
		public static function get isLMS():Boolean
		{
			var isOK:Boolean = false;
			if ( authInfoVO && authInfoVO.courseIdx ) isOK = true;
			//trace( ">>>>>> isLMS : " + authInfoVO + "   " + isOK );
			return isOK;
		}
		
		/**
		 * 웹호출 인증 체크여부
		 */ 
		public static function get isAuth():Boolean
		{
			var isOK:Boolean = false;
			if ( authInfoVO ) isOK = true;
			//trace( ">>>>>> authInfoVO : " + authInfoVO + "   " + isOK );
			return isOK;
		}
		
		/**
		 * 로그인 인증 체크여부
		 */ 
		public static function get isLoginAuth():Boolean
		{
			var isOK:Boolean = false;
			if ( logonAuthInfoVO ) isOK = true;
			//trace( ">>>>>> logonAuthInfoVO : " + logonAuthInfoVO + "   " + isOK );
			return isOK;
		}
		
		private static var _userVO:UserVO;
		public static function get userVO():UserVO
		{
			return _userVO;
		}
		public static function set userVO( value:UserVO ):void
		{
			_userVO = value;
			//trace( "userVO : " + ObjectUtil.toString( value ) ); 
			InterfaceData.userID = value.userID;
			InterfaceData.userName = value.userName;
		}
		
		private static var _roomVO:RoomVO;
		public static function get roomVO():RoomVO
		{
			return _roomVO;
		}
		public static function set roomVO( value:RoomVO ):void
		{
			_roomVO = value;
			//trace( "roomVO : " + ObjectUtil.toString( value ) ); 
			InterfaceData.roomID = value.roomID;
			InterfaceData.roomName = value.roomName;
			InterfaceData.roomType = value.roomType;
			InterfaceData.roomInfoType = value.roomInfoVO ? value.roomInfoVO.type : -1;
		}
		
		public static var lobbyID:String = "LOBBY_6fa459ea-ee8a-3ca4-894e-db77e160355e";	// B2MAX LobbyID
		public static var roomID:String;
		public static var userID:String;
		public static var userName:String;		
		public static var companyName:String = "(주)비투맥스";		
		public static var ip:String;
		
		public static var lengthUserName:String;
		public static var lengthUserID:String;
		
		public static var userLevel:int = 1;	// 0:최고권한, 1:일반권한
		public static var userType:int = -1;	// 0:사회자, 1:찬성자, 2:반대자, 3:참관자, -1:디폴트
		
		public static var enterRoom_type:String;
		
		public static var powerDebateUserID:String;
		
		public static var isSendVideo:Boolean = false;
		public static var isSendAudio:Boolean = false;
		
		public static var isPowerChat:Boolean = true;
		public static var isInitAudioStarted:Boolean = false;
		
		
		public static var defaultSpeakerVolume:Number=70;	// 개개인 볼륨 기본값
		public static var globalSpeakerVolume:Number=70;	// 내 스피커 전체볼륨 기본값
		public static var globalMicVolume:Number=80;		// 내 마이크 볼륨 기본값
		
		
		// 라벨 타이틀 정보 vo
		public static var labelVO:LabelVO = new LabelVO();
		public static var labelKey:String = "00";
		
		public static var lobbyRoomList:ArrayList = new ArrayList();
		
		// User정보 ArrayList.  VideoList, UserList에서 씀
		public static var lobbyUserList:ArrayList = new ArrayList();
		public static var allUserPureList:ArrayList = new ArrayList();
		public static var allUserList:ArrayList = new ArrayList();				// N명
		public static var videoUserList:ArrayList = new ArrayList();			// MAX 4명
		public static var mobileVideoUserList:ArrayList = new ArrayList();
		
		public static var powerUserList:ArrayList = new ArrayList();			// 방장인원수
		public static var debateMCList:ArrayList = new ArrayList();				// 1명
		public static var debateUserList:ArrayList = new ArrayList();			// 일반토론시 2명, 자유토론시 N명
		
		public static function setUserLevel( userID:String, userLevel:int=1 ):void
		{
			for each ( var userVO:UserVO in GlobalData.allUserList.source )
			{
				//trace( "setUserLevel ----------- userVO.userID : " + userVO.userID + "     userVO.userLevel : " + userVO.userLevel );
				if ( userID == userVO.userID ) 
				{
					userVO.userLevel = userLevel;
					//trace( "setUserLevel ----------- userID : " + userID + "     userLevel : " + userLevel + "     userVO.userLevel : " + userVO.userLevel );
					break;
				}
			}
		}
		
		public static function setPower( userID:String, powerVO:PowerVO ):void
		{
			for each ( var userVO:UserVO in GlobalData.allUserList.source )
			{
				//trace( "1 setPower ----------- userID : " + userID + "     userVO.powerVO.isPowerDoc : " + userVO.powerVO.isPowerDoc + "     powerVO.isPowerDoc : " + powerVO.isPowerDoc );
				if ( userID == userVO.userID ) 
				{
					//trace( "2 setPower ----------- userID : " + userID + "     userVO.powerVO.isPowerDoc : " + userVO.powerVO.isPowerDoc + "     powerVO.isPowerDoc : " + powerVO.isPowerDoc );
					userVO.powerVO = powerVO;
					break;
				}
			}
		}
		
		public static function setPowerUserList():void
		{
			GlobalData.powerUserList = new ArrayList();
			for each ( var userVO:UserVO in GlobalData.allUserList.source )
			{
				if ( userVO.userLevel == ConstData.USER_LEVEL_SUPER ) 
				{
					GlobalData.powerUserList.addItem( userVO );
				}
			}
			
			//trace( "----------- allUserList : " + ObjectUtil.toString( GlobalData.allUserList ) );
			//trace( "----------- powerUserList : " + ObjectUtil.toString( GlobalData.powerUserList ) );
		}
		
		
		public static function setVideoUserList( userVO:UserVO ):void
		{
			videoUserList = new ArrayList();
			mobileVideoUserList = new ArrayList();
			
			var user:UserVO = null;
			for each ( user in allUserList.source )
			{
				if ( userVO.userID == user.userID )
				{
					user.mediaVO.isVideoView = userVO.mediaVO.isVideoView;
				}
				setVideoUser( user );
			}
			
			setIsVideoControl();
			
			//trace( "----------->>> videoUserList : " + videoUserList.length );
			MasterManager.getInstance().interfaceManager.changeUserList();
//			LayoutManager.getInstance().changeLayoutVO();
		}
		
		public static function setIsVideoControl():void
		{
			var user:UserVO = null;
			var videoUserTotal:int = videoUserList.length;
			if ( videoUserTotal >= ConstData.VIDEO_USER_MAX )
			{
				for each ( user in allUserList.source )
				{
					if ( user.mediaVO.isVideoView && user.userID != userID ) user.mediaVO.isVideoControl = true;
					else 										     		 user.mediaVO.isVideoControl = false;
					
					//trace( "1 ==============[ " + user.userName + " : " + userName + " ]  user.mediaVO.isVideoView : " + user.mediaVO.isVideoView + "  user.mediaVO.isVideoControl : " + user.mediaVO.isVideoControl );
				}
			}
			else
			{
				for each ( user in allUserList.source )
				{
					if ( user.userID != userID ) user.mediaVO.isVideoControl = true;
					else 					 	 user.mediaVO.isVideoControl = false;
					
					//trace( "2 ==============[ " + user.userName + " : " + userName + " ]  user.mediaVO.isVideoView : " + user.mediaVO.isVideoView + "  user.mediaVO.isVideoControl : " + user.mediaVO.isVideoControl );
				}
			}
		}
		
		public static function setVideoUser( userVO:UserVO ):void
		{
			if ( !userVO.mediaVO.isVideoView ) return;
			
			if ( userVO.userID == userID ) 
			{
				videoUserList.addItemAt( userVO, 0 );
			}
			else						  
			{
				//trace( "setVideoUser ==============>> " + userVO.userName + "  user.isSendVideo : " + userVO.mediaVO.isSendVideo + "   videoUserList.length : " + videoUserList.length );
				videoUserList.addItem( userVO );
				mobileVideoUserList.addItem( userVO );
			}
		}
		
		public static var voteTotalYes:int;
		public static var voteTotalNo:int;
		
		//		public static var labelVoteRequest:String = labelVO.btn_request_vote;
		
		public static var speakRequestInterval:int;
		
		public static var report:Array; // 결과보고서
		
		// true : 입장시 강제로 미디어를 켜준다.       false : 개발시 편의상 강제로 미디어 켜주는것을 막는다.
		public static var isControlForceState:Boolean = true;
		
		
		public static var titleCompany:String = "B2Max";
		
		public static var viewMode:String;
		public static var chatMode:String;
		public static var mediaMode:String;
		
		public static var selectedOrgUserList:Array = [];
		public static function getOrgUserInfo():Object
		{
			var orgUserInfo:Object = {};
			
			if ( selectedOrgUserList.length == 1 )
			{
				if ( OrgVO( selectedOrgUserList[0] ).children )
				{
					var children:Array = OrgVO( selectedOrgUserList[0] ).children.source;
					orgUserInfo = getOrgUserObj( children );
				}
				else
				{
					orgUserInfo[selectedOrgUserList[0].id] = selectedOrgUserList[0];
				}
			}
			else
			{
				orgUserInfo = getOrgUserObj( selectedOrgUserList );
			}
			
			printOrgUserInfo( orgUserInfo );
			
			return orgUserInfo;
		}
		
		private static function getOrgUserObj( orgUserList:Array ):Object
		{
			var orgUserInfo:Object = {};
			var childrenInfo:Object = {};
			for each ( var orgUserVO:OrgVO in orgUserList )
			{
				//				if ( memberVO.children ) childrenInfo = getMemberInfo( memberVO.children.source );
				if ( orgUserVO.children ) continue;
				else					 orgUserInfo[orgUserVO.id] = orgUserVO;
			}
			
			for ( var id:String in childrenInfo )
			{
				orgUserInfo[id] = childrenInfo[id];
			}
			
			return orgUserInfo;
		}
		
		private static function printOrgUserInfo( orgUserInfo:Object ):void
		{
			for each ( var orgUserVO:OrgVO in orgUserInfo )
			{
				//trace( "--------- orgUser id : " + orgUserVO.id );
			}
		}
		
		public static var selectedOrgUserInfo:Object = {}
		public static function getOrgUserList():Array
		{
			var orgUserList:Array = [];
			for each ( var orgUserVO:OrgVO in selectedOrgUserInfo )
			{
				orgUserList.push( orgUserVO );
			}
			
			//trace( ">>>>>>>>>>> " + ObjectUtil.toString( selectedOrgUserInfo ) );
			return orgUserList;
		}
		
		public static var textInputSkinClass:Class;
		public static var textAreaSkinClass:Class;
	}
}

