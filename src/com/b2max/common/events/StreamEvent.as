package com.b2max.common.events
{
	import flash.events.Event;
	
	public class StreamEvent extends Event
	{
		public static const SENDMEDIASTATE				:String = "sendMediaState";
		public static const STREAM_PLAY_START			:String = "stream_play_start";
		public static const STREAM_PLAY_STOP			:String = "stream_play_stop";
		public static const STREAM_PLAY_STREAM_NOT_FOUND:String = "stream_play_stream_not_found";
		
		public static const STREAM_PUBLISH_VIDEO		:String = "stream_publish_video";
		public static const STREAM_PUBLISH_AUDIO		:String = "stream_publish_audio";
		public static const STREAM_STOP_VIDEO			:String = "stream_stop_video";
		public static const STREAM_STOP_AUDIO			:String = "stream_stop_audio";
		
		public var userID:String;
		
		public function StreamEvent(type:String, userID:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.userID=userID;
		}
		
		/**
		 *  override clone.
		 */
		override public function clone():Event
		{
			return new StreamEvent(type, userID, bubbles, cancelable);
		}
	}
}

