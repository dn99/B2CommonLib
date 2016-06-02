////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.containers
{
	import com.b2max.blazeds.AMFServiceManager;
	import com.b2max.blazeds.BlazedsConstant;
	import com.b2max.common.data.ConnectData;
	import com.b2max.common.data.ConstData;
	import com.b2max.common.data.GlobalData;
	import com.b2max.common.data.InterfaceData;
	import com.b2max.common.domain.FileVO;
	import com.b2max.common.events.StreamEvent;
	import com.b2max.common.events.UserEvent;
	import com.b2max.common.managers.MasterManager;
	import com.b2max.common.managers.NodeJSManager;
	import com.b2max.common.managers.RoomManager;
	import com.b2max.common.managers.StreamManager;
	import com.b2max.common.managers.UserManager;
	import com.b2max.common.managers.WowzaManager;
	import com.b2max.common.ui.vo.LayoutVO;
	import com.b2max.common.utils.CommonUtil;
	import com.b2max.common.utils.JSUtil;
	import com.b2max.common.vo.MediaVO;
	import com.b2max.common.vo.PowerVO;
	import com.b2max.common.vo.RoomVO;
	import com.b2max.common.vo.UserVO;
	import com.b2max.googlestt.events.SpeechAPIEvent;
	import com.b2max.googlestt.managers.STTManager;
	import com.b2max.websocket.events.FlashSocketEvent;
	import com.b2max.websocket.flashsocket.FlashSocket;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.Microphone;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.messaging.events.MessageEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	import spark.components.SkinnableContainer;
	
	
	public class ConnectContainer extends SkinnableContainer
	{ 
		public var isDebug:Boolean;
		
		public var nodejsManager:NodeJSManager;
		public var roomManager:RoomManager;
		public var userManager:UserManager;
		public var masterManager:MasterManager;
		public var wowzaManager:WowzaManager;
		public var streamManager:StreamManager;
		public var sttManager:STTManager;
		
		[Bindable] public var layoutList:ArrayList;
		[Bindable] public var isPowerModeControl:Boolean;
		
		private var _isSTT:Boolean;
		
		

		public function get isSTT():Boolean
		{
			return _isSTT;
		}

		public function set isSTT(value:Boolean):void
		{
			_isSTT = value;
			sttManager.setGoogleSTT(_isSTT);
		}

		public function get socket():FlashSocket
		{
			//trace(className + " **************************************** " + nodejsManager);
			//if ( !nodejsManager ) return null;
			return nodejsManager.socket;
		}
		public function set socket( value:FlashSocket ):void
		{
			nodejsManager.socket = value;
		}
		
		public function closeSocket():void
		{
			nodejsManager.disConnectToNodeJS();
		}
		
		public function destroyInstance():void
		{
			//trace( "  :: destroyInstance :::::::::: " + className );
			removeSocketEventListeners();
			
			nodejsManager.removeEventListener(NodeJSManager.CONNECTION_SUCCESS, onNodeJSConnectionSuccessHandler, false);
			nodejsManager.removeEventListener(NodeJSManager.CONNECTION_CLOSE_NORMAL, onNodeJSConnectionCloseNormalHandler, false);
			nodejsManager.removeEventListener(NodeJSManager.CONNECTION_CLOSE_ABNORMAL, onNodeJSConnectionCloseAbnormalHandler, false);
			nodejsManager.removeEventListener(NodeJSManager.CONNECTION_ERROR, onNodeJSConnectionErrorHandler, false);
			
			wowzaManager.removeEventListener(WowzaManager.CONNECT_SUCCESS, onWowzaConnectSuccessHandler, false);
			wowzaManager.removeEventListener(WowzaManager.CONNECT_CLOSED, onWowzaConnectClosedHandler, false);
			wowzaManager.removeEventListener(WowzaManager.CONNECT_FAILED, onWowzaConnectFailedHandler, false);
			
			streamManager.removeEventListener(StreamEvent.SENDMEDIASTATE, onSendMediaStateHandler, false);
			streamManager.removeEventListener(StreamEvent.STREAM_PUBLISH_VIDEO, onStreamPublishVideoHandler, false);
			streamManager.removeEventListener(StreamEvent.STREAM_PLAY_START, onStreamPlayStartHandler, false);
			streamManager.removeEventListener(StreamEvent.STREAM_PLAY_STOP, onStreamPlayStopHandler, false);
			
			sttManager.removeEventListener(SpeechAPIEvent.STT_COMPLETE, sttCompleteHandler);
			// socket 이벤트 리스너는 제거 되었지만 시간차로 이벤트가 리스닝되어 해당 매니저를 못찾는 경우 모니터링
			//문제발생시 해당 매니저 null 주석 처리
			//nodejsManager = null;
			//roomManager = null;
			//userManager = null;
			//wowzaManager = null;
			//masterManager = null;
			
			layoutList = null;
		}
		
		/**
		 * Manager 생성 
		 */
		public function ConnectContainer():void
		{
			//trace(className + " **************************************** ");
			nodejsManager = NodeJSManager.getInstance();
			nodejsManager.addEventListener(NodeJSManager.CONNECTION_SUCCESS, onNodeJSConnectionSuccessHandler, false, 0, true);
			nodejsManager.addEventListener(NodeJSManager.CONNECTION_CLOSE_NORMAL, onNodeJSConnectionCloseNormalHandler, false, 0, true);
			nodejsManager.addEventListener(NodeJSManager.CONNECTION_CLOSE_ABNORMAL, onNodeJSConnectionCloseAbnormalHandler, false, 0, true);
			nodejsManager.addEventListener(NodeJSManager.CONNECTION_ERROR, onNodeJSConnectionErrorHandler, false, 0, true);
			
			wowzaManager = WowzaManager.getInstance();
			wowzaManager.addEventListener(WowzaManager.CONNECT_SUCCESS, onWowzaConnectSuccessHandler, false, 0, true);
			wowzaManager.addEventListener(WowzaManager.CONNECT_CLOSED, onWowzaConnectClosedHandler, false, 0, true);
			wowzaManager.addEventListener(WowzaManager.CONNECT_FAILED, onWowzaConnectFailedHandler, false, 0, true);
			
			roomManager = RoomManager.getInstance();
			userManager = UserManager.getInstance();
			userManager.addEventListener(UserEvent.USER_ADD, onUserAddHandler);
			userManager.addEventListener(UserEvent.USER_REMOVE, onUserRemoveHandler);
			
			masterManager = MasterManager.getInstance();
			
			userManager.masterManager = masterManager;
			roomManager.masterManager = masterManager;
			
			streamManager = StreamManager.getInstance();
			streamManager.addEventListener(StreamEvent.SENDMEDIASTATE, onSendMediaStateHandler, false, 0, true);
			streamManager.addEventListener(StreamEvent.STREAM_PUBLISH_VIDEO, onStreamPublishVideoHandler, false, 0, true);
			streamManager.addEventListener(StreamEvent.STREAM_PLAY_START, onStreamPlayStartHandler, false, 0, true);
			streamManager.addEventListener(StreamEvent.STREAM_PLAY_STOP, onStreamPlayStopHandler, false, 0, true);
			
			sttManager = STTManager.getInstance();
			sttManager.addEventListener(SpeechAPIEvent.STT_COMPLETE, sttCompleteHandler);
			
			
			AMFServiceManager.messageBroker = ConnectProperties.MESSAGE_BROKER;
			
			initSocketEventListeners();
		}
		
		
		/**
		 * User입장시 채팅창에 입장을 표시하기 위함 
		 */
		protected function onUserAddHandler(event:UserEvent):void
		{
			onUserAdd(event.user);
		}		

		
		/**
		 * User입장시 채팅창에 퇴장을 표시하기 위함 
		 */
		protected function onUserRemoveHandler(event:UserEvent):void
		{
			onUserRemove(event.user);
		}
		
		
		protected function onStreamPublishVideoHandler(event:StreamEvent):void
		{
			onStreamPublishVideo(event.userID);
		}
		
		protected function onStreamPlayStartHandler(event:StreamEvent):void
		{
			onStreamPlayStart(event.userID);	
		}
		
		protected function onStreamPlayStopHandler(event:StreamEvent):void
		{
			onStreamPlayStop(event.userID);
		}
		
		public function initLayoutVO():void
		{
			//trace("------------- initLayoutVO " + GlobalData.userName + "    GlobalData.userLevel : " + GlobalData.userLevel + "     " + GlobalData.userType);
			// 방장이면 Layout을 세팅하고, 아니면 저장된 Layout을 가져온다.
			if ( GlobalData.userLevel == ConstData.USER_LEVEL_SUPER )
			{
				setLayoutList();
				isPowerModeControl = true;
			}
			else
			{
				//trace("userType : " + GlobalData.roomVO.roomInfoVO.userType + "     " + GlobalData.userType);
				joinRoom( GlobalData.roomID, GlobalData.userType );
				isPowerModeControl = false;
			}
			
			getLayoutList();
		}
		
		public function setLayoutList():void
		{
			//trace( "setLayoutList ::::::::: GlobalData.designUI : " + GlobalData.designUI );
			layoutList = GlobalData.designUI == ConstData.DESIGN_UI_01 ? InterfaceData.getLayoutList01() : InterfaceData.getLayoutList02();
			//trace("layoutList : " + ObjectUtil.toString(layoutList));
			
			var layoutVO:LayoutVO = layoutList.getItemAt( ConstData.DEFAULT_MODE_INDEX ) as LayoutVO;
			
			setLayout(layoutVO);
		}
		
		public function setRoomVO( roomVO:RoomVO ):void
		{
			//if(localDebug) debug( ">>>>>>>>>>> setRoomVO roomVO : " + ObjectUtil.toString(roomVO) );
			
			// 단품 패키지를 위해 타입명을 통하여 메인타입명 정의
			roomVO.roomMainType = InterfaceData.getRoomMainType( roomVO.roomType );
			
			GlobalData.roomVO = roomVO;
			GlobalData.roomID = roomVO.roomID;
			
			// roomInfoVO는 토론에만 존재.
			if ( roomVO.roomInfoVO ) 
			{
				var debateItemList:Array = GlobalData.roomVO.roomInfoVO.debateItemList;
				GlobalData.roomVO.roomInfoVO.debateItemList = InterfaceData.getDebateItemList( debateItemList );
				GlobalData.userType = roomVO.roomInfoVO.userType;
			}
		}
		
		public function setRegister():void
		{
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO08. setRegister() ", 1, this);
			
			var userVO:UserVO = new UserVO();
			userVO.userID = GlobalData.userID;
			userVO.userName = GlobalData.userName;
			userVO.userLevel = GlobalData.userLevel;
			userVO.userType = GlobalData.userType;
			userVO.mode = GlobalData.MODE;
			userVO.lobbyID = GlobalData.lobbyID;
			
			//userVO.ip = ""; // IP는 서버사이드에서 대입
			userVO.os = Capabilities.os;
			userVO.language = Capabilities.language;
			userVO.platformVersion = Capabilities.version;
			
			//trace("setRegister : " + ObjectUtil.toString(userVO.powerVO));
			
			// 서버등록을 분기처리 하는 이유는, joinLobby()하는 시점때문이다. 모바일은 LobbyComp의 initialize시점에 호출하고, Web은 
			// 서버로부터 userID를 받아오는 핸들러(onGetUserIDWeb)에서 실행한다.
			if(Capabilities.version.substr(0,3) == "WIN")
			{
				// 윈도우 
				userVO.host = JSUtil.host;
				userVO.osBit = JSUtil.osBit;
				userVO.browser = JSUtil.browser;
				userVO.browserVersion = JSUtil.browserVersion;
				registerWeb(userVO);
			}
			else if(Capabilities.version.substr(0,3) == "AND")
			{
				// 안드로이드
				register(userVO);
			}
			else if(Capabilities.version.substr(0,3) == "IOS")
			{
				// 아이폰				
			}
			else if(Capabilities.version.substr(0,3) == "QNX")
			{
				// 블랙베리			
			}
			//debug("code5381 8. setRegister() " + ObjectUtil.toString(userVO), 1, this);
			
		}
		
		//////////////////////////// NodeJS 통신 구현 시작 /////////////////////////////		
		
		/**
		 * 1. 매니저 초기화 
		 */
		public function connectNodeJS():void
		{
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO06. connectNodeJS()", 1, this);
			//trace("code5381 6. connectNodeJS()");
			nodejsManager.initSocket();	
			nodejsManager.connect();
			//userManager.socket = socket;
			//roomManager.socket = socket;
		}
		
		/**
		 * 2. Node.JS 서버연결 성공시
		 */
		private function onNodeJSConnectionSuccessHandler(event:Event):void
		{
			//trace("code5381 6. onNodeJSConnectionSuccessHandler()");
			initSocketEventListeners(); // NodeJS서버에서 호출될 소켓이벤트 정의
			onNodeJSConnectSuccess();
			userManager.socket = socket;
			roomManager.socket = socket;
			streamManager.socket = socket;
			
		}
		
		/**
		 * NodeJS 정상종료 
		 */
		protected function onNodeJSConnectionCloseNormalHandler(event:Event):void
		{
			onNodeJSCloseNormal();
		}
		
		/**
		 * NodeJS 비정상종료 
		 */
		private function onNodeJSConnectionCloseAbnormalHandler(event:Event):void
		{
			onNodeJSConnectionCloseAbnormal();
		}
		
		/**
		 * NodeJS 접속실패 
		 */
		private function onNodeJSConnectionErrorHandler(event:Event):void
		{
			onNodeJSConnectionError();
		}		
		//---------------------- NodeJS 구현 시작 -----------------------//		
		
		/**
		 * 3. Login에 성공하면 접속하여 User를 등록한다. 
		 */
		private function register(userInfo:Object):void
		{
			if ( socket ) socket.emit("register", userInfo, onGetUserID);
		}
		
		private function registerWeb(userInfo:Object):void
		{
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO09. registerWeb() - 서버등록요청 및 userID받아옴", 1, this);
			if ( socket ) socket.emit("register", userInfo, onGetUserIDWeb);
		}
		
		
		/**
		 * 4. 서버 등록이 완료되면 로비에 입장한다. 
		 */
		public function joinLobby(roomID:String):void
		{
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO11. joinLobby() - Lobby입장 : " + roomID, 1, this);
			socket.emit("joinLobby", roomID);
		}
		
		public function joinRoom(roomID:String, userType:int=-1):void
		{
			var joinInfo:Object = {};
			joinInfo.roomID = roomID;
			joinInfo.userType = userType;
			joinInfo.mode = GlobalData.MODE;
			joinInfo.storagePath = ConnectProperties.STORAGEPATH;
			//trace( GlobalData.userName + " | joinInfo.mode : " + joinInfo.mode );
			if ( socket ) socket.emit("joinRoom", joinInfo);
			//connectWowza(joinInfo.roomID);
		}
		
		protected function getRoomID(callback:Function):void
		{
			if ( socket ) socket.emit("getRoomID", null, callback);
		}
		
		protected function killRemoteUser():void
		{
			if ( socket ) socket.emit("killRemoteUser");
		}
		
		
		protected function doCreateRoom(roomVO:RoomVO, callback:Function):void
		{
			//if ( socket ) socket.emit("createRoom", roomVO, onGetRoomID);
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO18. 방생성 - createRoom호출");
			if ( socket ) socket.emit("createRoom", roomVO, callback);
		}
		
		protected function setLayout(layoutObj:Object):void
		{
			if ( socket ) socket.emit("setLayout", layoutObj);
		}
		
		protected function getLayoutList():void
		{
			if ( socket ) socket.emit("getLayout", null, onGetLayoutList);
		}
		
		protected function setSharedUserLevel(userLevelObj:Object):void
		{
			if ( socket ) socket.emit("setSharedUserLevel", userLevelObj);
		}
		
		protected function setSharedPower(powerObj:Object):void
		{
			if ( socket ) socket.emit("setSharedPower", powerObj);
		}
		
		// 채팅메시지를 보낸다.
		protected function sendMessage(msg:Object):void
		{
			if ( socket ) socket.emit("sendMessage", msg);
		}
		
		// 미디어 on/off상태를 공유한다.
		protected function sendMediaState(mediaVO:MediaVO):void
		{
			if ( socket ) socket.emit("sendMediaState", mediaVO);
		}
		
		// 문서목록을 가져온다.
		protected function getDocList():void
		{
			if ( socket ) socket.emit("getDocList", ConnectProperties.STORAGEPATH);
		}
		
		// 문서변환 완료 후, 업로드한 문서목록을 공유시킨다.
		protected function updateDoc(uploadedFileName:String, swfFileName:String, totalPage:int):void
		{
			debug("uploadedFileName : " + uploadedFileName + " , swfFileName : " + swfFileName + ", totalPage : " + totalPage.toString());
			if ( socket ) socket.emit("updateDoc", {storagePath: ConnectProperties.STORAGEPATH, uploadedFileName: uploadedFileName, swfFileName: swfFileName, totalPage: totalPage});
		}
		
		// 문서삭제
		protected function updateDeleteDoc(doc:Object):void
		{
			if ( socket ) socket.emit("deleteDoc", doc);
		}
		
		// 화면공유 준비 알림 : 한명이 화면공유를 시작하면 다른 방 참석자들은 공유하지 못하도록 한다.
		protected function startScreenShareApplet():void
		{
			if ( socket ) socket.emit("startScreenShareApplet");
		}
		
		// 다른User가 화면공유요청중, 혹은 화면공유중인지 체크. 없으면 우선권 획득
		protected function chechkIsScreenSharing(isRDC:Boolean, callback:Function):void
		{
			if ( socket ) socket.emit("chechkIsScreenSharing", isRDC, callback);
		}
		
		// 화면공유 중 원격제어 요청
		protected function requestScreenControl():void
		{
			if ( socket ) socket.emit("requestScreenControl");
		}
		
		
		protected function allowScreenControl(requestUserID:String, isAllow:Boolean):void
		{
			if ( socket ) socket.emit("allowScreenControl", {requestUserID: requestUserID, isAllow: isAllow});
		}
		
		// 화면공유 시작 알림
		protected function startScreenShare(screenshareInfo:Object):void
		{
			if ( socket ) socket.emit("startScreenShare", screenshareInfo);
		}
		
		// 화면공유 중지 알림
		protected function stopScreenShare():void
		{
			if ( socket ) socket.emit("stopScreenShare");
		}
		
		// 화면공유중 사이즈 변경을 했을경우, 그 정보를 서버에 업데이트 시킨다.
		protected function updateScreenSize(sizeInfo:Object):void
		{
			if ( socket ) socket.emit("updateScreenSize", sizeInfo);
		}
		
		// 원격제어 요청
		protected function requestRDC(userID:String):void
		{
			if ( socket ) socket.emit("requestRDC", userID);
		}
		
		protected function allowRDC(isAllow:Boolean, userID:String):void
		{
			if ( socket ) socket.emit("allowRDC", {isAllow: isAllow, userID: userID});
		}
		
		
		// 채팅History를 받아온다. 
		protected function getChatHistory(callback:Function):void
		{
			if ( socket ) socket.emit("getChatHistory", null, callback);
		}
		
		protected function getServerTime(callback:Function):void
		{
			if ( socket ) socket.emit("getServerTime", null, callback);
		}
		
		// 번역토글상태 on/off (다른User와 공유되는값이 아님)
		protected function setSTT(userID:String, selected:Boolean):void
		{
			sttManager.setSTT(userID, selected);
		}

		// 음성인식 완료 
		protected function sttCompleteHandler(event:SpeechAPIEvent):void
		{
			onSttComplete(event.data);
		}
		
		
		protected function shareSTTResult(result:String):void
		{
			debug("음성인식 완료 : " + result);
			if ( socket ) socket.emit("shareSTT", result);
		}
		
		// SERVER CALL - 번역토글상태 공유
		protected function callViewTrans( isSelected:Boolean ):void
		{
			if ( socket ) socket.emit( "callViewTrans", isSelected );
		}
		
		// SERVER CALL - 토론 설정 요청
		protected function callDebateItemList( debateItemListInfo:Object ):void
		{
			if ( socket ) socket.emit( "callDebateItemList", debateItemListInfo );
		}
		
		// SERVER CALL - 토론 진행 요청
		protected function callControlDebateItemList( controlDebate:String ):void
		{
			if ( socket ) socket.emit( "callControlDebateItemList", controlDebate );
		}
		
		// SERVER CALL - 찬반투표 요청
		protected function callDebateVoteRequest():void
		{
			if ( socket ) socket.emit( "callDebateVoteRequest", ConstData.DEBATE_VOTE_YESNO );
		}
		
		// SERVER CALL - 찬반투표 결과 요청
		protected function callDebateVoteResult( voteYesNo:int=-1 ):void
		{
			if ( socket ) socket.emit( "callDebateVoteResult", voteYesNo );
		}
		
		// SERVER CALL - 발언권 요청
		protected function callDebateSpeakRequest( userInfo:Object ):void
		{
			if ( socket ) socket.emit( "callDebateSpeakRequest", userInfo );
		}
		
		// SERVER CALL - 발언권 요청 승인
		protected function callDebateSpeakAllow( requestUserID:String ):void
		{
			if ( socket ) socket.emit( "callDebateSpeakAllow", requestUserID );
		}
		
		// 토론 결과지 보냄
		protected function sendDebateReport(report:String):void
		{
			//trace( GlobalData.userName + " ::::::: GlobalData.userType : " + GlobalData.userType );
			if ( socket ) socket.emit( "sendDebateReport", {report:report, userType: GlobalData.userType} );
		}
		
		private function removeSocketEventListeners():void
		{
			if(!nodejsManager) return;
			if ( !socket ) return;
			
			//trace("removeSocketEventListeners()", this);
			socket.off("updateUserlist", onUpdateUserListHandler);
			socket.off("updateLobbyUserlist", onUpdateLobbyUserlistHandler);
			socket.off("updateRoomList", onUpdateRoomListHandler);
			socket.off("layoutUpdate", onUpdateLayoutHandler);
			socket.off("sharedUserLevel", onSharedUserLevelHandler);
			socket.off("sharedPower", onSharedPowerHandler);
			socket.off("receiveMessage", onReceiveMessageHandler);
			socket.off("receiveChatHistory", onReceiveChatHistoryHandler);
			socket.off("isTyping", onIsTypingHandler);
			socket.off("updateMediaState", onUpdateMediaStateHandler);
			socket.off("updateDocList", onUpdateDocListHandler);
			socket.off("receiveMicLevel", onReceiveMicLevelHandler);
			socket.off("receiveDebateReport", onReceiveDebateReportHandler);
			socket.off("receiveStartScreenShare", onReceiveStartScreenShareHandler);
			socket.off("receiveStopScreenShare", onReceiveStoptScreenShareHandler);
			socket.off("receiveRequestScreenControl", onReceiveRequestScreenControlHandler);
			socket.off("receiveAllowScreenControl", onReceiveAllowScreenControlHandler);
			socket.off("receiveRequestRDC", onReceiveRequestRDCHandler);
			socket.off("receiveAllowRDC", onReceiveAllowRDCHandler);
			socket.off("notifyRequesting", onNotifyRequestingHandler);
			socket.off("receiveSTTResult", onReceiveSTTResultHandler);
			
			socket.off("callClientViewTrans", callClientViewTransHandler);
			socket.off("callClientDebateItemList", callClientDebateItemListHandler);
			socket.off("callClientControlDebateItemList", callClientControlDebateItemListHandler);
			socket.off("callClientDebateVoteRequest", callClientDebateVoteRequestHandler);
			socket.off("callClientDebateVoteResult", callClientDebateVoteResultHandler);
			socket.off("callClientDebateSpeakRequest", callClientDebateSpeakRequestHandler);
			socket.off("callClientDebateSpeakAllow", callClientDebateSpeakAllowHandler);
		}
		
	
		
		/**
		 * NodeJS서버에서 호출될 소켓이벤트리스너 정의 
		 */
		private function initSocketEventListeners():void
		{
			if ( !socket ) return;
			
			socket.on("updateUserlist", onUpdateUserListHandler);
			socket.on("updateLobbyUserlist", onUpdateLobbyUserlistHandler);
			socket.on("updateRoomList", onUpdateRoomListHandler);
			socket.on("layoutUpdate", onUpdateLayoutHandler);
			socket.on("sharedUserLevel", onSharedUserLevelHandler);
			socket.on("sharedPower", onSharedPowerHandler);
			socket.on("receiveMessage", onReceiveMessageHandler);
			socket.on("receiveChatHistory", onReceiveChatHistoryHandler);
			socket.on("isTyping", onIsTypingHandler);
			socket.on("updateMediaState", onUpdateMediaStateHandler);
			socket.on("updateDocList", onUpdateDocListHandler);
			socket.on("receiveMicLevel", onReceiveMicLevelHandler);
			socket.on("receiveDebateReport", onReceiveDebateReportHandler);
			socket.on("killedSession", onKilledSessionHandler);
			socket.on("receiveStartScreenShare", onReceiveStartScreenShareHandler);
			socket.on("receiveStopScreenShare", onReceiveStoptScreenShareHandler);
			socket.on("receiveRequestScreenControl", onReceiveRequestScreenControlHandler);
			socket.on("receiveAllowScreenControl", onReceiveAllowScreenControlHandler);
			socket.on("receiveRequestRDC", onReceiveRequestRDCHandler);
			socket.on("receiveAllowRDC", onReceiveAllowRDCHandler);
			socket.on("notifyRequesting", onNotifyRequestingHandler);
			socket.on("receiveSTTResult", onReceiveSTTResultHandler);
			
			socket.on("callClientViewTrans", callClientViewTransHandler);
			socket.on("callClientDebateItemList", callClientDebateItemListHandler);
			socket.on("callClientControlDebateItemList", callClientControlDebateItemListHandler);
			socket.on("callClientDebateVoteRequest", callClientDebateVoteRequestHandler);
			socket.on("callClientDebateVoteResult", callClientDebateVoteResultHandler);
			socket.on("callClientDebateSpeakRequest", callClientDebateSpeakRequestHandler);
			socket.on("callClientDebateSpeakAllow", callClientDebateSpeakAllowHandler);
		}
		
		private function onReceiveSTTResultHandler(event:FlashSocketEvent):void
		{
			onReceiveSTT(event.data[0]);
		}
		
		private function onNotifyRequestingHandler(event:FlashSocketEvent):void
		{
			GlobalData.isScreenSharing = event.data[0];
			debug("onNotifyRequestingHandler() - " + GlobalData.isScreenSharing);
		}
		
		private function onReceiveAllowRDCHandler(event:FlashSocketEvent):void
		{
			onReceiveAllowRDC(event.data[0]);
		}
		
		
		/**
		 * 원격제어 요청을 받는다. 
		 */
		private function onReceiveRequestRDCHandler(event:FlashSocketEvent):void
		{
			onReceiveRequestRDC(event.data[0]);
		}
		
		private function onReceiveAllowScreenControlHandler(event:FlashSocketEvent):void
		{
			onReceiveAllowScreenControl(event.data[0]);
		}
		
		/**
		 * 원격제어 요청을 받음 
		 */
		private function onReceiveRequestScreenControlHandler(event:FlashSocketEvent):void
		{
			onReceiveRequestScreenControl(event.data[0]);
		}
		
		/**
		 * 화면공유 종료정보받음 
		 */
		private function onReceiveStoptScreenShareHandler(event:FlashSocketEvent):void
		{
			onReceiveStoptScreenShare();
		}
		
		/**
		 * 화면공유 시작정보받음
		 */
		private function onReceiveStartScreenShareHandler(event:FlashSocketEvent):void
		{
			onReceiveStartScreenShare(event.data[0]);
		}
		
		/**
		 * 원격지로부터 세션이 강제로 끊김 
		 */
		private function onKilledSessionHandler(event:FlashSocketEvent):void
		{
			onKilledSession();			
		}
		
		/**
		 * 토론 결론부분을 받음 
		 */
		private function onReceiveDebateReportHandler(event:FlashSocketEvent):void
		{
			onReceiveDebateReport(event.data[0]);
		}
		
		/**
		 * 이퀄라이저 정보를 받는다. 
		 */
		private function onReceiveMicLevelHandler(event:FlashSocketEvent):void
		{
			onReceiveMicLevel(event.data[0]);
		}
		
		private function onUpdateUserListHandler(event:FlashSocketEvent):void 
		{
			//debug("onUpdateUserListHandler()");
			onUpdateUserList(event.data[0] as Array);
		}
		
		public function doUpdateUserList(users:Array):void
		{
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO19. doUpdateUserList - 해당Room의 userList를 업데이트", 1, this);
			if ( userManager ) userManager.updateUserList(users);
		}
		
		private function onUpdateLobbyUserlistHandler(event:FlashSocketEvent):void 
		{
			onUpdateLobbyUserlist(event.data[0] as Array);
		}
		
		public function doUpdateLobbyUserlist(users:Array):void
		{
			if ( userManager ) userManager.updateLobbyUserlist(users);
		}
		
		private function onUpdateRoomListHandler(event:FlashSocketEvent):void 
		{
			//debug("onUpdateRoomListHandler() --- " + className, 1, this);
			onUpdateRoomList( event.data );
		}
		
		private function onUpdateLayoutHandler(event:FlashSocketEvent):void 
		{
			onUpdateLayout( event.data[0] );
		}
		
		private function onSharedUserLevelHandler(event:FlashSocketEvent):void 
		{
			onSharedUserLevel( event.data[0] );
		}
		
		private function onSharedPowerHandler(event:FlashSocketEvent):void 
		{
			onSharedPower( event.data[0] );
		}
		
		private function onReceiveMessageHandler(event:FlashSocketEvent):void 
		{
			onReceiveMessage( event.data[0] );
		}
		
		private function onReceiveChatHistoryHandler(event:FlashSocketEvent):void 
		{
			onReceiveChatHistory( event.data[0] );
		}
		
		private function onIsTypingHandler(event:FlashSocketEvent):void 
		{
			onIsTyping( event.data[0] );
		}
		
		private function callClientViewTransHandler(event:FlashSocketEvent):void 
		{
			callClientViewTrans( event.data[0] );
		}
		
		private function callClientDebateItemListHandler(event:FlashSocketEvent):void 
		{
			callClientDebateItemList( event.data[0] as Array );
		}
		
		private function callClientControlDebateItemListHandler(event:FlashSocketEvent):void 
		{
			callClientControlDebateItemList( event.data[0] );
		}
		
		private function callClientDebateVoteRequestHandler(event:FlashSocketEvent):void 
		{
			callClientDebateVoteRequest( event.data[0] as int );
		}
		
		private function callClientDebateVoteResultHandler(event:FlashSocketEvent):void 
		{
			callClientDebateVoteResult( event.data[0] );
		}
		
		private function callClientDebateSpeakRequestHandler(event:FlashSocketEvent):void 
		{
			callClientDebateSpeakRequest( event.data[0].toString() );
		}
		
		private function callClientDebateSpeakAllowHandler(event:FlashSocketEvent):void 
		{
			callClientDebateSpeakAllow();
		}
		
		
		private function onUpdateMediaStateHandler(event:FlashSocketEvent):void 
		{
			onUpdateMediaState(event.data[0]);
		}
		
		private function onUpdateDocListHandler(event:FlashSocketEvent):void 
		{
			onUpdateDocList(event.data[0]);
		}
		
		// 각 컴포넌트에서 override받을 함수 정의
		public function onUpdateRoomList(rooms:Object):void {}
		public function onUpdateLayout(layoutInfo:Object):void {}
		public function onSharedUserLevel(userLevelInfo:Object):void {}
		public function onSharedPower(powerInfo:Object):void {}
		public function onReceiveMessage(msg:Object):void{}
		public function onReceiveChatHistory(messageHistory:Object):void{}
		public function onIsTyping(typingInfo:Object):void{}
		public function onUpdateMediaState(mediaState:Object):void{}
		public function onUpdateDocList(docInfo:Object):void{}
		
		protected function onNodeJSConnectSuccess():void {}
		protected function onNodeJSCloseNormal():void {}
		protected function onNodeJSConnectionError():void{}
		protected function onNodeJSConnectionCloseAbnormal():void{}
		protected function onKilledSession():void{}
		
		public function onWowzaConnectSuccess():void{}
		public function onWowzaConnectClose():void{}
		public function onWowzaConnectFailed():void{}
		
		public function onSendMediaState():void{}
		public function onUpdateUserList(users:Array):void{}
		public function onUpdateLobbyUserlist(users:Array):void{}
		public function onReceiveMicLevel(micInfo:Object):void{}
		public function onReceiveDebateReport(reportInfo:Object):void{}
		public function onReceiveStartScreenShare(screen:Object):void{}
		public function onReceiveStoptScreenShare():void{}
		public function onReceiveRequestScreenControl(userInfo:Object):void{}
		public function onReceiveAllowScreenControl(isAllow:Boolean):void{}
		public function onReceiveRequestRDC(userInfo:Object):void{}
		public function onReceiveAllowRDC(userInfo:Object):void{}
		
		public function callClientViewTrans( userInfo:Object ):void {}
		public function callClientDebateItemList( debateItemList:Array ):void {}				// 토론타입별 목록
		public function callClientControlDebateItemList( debateItemListInfo:Object ):void {}	// 토론타입별 진행 컨트롤 목록
		public function callClientDebateVoteRequest( voteType:int ):void {}						// 토론 투표요청
		public function callClientDebateVoteResult( debateVoteUserInfo:Object ):void {}			// 토론 투표결과
		public function callClientDebateSpeakRequest( requestUserID:String ):void {}			// 토론 발언권 요청
		public function callClientDebateSpeakAllow():void {}									// 토론 발언권 허용
		
		public function onStreamPlayStart(userID:String):void{}
		public function onStreamPlayStop(userID:String):void{}
		public function onStreamPublishVideo(userID:String):void{}
		
		public function onUserAuthorizedSuccess():void{}
		public function onUserAuthorizedFailed():void{}
		
		public function onUserAdd(userVO:UserVO):void{}
		public function onUserRemove(userVO:UserVO):void{}
		
		public function onSttComplete(result:String):void{}
		public function onReceiveSTT(result:Object):void{}
		//---------------------- NodeJS 구현 끝 -----------------------//		
		
		
		
		
		protected function setLayoutVO( layoutVO:LayoutVO ):void {}
		
		protected function onGetLayoutList(layoutInfo:Object):void
		{
			//trace( ">>>>>>>>>>>>>>>>>>> onGetLayoutList : " + ObjectUtil.toString(layoutInfo) );
			if ( !layoutInfo ) 
			{
				// LMS인 경우 방장권한없는 학생이 먼저 입장 가능하므로 LAYOUT 정보가 없다면 셋팅해준다. 
				setLayoutList();
				return;
			}
			//trace( "onGetLayoutList ::::::::: GlobalData.designUI : " + GlobalData.designUI );
			
			// 신구버전 체크하여 레이아웃 목록을 받는다.
			layoutList = GlobalData.designUI == ConstData.DESIGN_UI_01 ? InterfaceData.getLayoutList01() : InterfaceData.getLayoutList02();
			
			var layoutVO:LayoutVO = InterfaceData.getLayoutVO( layoutInfo );
			setLayoutVO( layoutVO );
		}
		
		/**
		 *	userID를 서버로 부터 받아오면, 다른 접속자들에게 새접속을 알린다.
		 */
		protected function onGetUserID(userID:String):void 
		{
			if (userID == null)
				Alert.show("userID를 가져오는데 실패하였습니다.");
			else
				GlobalData.userID=userID;
		}
		
		protected function onGetUserIDWeb(userID:String, ip:String):void 
		{
			if (userID == "")
			{
				// userID를 가져오는데 실패
				onUserAuthorizedFailed();
				debug("code_LO10. userID를 가져오는데 실패");
			}
			else
			{
				//debug("code5381 11. onGetUserIDWeb() - userID받아오는데 성공 userID: " + userID + ", ip: " + ip, 1, this);
				if(GlobalData.isOlogDebug_Lobby) debug("code_LO10. onGetUserIDWeb() - userID받아오는데 성공", 1, this);
				GlobalData.userID=userID;
				GlobalData.lengthUserID = CommonUtil.getLengthUserName( GlobalData.userID, 10 );
				GlobalData.ip = ip;
				
				onUserAuthorizedSuccess();
				joinLobby(GlobalData.lobbyID);
			}

		
				
			
			// @author 김성윤
//			if(GlobalData.isLMS)
//				joinLMSRoom();
//			else
//				joinLobby(GlobalData.loobyID);
		}
		

		/**
		 * LMS의 경우 로비를 거치지 않고 바로 해당 방으로 접속한다. 
		 */
//		private function joinLMSRoom():void
//		{
//			debug("code5381 12. onGetUserIDWeb() - userID받아오는데 성공", 1, this);
//			joinLobby(GlobalData.loobyID);
//		}
		
		//protected function onGetRoomID(room:Object):void
		//{
		//		var roomID:String = room.roomID;
		//		GlobalData.roomID = roomID;
		//			
		//		//trace( "---------- CREATE ROOM : " + roomID + "   SUPER USER : " + GlobalData.userID );
		//		GlobalData.userLevel = ConstData.USER_LEVEL_SUPER;
		//		
		//		connectWowza(roomID);
		//}
		//////////////////////////// NodeJS SERVER 통신 구현 끝 /////////////////////////////	
		
		
		
		//////////////////////////// 컴포넌트끼리 통신 구현 시작 /////////////////////////////
		
		/**
		 * 유저레벨 변경 공유
		 */ 
		public function updateUserLevelData( userID:String, userLevel:int ):void
		{
			var userLevelObj:Object = {};
			userLevelObj.userID = userID;
			userLevelObj.userLevel = userLevel;
			
//			GlobalData.setUserLevel( userID, userLevel );
			setSharedUserLevel( userLevelObj );
		}
		
		/**
		 * 유저 권한설정 공유
		 */ 
		public function updatePowerData( userID:String, powerVO:PowerVO ):void
		{
			var powerObj:Object = {};
			powerObj.userID = userID;
			powerObj.isPowerChat = powerVO.isPowerChat;
			powerObj.isPowerBoard = powerVO.isPowerBoard;
			powerObj.isPowerDoc = powerVO.isPowerDoc;
			
//			GlobalData.setPower( userID, powerVO );
			setSharedPower( powerObj );
		}
		
		/**
		 * 내 마이크 볼륨조절 
		 */
		protected function changeMyVolume(volume:int):void
		{
			streamManager.changeMicVolume(volume);
		}
		
		/**
		 * 내 스피커 볼륨조절 
		 */
		protected function changeAllVolumes(volume:int):void
		{
			streamManager.changeAllVolumes(volume);
		}
		
		/**
		 * 개개인 user의 볼륨조절 
		 */
		protected function changeUserVolume(userID:String, volume:int):void
		{
			streamManager.changeUserVolume(userID, volume);
			
			for(var i:int=0; i<GlobalData.allUserList.length; i++)
			{
				if(GlobalData.allUserList.getItemAt(i).userID == userID)
				{
					GlobalData.allUserList.getItemAt(i).mediaVO.defaultSpeakerVolume = volume;
				}
			}
		}
		//////////////////////////// 컴포넌트끼리 통신 구현 끝   /////////////////////////////
		
		
		
		
		
		
		
		
		//////////////////////////// MEDIA SERVER 통신 구현 시작 /////////////////////////////		
		
		/**
		 * 1. connect/disconnect to Wowza Streaming Engine.
		 */
		public function connectWowza(roomID:String):void
		{
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO16. connectWowza()", 1, this);
			if(GlobalData.isOlogDebug_Lobby) debug("code_LO16_1. connectWowza() GlobalData.lobbyID : " + GlobalData.lobbyID + ", roomID : " + roomID, 1, this);
			wowzaManager.initNetConnection();
			
			// Room -> Lobby
			if(roomID == GlobalData.lobbyID)
			{
				wowzaManager.close()   
			}
			// Lobby -> Room
			else
			{
				debug("Trying to connect to Wowza server...", 4, this);
				wowzaManager.connect(roomID);
			}
		}
		
		/**
		 *  Room -> Lobby
		 *  wowzaManager에서 접속이 끊기면 RoomContainer.mxml에서 onWowzaConnectClose()함수 override한다.
		 *  onWowzaConnectClose()에서 loginSession의 isLogout속성값을 true로 준다. 
		 *  이 값이 true이면 Lobby로. 아닐경우 로그인팝업창을 띄운다.
		 */
		public function doCloseSession():void
		{
			wowzaManager.close();
			userManager.closeSession();
			GlobalData.allUserList.removeAll();
			GlobalData.videoUserList.removeAll();
			GlobalData.mobileVideoUserList.removeAll();
			GlobalData.allUserPureList.removeAll();
			GlobalData.debateMCList.removeAll();
			GlobalData.debateUserList.removeAll();
			GlobalData.isSendVideo = false;
			GlobalData.isSendAudio = false;
		}
		
		/**
		 * 2. Success to connect Wowza Streaming Engine
		 */
		protected function onWowzaConnectSuccessHandler(event:Event):void
		{
			//trace(className + " Success to connect Wowza Streaming Engine");
			//debug(className + " Success to connect Wowza Streaming Engine");
			onWowzaConnectSuccess();
		}
		
		/**
		 * 미디어서버와 연결이 끊김 
		 */
		protected function onWowzaConnectClosedHandler(event:Event):void
		{
			
			onWowzaConnectClose();
		}
		
		/**
		 * 미디어서버 접속실패 
		 */
		private function onWowzaConnectFailedHandler(event:Event):void
		{
			onWowzaConnectFailed();			
		}		
		
		public function doWowzaConnectSuccess():void
		{
			//debug("Success to connect Wowza Streaming Engine", 4, this);
			streamManager.nc = wowzaManager.getConnection();
			//socket.emit("getUserList");
		}
		
		protected function onSendMediaStateHandler(event:StreamEvent):void
		{
			onSendMediaState();
		}		
		
		public function doSendMediaState(mediaVO:MediaVO):void
		{
			sendMediaState(mediaVO);
		}
		//////////////////////////// MEDIA SERVER 통신 구현 끝 /////////////////////////////	
		
		
		
		
		
		//////////////////////////// AMF 통신 구현 시작 /////////////////////////////
		
		/*************************************************************************************************************
		 * Client -> WAS RPC
		 * @param1 service name
		 * @param2 method name
		 * @param3 parameters
		 * @param4 callback function 
		 */
		public function callAMFRemoteB2confService( methodName:String, argArray:Array=null ):void
		{
			AMFServiceManager.invokeRemote( BlazedsConstant.B2CONF_SERVICE, methodName, argArray, callAMFResultHandler );
		}
		
		public function callAMFRemoteB2talkService( methodName:String, argArray:Array=null ):void
		{
			AMFServiceManager.invokeRemote( BlazedsConstant.B2TALK_SERVICE, methodName, argArray, callAMFResultHandler );
		}
		
		public function callAMFRemoteB2chatService( methodName:String, argArray:Array=null ):void
		{
			AMFServiceManager.invokeRemote( BlazedsConstant.B2CHAT_SERVICE, methodName, argArray, callAMFResultHandler );
		}
		
		protected function callAMFResultHandler( event:ResultEvent ):void 
		{
			var methodName:String = event.headers.toString();
			
			callAMFResultData( methodName, event.result );
		}
		
		public function callAMFResultData( methodName:String, result:Object=null ):void {} // Flex -> WAS함수 호출시 콜백 받을때, 각 컴포넌트에서는 이 함수를 override해서 사용하라.
		
		/*******************************************************************************************************************/
		
		
		/*************************************************************************************************************
		 * WAS -> Client Push 
		 */
		public function reciveAMFPushData( destination:String, subtopic:String="" ):void
		{
			AMFServiceManager.invokeConsumer( destination, reciveAMFMessageHandler, null, subtopic );
		}
		
		protected function reciveAMFMessageHandler( event:MessageEvent ):void 
		{
			reciveAMFMessageData( event.message.destination, event.message.body );
		}
		
		public function reciveAMFMessageData( destination:String, result:Object=null ):void {}	// WAS -> Client Push할때, 각 컴포넌트에서는 이 함수를 override해서 사용하라.
		
		/*******************************************************************************************************************/
		
		//////////////////////////// AMF 통신 구현 끝 /////////////////////////////
		
		
		//////////////////////////// ExternalInterface 구현 시작 /////////////////////////////
		
		/**
		 * 로그아웃. 화면 리플래시 
		 */
		public function callEILogout():void
		{
			if ( ExternalInterface.available ) 
			{
				if ( GlobalData.isLMS ) ExternalInterface.call('closeWindow');
				else					ExternalInterface.call('logout');
			}
		}
		
		/**
		 * JRE 설치체크 
		 */
		public function callEICheckJRE():Boolean
		{
			if ( !ExternalInterface.available )
				Alert.show("지원하지 않는 브라이저 입니다.");
			var installState:Boolean = ExternalInterface.call( "checkJRE");
			return installState;
		}
		
		
		/**
		 * 애플릿 실행 
		 */
		public function callEIStartScreenShareApplet(publisherInfo:String):void
		{
			if ( ExternalInterface.available ) ExternalInterface.call( "startScreenShareApplet" , publisherInfo);
		}
		
		
		public function callEIRightClick( callBackFunction:Function ):void
		{
			if ( ExternalInterface.available ) ExternalInterface.addCallback( "rightClick", callBackFunction );
		}
		
		public function callEIMinimize():void
		{
			if ( ExternalInterface.available ) ExternalInterface.call( "callEIMinimize" );
		}
		
		public function callEIClose():void
		{
			if ( ExternalInterface.available ) 
			{
				ExternalInterface.call('closeWindow');
			}
		}
		
		public function callEIOpenChat( memberInfo:Object ):void
		{
			// COMPLEX OBJECT TYPE 인 경우 Stack overflow occurred 오류발생 WAS CONTROLLER로 데이타 전달
			if ( ExternalInterface.available ) ExternalInterface.call( "callEIOpenChat" );
		}
		
		public function callEIOpenVoice( memberInfo:Object ):void
		{
			// COMPLEX OBJECT TYPE 인 경우 Stack overflow occurred 오류발생 WAS CONTROLLER로 데이타 전달
			if ( ExternalInterface.available ) ExternalInterface.call( "callEIOpenVoice" );
		}
		
		public function callEIControlExpand( isLeft:Boolean, isExpand:Boolean, expandWidth:int ):void
		{
			if ( ExternalInterface.available ) ExternalInterface.call( "callEIControlExpand", isLeft, isExpand, expandWidth );
		}
		
		
		//////////////////////////// ExternalInterface 구현 끝 /////////////////////////////
		
	}
}

