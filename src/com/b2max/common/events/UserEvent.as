////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.events
{
	import com.b2max.common.vo.UserVO;

	import flash.events.Event;

	public class UserEvent extends Event
	{
		public static const USER_ADD:String = "userAdd";
		public static const USER_REMOVE:String = "userRemove";

		public static const CHANGE_USER_LEVEL:String = "changeUserLevel";
		
		public var user:UserVO;

		public function UserEvent(type:String, user:UserVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.user=user;
		}

		/**
		*  override clone.
		*/
		override public function clone():Event
		{
			return new UserEvent(type, user, bubbles, cancelable);
		}
	}
}

