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
	import com.b2max.websocket.events.FlashSocketEvent;
	import com.b2max.websocket.flashsocket.FlashSocket;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class NodeJSManager extends EventDispatcher
	{
		private var isDebug:Boolean = true;
		private static var _instance:NodeJSManager;
		
		public static const CONNECTION_SUCCESS:String = "connectionSuccess";
		public static const CONNECTION_FAILED:String = "connectionFailed";
		public static const CONNECTION_ERROR:String = "connectionError";
		public static const CONNECTION_CLOSE_NORMAL:String = "connectionCloseNormal";
		public static const CONNECTION_CLOSE_ABNORMAL:String = "connectionCloseAbnormal";
		public static const CONNECTION_RECONNECT:String = "connectionReconnect";
		
		private var _socket:FlashSocket;
		public function get socket():FlashSocket
		{
			return _socket; 
		}
		
		public function set socket(value:FlashSocket):void
		{
			_socket = value;
		}
		
		[Bindable]
		private var isConnected:Boolean=false;
		private var unexpectedCloseSessionID:String;
		
		public function NodeJSManager( secure:PrivateClass ) {}
		
		public static function getInstance():NodeJSManager
		{
			if ( !_instance ) _instance = new NodeJSManager( new PrivateClass() );
			
			return _instance;
		}
		
		public static function removeInstance():void
		{
			_instance = null;
		}
		
		public function initSocket():void
		{
			if ( socket ) return;
			socket=new FlashSocket();
			socket.setFlashPolicyPort(ConnectProperties.PORT_FLASH_POLICY);
			socket.on(FlashSocketEvent.CONNECT, onConnect);
			socket.on(FlashSocketEvent.CONNECT_ERROR, onConnectError);
			socket.on(FlashSocketEvent.CLOSE, onClose);
			socket.on(FlashSocketEvent.DISCONNECT, onDisConnect);
			socket.on(FlashSocketEvent.IO_ERROR, onError);
			socket.on(FlashSocketEvent.SECURITY_ERROR, onSecurityError);
			socket.on(FlashSocketEvent.MESSAGE, onMessage);
		}
		
		/**
		 * NodeJS 서버에 연결한다.
		 */
		public function connect():void
		{
			socket.connect(ConnectProperties.SERVER_NODEJS_B2SOLUTION);
			if(isDebug) debug("Trying to connect to Node.JS server...", 4, this);
		}
		
		/**
		 * Socket.IO 연결 성공!
		 */
		protected function onConnect(event:FlashSocketEvent):void
		{
			
			if(isDebug) debug("Success to connect to Node.JS server.", 4, this);
			if(isDebug) debug("          서버주소 - " + socket.getOrigin());
			if(isDebug) debug("          세션ID - " + socket.sessionID);
			
			// 접속에 성공하면 socket.io에서 자동으로 호출되어야 하는데 안되서 강제로 호출하줌.
			socket.emit("connect");
			
			// MongoDB접속
			//var mongoDBInfo:Object = new Object();
			//mongoDBInfo.address = ConnectProperties.SERVER_MONGODB;
			//mongoDBInfo.db = ConnectProperties.MONGODB_NAME;
			//socket.emit("connectMongoDB", mongoDBInfo);
			
			
			// 예상치못한 접속종료시, 서버사이드에서 예전 세션을 물고있는데 이를 강제로 끊어줘야한다. (Mobile 3g<->Wifi변환시)
			if(unexpectedCloseSessionID)
			{
				socket.emit("disConnectUnexpectedSession", unexpectedCloseSessionID);
				unexpectedCloseSessionID = null;
			}
			
			isConnected=true;
			
			dispatchEvent(new Event(CONNECTION_SUCCESS));
		}
		
		/**
		 * Socket.IO 연결 닫힘
		 */
		protected function onClose(event:FlashSocketEvent):void
		{
			if(isDebug) debug("event.code : " + event.code + ", event.message : " + event.message + ", event.wasClean : " + event.wasClean + "event.reason : " + event.reason);
			/*
			* statusCode - 1000 : 정상적인 종료
			*            - 1005 : 노말
			*            - 1006 : 비정상적인 종료
			*            - 5000 : 접속에러
			*/
			var statusCode:int=event.code;
			switch (statusCode)
			{
				case 1000:
					if(isDebug) debug("정상적으로 접속이 종료되었습니다.");
					if(isDebug) debug("          서버주소 - " + socket.getOrigin());
					if(isDebug) debug("          세션ID - " + socket.sessionID);
					isConnected=false;
					dispatchEvent(new Event(CONNECTION_CLOSE_NORMAL));
					break;
				case 1005:
					break;
				case 1006:
					if(isDebug) debug("비정상적으로 접속이 종료되었습니다.");
					if(isDebug) debug("          서버주소 - " + socket.getOrigin());
					if(isDebug) debug("          세션ID - " + socket.sessionID);
					unexpectedCloseSessionID = socket.sessionID;
					isConnected=false;
					dispatchEvent(new Event(CONNECTION_CLOSE_ABNORMAL));
					// dispatchEvent(new Event(CONNECTION_RECONNECT));
					
					// 비정상 종료시 다시 접속시도
					// connect();
					break;
				case 5000:
					if(isDebug) debug("접속에러 : 접속에 문제가 있습니다.");
					if(isDebug) debug("          서버주소 - " + socket.getOrigin());
					if(isDebug) debug("          세션ID - " + socket.sessionID);
					dispatchEvent(new Event(CONNECTION_FAILED));
					break;
			}
		}
		
		protected function onConnectError(event:FlashSocketEvent):void
		{
			isConnected=false;
			if(isDebug) debug("접속에 실패하였습니다.");
			dispatchEvent(new Event(CONNECTION_ERROR));
			
			
			// 접속에 실패하면 다시 접속시도
			// if(isDebug) debug("다시 접속을 시도합니다...");
			// connect();
		}
		
		protected function onError(event:FlashSocketEvent):void
		{
			dispatchEvent(new Event(CONNECTION_ERROR));
			if(isDebug) debug("onError");
		}
		
		protected function onDisConnect(event:FlashSocketEvent):void
		{
			if(isDebug) debug("서버와의 접속이 종료되었습니다.");
			isConnected=false;
		}
		
		protected function onSecurityError(event:FlashSocketEvent):void
		{
			if(isDebug) debug("onSecurityError");
		}
		
		protected function onMessage(event:FlashSocketEvent):void
		{
			if(isDebug) debug("onMessage : " + event.data);
		}
		
		public function disConnectToNodeJS():void
		{
			if ( socket && socket.connected ) 
			{
				socket.close();
			}
		}
	}
}

class PrivateClass
{
	public function PrivateClass() {}
}
