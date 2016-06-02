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

	public class BusEvent extends Event
	{
		public static const SETUSERID:String = "setUserId";
		public static const UPDATECHAT:String = "updateChat";

		public static const START_PUBLISHING_VIDEO:String = "start_Publishing_Video"; 
		public static const STOP_PUBLISHING_VIDEO:String = "stop_Publishing_Video";
		public static const START_PUBLISHING_AUDIO:String = "start_Publishgin_Audio";
		public static const STOP_PUBLISHING_AUDIO:String = "stop_Publishing_Audio";

		public static const OPEN_VIDEOSETTING:String = "open_VideoSetting";
		public static const OPEN_AUDIOSETTING:String = "open_AudioSetting";
		public static const OPEN_POWERSETTING:String = "open_PowerSetting";
		public static const OPEN_POWER_AUDIO_SETTING:String = "open_PowerAudioSetting";
		public static const OPEN_POWER_AUDIO_SETTING2:String = "open_PowerAudioSetting2";

		public static const MIC_VOLOUME_CONTROL:String = "mic_Volume_Control";

		public static const GREETING:String = "greeting";	// 입장시 채팅창에 입장을 알림
		public static const GOOBYTE:String = "goodbye"; 	// 퇴장시 채팅창에 퇴장을 알림

		public var data:*;

		public function BusEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}

		/**
		 *  override clone.
		 */
		override public function clone():Event
		{
			return new BusEvent(type, data, bubbles, cancelable);
		}
	}
}

