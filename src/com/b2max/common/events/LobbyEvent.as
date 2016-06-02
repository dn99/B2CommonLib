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
	import flash.events.Event;

	public class LobbyEvent extends Event
	{
		public static const LOG_ON:String = "logOn";
		public static const ADDROOM:String = "addRoom";
		public static const JOINROOM:String = "joinRoom";
		public static const OBSERVEROOM:String = "observeRoom";
		
		public var data:*;

		public function LobbyEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}

		/**
		 *  override clone.
		 */
		override public function clone():Event
		{
			return new LobbyEvent(type, data, bubbles, cancelable);
		}
	}
}

