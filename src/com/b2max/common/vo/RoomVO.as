////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.vo
{
	[Bindable]
	public class RoomVO
	{
		public var roomID:String;				// roomID
		public var roomName:String;				// room이름
		public var roomType:String;				// roomType
		public var roomInfoVO:RoomInfoVO;		// roomInfoVO (토론모드)
		public var roomMainType:String;
		public var roomCreatorUserID:String;	// 방개설자 userID
		public var roomCreatorUserName:String;	// 방개설자 userName
		public var roomCreatorUserIP:String;	// 방개설자 IP
		public var roomCreateTime:String;		// 방 개설시간
		public var host:String;					// 호스트
		
		public var userList:Array;				// 해당방의 userList
		public var isLMS:Boolean;				// LMS유무
		public var mode:int;					// 개설자 방모드 -> 0 : 일반모드, 1: Observer모드
		public var lobbyID:String;				// 해당방의 소속LobbyID
		
		public function RoomVO( obj:Object=null )
		{
			if ( !obj ) return;
			
			this.roomID = obj.roomID;
			this.roomName = obj.roomName;
			this.roomType = obj.roomType;
			this.roomInfoVO = new RoomInfoVO( obj.roomInfoVO );
			this.roomMainType = obj.roomMainType;
			this.roomCreatorUserID = obj.roomCreatorUserID;
			this.roomCreatorUserName = obj.roomCreatorUserName;
			this.roomCreatorUserIP = obj.roomCreatorUserIP;
			this.roomCreateTime = obj.roomCreateTime;
			this.host = obj.host;
			
			this.userList = obj.userList;
			this.isLMS = obj.isLMS;
			this.mode = obj.mode;
			this.lobbyID = obj.lobbyID;
		}
	}
}

