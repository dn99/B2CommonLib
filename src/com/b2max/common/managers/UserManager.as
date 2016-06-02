////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.managers
{
	import com.b2max.common.data.ConstData;
	import com.b2max.common.data.GlobalData;
	import com.b2max.common.events.UserEvent;
	import com.b2max.common.vo.UserVO;
	import com.b2max.websocket.flashsocket.FlashSocket;
	
	import flash.events.EventDispatcher;
	
	import mx.utils.ObjectUtil;
	
	public class UserManager extends EventDispatcher
	{
		
		private var isDebug:Boolean=false;
		private static var _instance:UserManager;
		
		public var masterManager:MasterManager;
		public var socket:FlashSocket;
		
		private var _users:Vector.<UserVO>=null;
//		[Bindable] public var usersList:ArrayList;
		
		public function UserManager( secure:PrivateClass ) {}
		
		public static function getInstance():UserManager
		{
			if ( !_instance ) 
			{
				_instance = new UserManager( new PrivateClass() );
				_instance._users=new Vector.<UserVO>();
//				_instance.usersList = new ArrayList();
			}
			
			return _instance;
		}
		
		public static function removeInstance():void
		{
			_instance = null;
		}
		
		private function hasExistID( userID:String, targetList:Array ):Boolean
		{
			var isExistID:Boolean = false;
			for each ( var e:Object in targetList )
			{
				if ( userID == e.userID )
				{
					isExistID = true;
					break;
				}
			}
			return isExistID;
		}
		
		private function convertVectorToArray( vec:Vector.<UserVO> ):Array
		{
			var array:Array = [];
			var len:int = vec.length;
			for ( var i:int = 0; i<len; i++ ) 
			{
				array[i] = vec[i];
			}
			return array;
		}
		
		public function updateLobbyUserlist(newUsers:Array):void
		{
			GlobalData.lobbyUserList.removeAll();

			for(var key:String in newUsers)
			{
				var user:Object = new Object();
				user.userID = newUsers[key].userID;
				user.userName = newUsers[key].userName;
				GlobalData.lobbyUserList.addItem(user);
			}
			// debug( "::::::::::::::::::::::: GlobalData.lobbyUserList : " + ObjectUtil.toString(GlobalData.lobbyUserList)  );
		}
		
		public function updateUserList(newUsers:Array):void
		{
			var userVO:UserVO = null;
			var userArr:Array = convertVectorToArray( _users );
			//trace( GlobalData.userName + " >>>>>>>>>>>>> " + ObjectUtil.toString( newUsers ) );
			//debug( GlobalData.userName + " >>>>>>>>>>>>> " + ObjectUtil.toString( newUsers ) );
			
			// 새로운 User추가
			for each ( var obj:Object in newUsers )
			{
				if ( !hasExistID(obj.userID, userArr) )
				{
					userVO = new UserVO( obj );
					StreamManager.getInstance().addIncomingStream(userVO.userID, userVO.mediaVO);
					setUserList( userVO, true );
					_users.push( userVO );
					dispatchEvent(new UserEvent(UserEvent.USER_ADD, userVO));
				}
			}
			
			// 퇴장하거나 User가 없으면 삭제
			for each ( var user:UserVO in _users )
			{
				if ( !hasExistID(user.userID, newUsers) )
				{
					userVO = user;
					setUserList( user, false );
					
					var index:int = _users.indexOf(user);
					if (index > -1)
					{
						_users.splice(index, 1);
						StreamManager.getInstance().removeIncomingStream(userVO.userID);
					}
					else
					{
						if(isDebug) debug("Participants remove error");
					}
					dispatchEvent(new UserEvent(UserEvent.USER_REMOVE, userVO));
				}
			}
		}
		
		public function closeSession():void
		{
			_users=new Vector.<UserVO>();
		}
		
		private function setUserList( userVO:UserVO, isAdd:Boolean ):void
		{
			//trace( GlobalData.userName + " | setUserList userName : " + userVO.userName + " | setUserList userType : " + userVO.userType + " | setUserList userLevel : " + userVO.userLevel + " | setUserList mode : " + userVO.mode + "  | isAdd :" + isAdd );
			if ( userVO.mode == ConstData.USER_STATE_OBSERVER )
			{
				if ( GlobalData.userID == userVO.userID ) GlobalData.userVO = userVO;
				return;
			}
			
			if ( isAdd )
			{
				var removeUserVO:UserVO = null;
				// 비디오 목록 유저가 최대치일 경우 최초 입장자 제거
				if ( GlobalData.videoUserList.length >= ConstData.VIDEO_USER_MAX )
				{
					removeUserVO = getRemoveUserVO();
					GlobalData.videoUserList.removeItem( removeUserVO );
					GlobalData.mobileVideoUserList.removeItem( removeUserVO );
					
					removeUserVO.mediaVO.isVideoView = removeUserVO.mediaVO.isVideoControl = false;
					//trace( GlobalData.userName + "   removeUserVO.userName : " + removeUserVO.userName );
					
				}
				
//				// 모바일 UserList
//				if ( GlobalData.mobileVideoUserList.length >= ConstData.VIDEO_USER_MAX )
//				{
//					removeUserVO = GlobalData.mobileVideoUserList.getItemAt( 0 ) as UserVO;
//					GlobalData.mobileVideoUserList.removeItem( removeUserVO );
//					removeUserVO.mediaVO.isVideoView = removeUserVO.mediaVO.isVideoControl = false;
//				}

				
				// 자기 자신을 목록의 최상위에 놓는다
				if ( GlobalData.userID == userVO.userID )
				{
					userVO.mediaVO.isVideoView = true;
					userVO.mediaVO.isVideoControl = false;
					
					//trace( GlobalData.userID + " ==============[ 1 " + userVO.userName + " ]  userVO.mediaVO.isVideoView : " + userVO.mediaVO.isVideoView + "  userVO.mediaVO.isVideoControl : " + userVO.mediaVO.isVideoControl );
					
					GlobalData.allUserList.addItemAt( userVO, 0 );
					GlobalData.videoUserList.addItemAt( userVO, 0 );
					GlobalData.userVO = userVO;
				}
				else
				{
					userVO.mediaVO.isVideoView = userVO.mediaVO.isVideoControl = true;
					
					//trace( GlobalData.userID + " ==============[ 2 " + userVO.userName + " ]  userVO.mediaVO.isVideoView : " + userVO.mediaVO.isVideoView + "  userVO.mediaVO.isVideoControl : " + userVO.mediaVO.isVideoControl );
					
					GlobalData.allUserList.addItem( userVO );
					GlobalData.videoUserList.addItem( userVO );
					if ( userVO.userType != ConstData.DEBATE_TYPE_USER_VISITOR ) 
					{
						GlobalData.mobileVideoUserList.addItem( userVO );
					}
				}
				
				GlobalData.allUserPureList.addItem( userVO );
				
				GlobalData.eq[userVO.userID] = 0; 
				
				if ( userVO.userType == ConstData.DEBATE_TYPE_USER_MC ) 
				{
					GlobalData.debateMCList.addItem( userVO );
				}
				if ( userVO.userType == ConstData.DEBATE_TYPE_USER_SECONDER ) 
				{
					GlobalData.debateUserList.addItemAt( userVO, 0 );
				}
				if ( userVO.userType == ConstData.DEBATE_TYPE_USER_DISSENTER ) 
				{
					GlobalData.debateUserList.addItem( userVO );
				}
			}
			else
			{
				GlobalData.allUserList.removeItem( userVO );
				GlobalData.videoUserList.removeItem( userVO );
				GlobalData.mobileVideoUserList.removeItem( userVO );
				GlobalData.allUserPureList.removeItem( userVO );
				
				delete GlobalData.eq[userVO.userID];
				
				if ( userVO.userType == ConstData.DEBATE_TYPE_USER_MC )
				{
					GlobalData.debateMCList.removeItem( userVO );
				}
				if ( userVO.userType == ConstData.DEBATE_TYPE_USER_SECONDER )
				{
					GlobalData.debateUserList.removeItem( userVO );
				}
				if ( userVO.userType == ConstData.DEBATE_TYPE_USER_DISSENTER )
				{
					GlobalData.debateUserList.removeItem( userVO );
				}
			}
			
			//trace( "GlobalData.allUserPureList : " + ObjectUtil.toString( GlobalData.allUserPureList ) );
			//trace( "GlobalData.allUserList : " + ObjectUtil.toString( GlobalData.allUserList ) );
			//trace( "GlobalData.roomVO.userList : " + ObjectUtil.toString( GlobalData.roomVO.userList ) );
			
			GlobalData.setIsVideoControl();
			GlobalData.setPowerUserList();
			
			//trace( "==============[ " + userVO.userName + " ]  userVO.mediaVO.isVideoView : " + userVO.mediaVO.isVideoView + "  userVO.mediaVO.isVideoControl : " + userVO.mediaVO.isVideoControl );
			
			try {
				masterManager.interfaceManager.changeUserList();
				//trace( "masterManager.interfaceManager.changeUserList()" );
			} catch ( error:Error ) { 
				//trace( "changeUserList call error" );
			}

			try {
				masterManager.interfaceManager.changeLayoutVO();
				//trace( "masterManager.interfaceManager.changeLayoutVO()" );
			} catch ( error:Error ) { 
				//trace( "changeLayoutVO call error" );
			}
		}
		
		private function getRemoveUserVO():UserVO
		{
			var len:int = GlobalData.videoUserList.length;
			var removeUserVO:UserVO = null;
			for ( var i:int=0; i<len; i++ )
			{
				removeUserVO = GlobalData.videoUserList.getItemAt( i ) as UserVO;
				if ( removeUserVO.userID == GlobalData.userID ) continue;
				else											break;
			}
			
			return removeUserVO;
		}
		
	}
}

class PrivateClass
{
	public function PrivateClass() {}
}