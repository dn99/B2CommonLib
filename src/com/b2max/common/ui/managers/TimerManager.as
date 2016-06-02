package com.b2max.common.ui.managers
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 *  타이머 Manager
	 */ 
	public class TimerManager
	{
		private static var _instance:TimerManager;
		
		private var _timer:Timer;
		private var _timerCallBackFun:Function;
		
		/**
	     *  @private
	     *  타이머 카운터.
	     */
		private var _timerCount:int;
		/**
	     *  타이머 카운터.
	     */
		public function get timerCount():int
		{
			return _timerCount;
		}
		/**
	     *  @private
	     */
		public function set timerCount(value:int):void
		{
			_timerCount = value;
		}

		public function TimerManager(secure:PrivateClass) {}
		
		/**
		 *  인스턴스 생성
		 */ 
		public static function getInstance():TimerManager
		{
			if( _instance == null ) 
			{
				_instance = new TimerManager( new PrivateClass() );
			}	
			
			return _instance;
		}

		/**
		 *  타이머 초기화
		 */ 
		public function initTimer( viewRate:Number, timerCallBackFun:Function=null, repeatCount:int=0 ):void
		{
			clearTimer();
			
			_timerCallBackFun = timerCallBackFun;
			
			_timer = new Timer( 1000 * viewRate );
			_timer.addEventListener( TimerEvent.TIMER, onTimerHandler );
			_timer.repeatCount = repeatCount;
			
			_timer.start();
		}
		
		/**
		 *  타이머 제거
		 */ 
		public function clearTimer():void
		{
			if ( _timer == null ) return;
			
			//trace("-----------> Timer Clear <-----------", timerCount);
			_timerCount = 0;
			_timer.removeEventListener( TimerEvent.TIMER, onTimerHandler );
			_timer.stop();
			
			_timer = null;
		}
		
		/**
		 *  타이머 정지
		 */ 
		public function stopTimer():void
		{
			if ( _timer == null ) return;
			
			//trace("-----------> Timer Stop <-----------");
			_timer.stop();
		}
		
		/**
		 *  타이머 시작
		 */ 
		public function startTimer():void
		{
			if ( _timer == null ) return;
			
			//trace("-----------> Timer Start <-----------");
			_timer.start();
		}
		
		/**
		 *  이벤트 핸들러 - 타이머 실행
		 */ 
		private function onTimerHandler( event:TimerEvent ):void
		{
//			//trace("-----------> Timer Run <-----------", timerCount);
			if ( _timerCallBackFun != null ) _timerCallBackFun();
			_timerCount++;
		}
	}
}

class PrivateClass 
{
	public function PrivateClass() {}
}