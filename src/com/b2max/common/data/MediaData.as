////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.data
{
	import flash.media.Camera;
	import flash.media.SoundCodec;

	[Bindable]
	public class MediaData
	{
		public static const SET_MICROPHONE:String = "setMicrophone";
		public static const SET_CAMERA:String = "setCamera";
		public static const SET_CODEC:String = "setCodec";
		public static const SET_SPEEX_QUALITY:String = "setSpeexQuality";
		public static const SET_NELLYMOSER_RATE:String = "setNellymoserRate";
		
		public var action:String = null;
		
	   /*
		* 비디오 관련 설정
		*/
		public static var mobileCamWidth:int = 640;
		public static var mobileCamHeight:int = 320;
		public static var mobileCamFps:int = 15;
		public static var mobileMotionLevel:int = 0;
		public static var mobileCamBandwidth:int = 0;
		public static var mobileCamQuality:int = 80;
		
		//public var resolution:Array=new Array("320*240", "640*480", "1280*720", "1920*1080");
		//public static var resolution:Array=new Array("320*240", "640*480");
		public static var resolution:Array=new Array(GlobalData.labelVO.label_camquality_high, GlobalData.labelVO.label_camquality_low);
		public static var camKeyFrameInterval:Number = 5;
		public static var camModeFps:Number = 10;
	    //public static var camQualityBandwidth:Number = 16384;
		public static var camQualityBandwidth:Number = 0;
		public static var camQualityPicture:Number = 80;	
		public static var h264Level:String = "2.1";	
		public static var h264Profile:String = "main";	
		public static var enableH264:Boolean = true;
		public static var cameraIndex:int = (Camera.names.length == 2) ? 1 : 0;
		public static var smoothVideo:Boolean = false;
		
	   /*
		* 오디오 관련 설정
		*/
		//public static var codec:String = SoundCodec.NELLYMOSER;
		public static var codec:String = SoundCodec.SPEEX;
		public static var speexQuality:int = 10;				// 0~10 (default : 6)
		public static var nellymoserRate:int = 8;				// 5, 8, 11, 22, 44 (default : 8)
		public static var speexRate:int = 16;   				// SPEEX는 16만 됨
		public static var framesPerPacket:int = 1;				// framesPerPacket 클수록 Bandwith 작고, Latency 높아짐 (default : 2) 
		public static var setSilenceLevel:int = 0;
		public static var microphoneIndex:int = 0;
		
		public static var setUseEchoSuppression:Boolean = true; // 에코 줄임. MicrophoneEnhancedOptions() 사용시 무시됨.
		public static var setLoopBack:Boolean = false;			// 마이크 소리를 스피커로 나오게 하느냐
		public static var silenceLevel:int = 0;
		public static var silenceLevelTimeout:int = 2000;
		
		public static var autoStart:Boolean = false;
		public static var showCloseButton:Boolean = true;
		public static var showButton:Boolean = true;
		public static var publishWindowVisible:Boolean = true;
		public static var viewerWindowMaxed:Boolean = false;
		public static var viewerWindowLocation:String = "middle";
		public static var applyConvolutionFilter:Boolean = false;
		public static var convolutionFilter:Array = [-1, 0, -1, 0, 6, 0, -1, 0, -1];
		public static var filterBias:Number = 0;
		public static var filterDivisor:Number = 4;

		/*
		 * 화면공유 
		 */
		public static var screenCaptureCodec:String = "flashsv1";
//		public static var screenCaptureCodec:String = "flashsv2";
		public static var screenCaptureFrameRate:Number = 16;
		
	}
}