package com.b2max.common.ui.managers
{
	import com.b2max.common.ui.controls.IntervalTimer;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.utils.ObjectUtil;

	public class IntervalManager
	{
		private static var _instance:IntervalManager;

		private var eventReceivedInfo:Object;
		private var timerInfo:Object;

		private var durationInfo:Object;
		private var callBackFunInfo:Object
		private var callBackFunArgsInfo:Object

		/**
		 *  생성자
		 */
		public function IntervalManager( secure:PrivateClass ) {}

		/**
		 *  instance 생성
		 */
		public static function getInstance():IntervalManager
		{
			if ( !_instance ) 
			{
				_instance = new IntervalManager( new PrivateClass() );
				_instance.initIntervalInfo();
			}

			return _instance;
		}

		/**
		 *  instance 제거
		 */
		public static function removeInstance():void
		{
			_instance = null;
		}

		public function initIntervalInfo():void
		{
			//trace("initIntervalInfo -------------------------------------------------------");
			eventReceivedInfo = {};
			timerInfo = {};
			durationInfo = {};
			callBackFunInfo = {};
			callBackFunArgsInfo = {};
		}

		public function initInterval( id:String, callBackFun:Function, duration:int, ... args ):void
		{
			//trace( "<<<<<<<<<<<<<<<<<<<<<< CREATION INIT INTERVAL TIMER ID : " + id + " >>>>>>>>>>>>>>>>>>>>>>>> " + timerInfo[id] );
			eventReceivedInfo[id] = false;
			callBackFunInfo[id] = callBackFun;

			if ( timerInfo[id] ) return;


			if ( args.length != 0 ) callBackFunArgsInfo[id] = args;
			//trace( "args : " + args );
			//trace( "args len : " + ObjectUtil.toString(args) );

			var timer:IntervalTimer = new IntervalTimer( duration, 1 );
			timer.addEventListener( TimerEvent.TIMER, onTimerHandler );
			timer.id = id;

			timerInfo[id] = timer;
	
//			var eventReceived:Boolean;
//			var timer:Timer;
//			
//			timer = new Timer( duration, 1 );
//			timer.addEventListener( TimerEvent.TIMER, onTimerHandler );
		}

		public function startInterval( id:String ):void
		{

			if ( !timerInfo[id] ) return;
			//trace( ":: timerInfo[id] : " + timerInfo[id] + "     " + id );
			//trace( "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++:: eventReceivedInfo[id] : " + eventReceivedInfo[id] + "     " + id );

			if( eventReceivedInfo[id] )
			{
				timerInfo[id].stop();
				timerInfo[id].start();
				return;
			}
			
			timerInfo[id].start();
			eventReceivedInfo[id] = true;
			
			//trace( "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++:: timerInfo[id] : " + timerInfo[id].running + "     " + timerInfo[id].currentCount + "             " + timerInfo[id].repeatCount );
			//trace( "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++:: eventReceivedInfo[id] : " + eventReceivedInfo[id] + "     " + id );


//			if( eventReceived )
//			{
//				timer.stop();
//				timer.start();
//				return;
//			}
//			
//			timer.start();
//			eventReceived = true;
		}

		private function onTimerHandler( event:TimerEvent ):void 
		{
			var id:String = IntervalTimer( event.target ).id
			//trace("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ :::::::: onTimerHandler :::::::: " + "   id : " + id + "   fun : " + callBackFunInfo[id].toString() );
			//trace(":::::::: callBackFunArgsInfo[id] :::::::: " + "   id : " + id + "   args : " + callBackFunArgsInfo[id] );

			eventReceivedInfo[id] = false;

//			if ( callBackFunArgsInfo[id] ) 
//			{
//				//trace( "callBackFunArgsInfo[id] : " + ObjectUtil.toString(callBackFunArgsInfo[id]) );
//			}

			try
			{
				if ( callBackFunArgsInfo[id] ) 
					callBackFunInfo[id].apply( null, callBackFunArgsInfo[id] );
				else	
					callBackFunInfo[id]();
			}
			catch ( error:Error ) {}
		}
	}
}

class PrivateClass
{
	public function PrivateClass() {}
}

