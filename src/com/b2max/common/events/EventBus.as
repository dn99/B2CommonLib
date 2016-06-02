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
	import flash.events.EventDispatcher;

	/**
	 *  전역 이벤트 매니저
	 */ 
	public class EventBus extends EventDispatcher
	{
		private static var _instance:EventBus;

		/**
		 *  생성자
		 */ 
		public function EventBus( secure:PrivateClass ) {}

		/**
		 *  instance 생성
		 */ 
		public static function getInstance():EventBus
		{
			if( !_instance ) _instance = new EventBus( new PrivateClass() );

			return _instance;
		}

		/**
		 *  instance 제거
		 */
		public static function removeInstance():void
		{
			_instance = null;
		}

		/**
		 *  이벤트 리스너 등록
		 */
		public static function addEventListener( type:String, listener:Function ):void
		{
			if ( getInstance().hasEventListener( type ) )
			{
				//trace(type + "이미있음");
				return;
			}
			//trace(type + "추가됨");
			getInstance().addEventListener( type, listener );
		}

		/**
		 *  이벤트 리스너 제거
		 */
		public static function removeEventListener( type:String, listener:Function ):void
		{
			if ( !getInstance().hasEventListener( type ) ) return;
			getInstance().removeEventListener( type, listener );
		}

		/**
		 *  이벤트 리스너 제거
		 */
		public static function hasEventListener( type:String ):void
		{
			getInstance().hasEventListener( type );
		}

		/**
		 *  디스페치 이벤트
		 */
		public static function dispatchEvent( event:Event ):void
		{
			getInstance().dispatchEvent( event );
		}
	}
}

class PrivateClass 
{
	public function PrivateClass() {}
}

