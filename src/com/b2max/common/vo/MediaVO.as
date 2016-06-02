package com.b2max.common.vo
{
	import flash.media.Camera;
	import flash.media.Microphone;

	[Bindable]
	public class MediaVO
	{
		public var isVideoView:Boolean = true;						
		public var isVideoControl:Boolean = true;					
		
		public var isSendVideo:Boolean = false;						// 비디오 송출여부
		public var isSendAudio:Boolean = false;						// 오디오 송출여부
		
		public var isCamSupport:Boolean = Camera.isSupported;		// 카메라 장비여부
		public var camIndex:int = 0;								// 선택캠인덱스
		public var camWidth:int = 320;								// 선택해상도가로
		public var camHeight:int = 240;								// 선택해상도세로
		public var camNames:Array = Camera.names;					// 카메라목록
		
		public var isMicSupport:Boolean = Microphone.isSupported;	// 마이크 장비여부
		public var micIndex:int = 0;								// 선택마이크인덱스
		public var micNames:Array = Microphone.names;				// 마이크목록
		
		public var screenResolutionX:int;							// 가로해상도
		public var screenResolutionY:int;							// 세로해상도
		
		public var defaultSpeakerVolume:Number = 70;	// 개개인 볼륨 기본값, 공유되는 값이 아님
		
		public function MediaVO( obj:Object=null )
		{
			if ( !obj ) return;
			
			//this.isVideoView = obj.isVideoView;
			//this.isVideoControl = obj.isVideoControl;
			this.isSendVideo = obj.isSendVideo;
			this.isSendAudio = obj.isSendAudio;
			
			this.isCamSupport = obj.isCamSupport;
			this.camIndex = obj.camIndex;
			this.camWidth = obj.camWidth;
			this.camHeight = obj.camHeight;
			this.camNames = obj.camNames;
			
			this.isMicSupport = obj.isMicSupport;
			this.micIndex = obj.micIndex;
			this.micNames = obj.micNames;
			
			this.screenResolutionX = obj.screenResolutionX;
			this.screenResolutionY = obj.screenResolutionY;
		}
	}
}