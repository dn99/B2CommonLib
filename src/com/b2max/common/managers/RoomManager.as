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
	import com.b2max.common.vo.RoomVO;
	import com.b2max.websocket.flashsocket.FlashSocket;
	
	import mx.utils.ObjectUtil;
	
	public class RoomManager
	{ 
		private static var _instance:RoomManager;
		
		public var masterManager:MasterManager;
		public var socket:FlashSocket;
		
		public function RoomManager( secure:PrivateClass ) {}
		
		public static function getInstance():RoomManager
		{
			if ( !_instance ) 
			{
				_instance = new RoomManager( new PrivateClass() );
			}
			
			return _instance;
		}
		
		public static function removeInstance():void
		{
			_instance = null;
		}
		
		public function updateLobbyRoomlist(rooms:Object):void
		{
			GlobalData.lobbyRoomList.removeAll();
			
		    //trace( "::::::::::::::::::::::: rooms : " + ObjectUtil.toString(rooms)  );
			var newRooms:Object = rooms[0];
			var roomVO:RoomVO = null;
			for each ( var roomObj:Object in newRooms )
			{
				if ( roomObj.roomID != GlobalData.lobbyID && roomObj.roomID.toString().substring(0,5) != "LOBBY" && roomObj.lobbyID == GlobalData.lobbyID )
				{
					roomVO = new RoomVO( roomObj );
					GlobalData.lobbyRoomList.addItem( roomVO );
				}
			}
			
			//trace( "::::::::::::::::::::::: GlobalData.lobbyRoomList : " + ObjectUtil.toString(GlobalData.lobbyRoomList)  );
		}
		
		public function getRoomVO( roomID:String ):RoomVO
		{
			var roomVO:RoomVO = null;
			for each ( var room:RoomVO in GlobalData.lobbyRoomList.source )
			{
				if ( room.roomID == roomID )
				{
					roomVO = room;
					break;
				}
			}
			return roomVO;
		}
	}
}
class PrivateClass
{
	public function PrivateClass() {}
}