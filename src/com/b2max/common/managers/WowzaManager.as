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
	import com.b2max.common.data.GlobalData;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	import mx.controls.Alert;

	
	public class WowzaManager extends EventDispatcher
	{
		public static const CONNECT_SUCCESS:String = "NetConnection.Connect.Success";
		public static const CONNECT_CLOSED:String = "NetConnection.Connect.Closed";
		public static const CONNECT_FAILED:String = "NetConnection.Connect.Failed";
		private static var _instance:WowzaManager;

		private var nc:NetConnection;
	
		public function WowzaManager(secure:PrivateClass)
		{
		}

		public static function getInstance():WowzaManager
		{
			if (!_instance)
				_instance=new WowzaManager(new PrivateClass());

			return _instance;
		}

		public static function removeInstance():void
		{
			_instance=null;
		}

		public function initNetConnection():void
		{
			if (nc)
				return;
			nc=new NetConnection();
			nc.objectEncoding=ObjectEncoding.AMF3;
			nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			nc.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

	
		// [참고] http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/events/NetStatusEvent.html
		private function onNetStatus(event:NetStatusEvent):void
		{
			// debug("event.info.code : " + event.info.code, 1, this);
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success":
					GlobalData.nc=nc;
					dispatchEvent(new Event(WowzaManager.CONNECT_SUCCESS));
					break;
				case "NetConnection.Connect.Closed":
					dispatchEvent(new Event(WowzaManager.CONNECT_CLOSED));
				case "NetConnection.Connect.Failed":
					dispatchEvent(new Event(WowzaManager.CONNECT_FAILED));
				case "NetConnection.Connect.Rejected":
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.InvalidApp":
				case "NetStream.Play.InsufficientBW":
				case "NetStream.Buffer.Empty":
				case "NetStream.Play.StreamNotFound":
				case "NetStream.Seek.Failed":
				case "NetStream.Seek.Notify":
				case "NetStream.Play.Stop":
				case "NetStream.Buffer.Flush":
				case "NetStream.Pause.Notify":
				case "NetStream.Buffer.Full":
				case "NetStream.Unpause.Notify":
				case "NetStream.Play.Reset":
				case "NetStream.Play.Start":
				case "NetStream.Publish.Start":
				
					break;
			}
		}

		private function onSecurityError(event:SecurityErrorEvent):void
		{
			debug("onSecurityError " + event.text, 4, this);
		}


		private function onIOError(event:IOErrorEvent):void
		{
			debug("onIOError " + event.text, 4, this);
		}

		private function onAsyncError(event:AsyncErrorEvent):void
		{
			debug("onAsyncError " + event.error.message, 4, this);
		}

		
		public function connect(roomID:String):void
		{	
			if (!nc.connected)
//				nc.connect(ConnectProperties.PROTOCOL + "://" + ConnectProperties.ADDRESS + ":" + ConnectProperties.PORT + "/" + ConnectProperties.APPLICATIONNAME + "/" + roomID);
				nc.connect(ConnectProperties.SERVER_MEDIA + "/" + roomID);
		}

		public function close():void
		{
			if (nc)
			{
				nc.close();
			}
		}

		public function get connected():Boolean
		{
			return (nc && nc.connected);
		}
		
		public function getConnection():NetConnection
		{
			return nc;
		}
	}
}


class PrivateClass
{
	public function PrivateClass()
	{
	}
}

