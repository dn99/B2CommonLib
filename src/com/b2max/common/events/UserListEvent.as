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
	import mx.collections.ArrayList;
	import flash.events.Event;

	public class UserListEvent extends Event
	{
		public static const USERLISTUPDATE:String = "userlistUpdate";

		public var users:Object;

		public function UserListEvent(type:String, users:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.users=users;
		}
		
		/**
		 *  override clone.
		 */
		override public function clone():Event
		{
			return new UserListEvent(type, users, bubbles, cancelable);
		}
	}
}