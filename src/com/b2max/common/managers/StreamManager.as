package com.b2max.common.managers
{
	import com.b2max.common.data.GlobalData;
	import com.b2max.common.data.MediaData;
	import com.b2max.common.events.StreamEvent;
	import com.b2max.common.vo.MediaVO;
	import com.b2max.websocket.flashsocket.FlashSocket;
	
	import flash.events.ActivityEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.H264VideoStreamSettings;
	import flash.media.Microphone;
	import flash.media.SoundCodec;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.Capabilities;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	public class StreamManager extends EventDispatcher
	{
		private var isDebug:Boolean=true;
		
		private static var _instance:StreamManager;
		
		public var nc:NetConnection;
		private var outgoingStream:NetStream;
		
		private var cam:Camera;
		private var mic:Microphone;
		
		private var camWidth:int;
		private var camHeight:int;
		
		private var incomingStreams:ArrayList;
		private var isOutgoingStreamPublished:Boolean = false;
		
		public var socket:FlashSocket;
		
		public var timerObject:UIComponent;
		
		public function StreamManager(secure:PrivateClass)
		{
		}
		
		
		public static function getInstance():StreamManager
		{
			if (!_instance)
			{
				_instance=new StreamManager(new PrivateClass());
				_instance.incomingStreams = new ArrayList();
				_instance.timerObject = new UIComponent();
			}
			
			return _instance;
		}
		
		public static function removeInstance():void
		{
			_instance=null;
		}
		
		
		private function initOutgoingStream():void
		{
			if(!nc || !nc.connected) return;
			outgoingStream=new NetStream(nc);
			outgoingStream.bufferTime=0;
			
			outgoingStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			outgoingStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		}
		
		
		/**
		 * add incoming stream. called from userManager
		 */
		public function addIncomingStream(streamID:String, mediaVO:MediaVO=null):void
		{
			if (GlobalData.userID == streamID)
				return;
			
			// debug("addIncomingStream : " + streamID);
			// var isSendVideo:Boolean=mediaVO.isSendVideo;
			// var isSendAudio:Boolean=mediaVO.isSendAudio;
			
			var handler:Object=new Object();
			handler.onNetStatus=onNetStatus;
			handler.onAsyncError=onAsyncError;
			
			if(!nc || !nc.connected) return;
			
			var incomingStream:NetStream=new NetStream(nc);
			incomingStream.bufferTime = 0;
			
			incomingStream.addEventListener(NetStatusEvent.NET_STATUS, handler.onNetStatus);
			incomingStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, handler.onAsyncError);
			
			// 상대방 볼륨조절을 하기위함. UserList에서 볼륨조절을 하게하려면 이부분을 수정해야함!
			var soundTransform:SoundTransform = new SoundTransform((GlobalData.defaultSpeakerVolume*GlobalData.globalSpeakerVolume)*0.0001);
			incomingStream.soundTransform = soundTransform;
			
			// place EventHandler here nested. 
			function onNetStatus(event:NetStatusEvent):void
			{
				// debug("[" + event.info.code + "] " + event.info.description, 3, this);
				// var targetStreamID:String=event.info.description.toString().substring(16, event.info.description.toString().length - 1);
				switch (event.info.code)
				{
					case "NetStream.Play.StreamNotFound":
						// dispatchEvent(new StreamEvent(StreamEvent.STREAM_PLAY_STREAM_NOT_FOUND));
						break;
					case "NetStream.Play.PublishNotify":
						break;
					case "NetStream.Play.Reset ":
						break;
					case "NetStream.Play.Start":
						var playedStreamID:String=event.info.description.toString().substring(16, event.info.description.toString().length - 1);
						dispatchEvent(new StreamEvent(StreamEvent.STREAM_PLAY_START, playedStreamID));
						// updatePlayState(playedStreamID);
						break;
					case "NetStream.Video.DimensionChange":
						break;
					case "NetStream.Play.Stop":
						var stoppedStreamID:String=event.info.description.toString().substring(16, event.info.description.toString().length - 1);
						dispatchEvent(new StreamEvent(StreamEvent.STREAM_PLAY_STOP, stoppedStreamID));
						break;
					
				}
			}
			
			function onAsyncError(event:AsyncErrorEvent):void
			{
				//debug("onAsyncError " + event.error.message, 3, this);
			}
			
			incomingStream.receiveAudio(true);
			incomingStream.receiveVideo(true);
			//if (isSendAudio || isSendVideo)
			incomingStream.play(streamID);
			
			var streamObj:Object=new Object();
			streamObj.stream=incomingStream;
			streamObj.streamID=streamID;
			streamObj.isStarted=false;
			streamObj.volume = GlobalData.defaultSpeakerVolume;
			incomingStreams.addItem(streamObj);
			GlobalData.nc.proxyType
		}
		
		/**
		 * Remove the NetStream object from incomingStreams ArrayList.
		 */
		public function removeIncomingStream(streamID:String):void
		{
			for (var i:int=0; i < incomingStreams.length; i++)
			{
				if (incomingStreams.getItemAt(i).streamID == streamID)
				{
					incomingStreams.getItemAt(i).stream.pause();
					incomingStreams.getItemAt(i).stream.close();
					incomingStreams.getItemAt(i).stream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
					incomingStreams.getItemAt(i).stream=null;
					incomingStreams.removeItemAt(i);
				}
				break;
			}
		}
		
		/**
		 * 스트림이 플레이 된 후에 비디오 객체를 가져가야함. 
		 */
		private function updatePlayState(streamID:String):void
		{
			for (var i:int=0; i < incomingStreams.length; i++)
				if (incomingStreams.getItemAt(i).streamID == streamID)
					incomingStreams.getItemAt(i).isStarted=true;
		}
		
		public function isPlayed(streamID:String):Boolean
		{
			for (var i:int=0; i < incomingStreams.length; i++)
				if (incomingStreams.getItemAt(i).streamID == streamID)
					return incomingStreams.getItemAt(i).isStarted;
			return false;
		}
		
		/**
		 * update stream.
		 */
		public function updateStream(streamID:String, mediaVO:MediaVO):void
		{
			// Don't need to create own stream.
			if (GlobalData.userID == streamID)
				return;
			
			try
			{
				var ns:NetStream=getNetStream(streamID);
				if(!ns)
				{
					// debug("※※※※※" + streamID + "스트림 존재하지않음1", 3, this);
				}
				ns.receiveAudio(mediaVO.isSendAudio);
				ns.receiveVideo(mediaVO.isSendVideo);
				// debug("☆☆☆☆☆ updateStream() " + mediaVO.isSendAudio.toString(), 1, this);
				
				(!mediaVO.isSendAudio && !mediaVO.isSendVideo) ? ns.close() : ns.play(streamID);	
			}
			catch(e:Error)
			{
				// debug("※※※※※" + streamID + "스트림 존재하지않음2", 3, this);
			}
		}
		
		
		/**
		 * Get the Video object called from VideoListRenderer.mxml
		 * @param streamID
		 */
		public function getVideo(streamID:String):Video
		{
			var video:Video=new Video();
			video.smoothing = MediaData.smoothVideo;
			
			if (streamID == GlobalData.userID)
			{
				video.attachCamera(cam);
			}
			else
			{
				video.attachNetStream(getNetStream(streamID));
			}
			return video;
		}
		
		public function getMic():Microphone
		{
			return mic;
		}
		
		/**
		 * Get the Video object called from VideoListRenderer.mxml
		 * @param streamID
		 */
		public function getVideoInMobile(streamID:String):Video
		{
			var video:Video=new Video();
			if (streamID == GlobalData.userID)
			{
				video.attachCamera(cam);
			}
			else
			{
				for (var j:int=0; j < incomingStreams.length; j++)
				{
					var ns:NetStream;
					var currentID:String = incomingStreams.getItemAt(j).streamID;
					if (currentID == streamID)
					{
						incomingStreams.getItemAt(j).stream.close();
						incomingStreams.getItemAt(j).stream = null;
						ns = new NetStream(GlobalData.nc);
						ns.receiveVideo(true);
						ns.receiveAudio(true);
						ns.play(streamID);
						incomingStreams.getItemAt(j).stream = ns;
					}
				}
				video.attachNetStream(ns);
			}
			return video;
		}
		
		/**
		 * Get the NetStream object from incomingStreams ArrayList.
		 */
		public function getNetStream(streamID:String):NetStream
		{
			var netStream:NetStream;			
			
			for (var j:int=0; j < incomingStreams.length; j++)
			{
				var currentID:String = incomingStreams.getItemAt(j).streamID;
				if (currentID == streamID)
					netStream = incomingStreams.getItemAt(j).stream;
			}
			return netStream;
		}
		
		/**
		 * Publish video
		 */
		public function sendVideo(data:Object):void
		{
			if (!outgoingStream)
				initOutgoingStream();
			if (!Camera.isSupported)
				return;
			
			// initialize Camera
			var camIndex:Number=data.camIndex;
			camWidth=data.camWidth;
			camHeight=data.camHeight;
			cam=Camera.getCamera(camIndex.toString());
			cam.addEventListener(ActivityEvent.ACTIVITY, onActivity);
			cam.addEventListener(StatusEvent.STATUS, onStatusEvent);
			cam.setQuality(MediaData.camQualityBandwidth, MediaData.camQualityPicture);
			cam.setMode(camWidth, camHeight, MediaData.camModeFps);
			
			// Set H.264 Encoding
			if(MediaData.enableH264)
			{
				var h264Settings:H264VideoStreamSettings=new H264VideoStreamSettings();
				h264Settings.setProfileLevel(MediaData.h264Profile, MediaData.h264Level);
				h264Settings.setKeyFrameInterval(MediaData.camKeyFrameInterval);
				h264Settings.setQuality(MediaData.camQualityBandwidth, MediaData.camQualityPicture);
				h264Settings.setMode(camWidth, camHeight, MediaData.camModeFps);
				outgoingStream.videoStreamSettings=h264Settings;
			}
			
			outgoingStream.attachCamera(cam);
			
			if (!GlobalData.isSendAudio)
				outgoingStream.publish(GlobalData.userID, "LIVE");
			
			dispatchEvent(new StreamEvent(StreamEvent.SENDMEDIASTATE));
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_PUBLISH_VIDEO));
		}
		
		/**
		 * 모바일 카메라 영상 보내기
		 */
		public function sendMobileVideo(camera:Camera):void
		{
			//trace("Capabilities.maxLevelIDC : " + Capabilities.maxLevelIDC);
			if (!outgoingStream)
				initOutgoingStream();
			
			if(!outgoingStream) return;
			
			cam=camera;
			cam.addEventListener(ActivityEvent.ACTIVITY, onActivity);
			cam.addEventListener(StatusEvent.STATUS, onStatusEvent);
			
			outgoingStream.attachCamera(cam);
			
			//if (!isOutgoingStreamPublished)
				outgoingStream.publish(GlobalData.userID, "LIVE");
			
			dispatchEvent(new StreamEvent(StreamEvent.SENDMEDIASTATE));
		}
		
		/**
		 * Publish Audio
		 */
		public function sendAudio():void
		{
			if (!outgoingStream)
				initOutgoingStream();
			
			if (!Microphone.isSupported)
				return;
			
			stopPublishingAudio();
			
			if(Capabilities.version.substr(0,3) == "WIN")
			{
				// 윈도우
				//mic=Microphone.getEnhancedMicrophone();
				//var options:MicrophoneEnhancedOptions = new MicrophoneEnhancedOptions();
				//options.mode = MicrophoneEnhancedMode.FULL_DUPLEX;
				//options.autoGain = false;
				//options.echoPath = 128;
				//options.nonLinearProcessing = true;
				//mic['enhancedOptions'] = options;
				
				// FIXME 인덱스를 받아서 마이크를 획득하면 작동하지 않는 경우가 있음
				//trace("micIndex : " + micIndex);
				//mic=Microphone.getMicrophone(micIndex);
				mic=Microphone.getMicrophone();
				
			}
			else if(Capabilities.version.substr(0,3) == "AND")
			{
				// 안드로이드
				mic=Microphone.getMicrophone();
			}
			else if(Capabilities.version.substr(0,3) == "IOS")
			{
				// 아이폰
				
			}
			else if(Capabilities.version.substr(0,3) == "QNX")
			{
				// 블랙베리			
			}
			
			mic.setUseEchoSuppression(MediaData.setUseEchoSuppression);	
			mic.setLoopBack(MediaData.setLoopBack);
			mic.setSilenceLevel(MediaData.silenceLevel, MediaData.silenceLevelTimeout);
			mic.gain=GlobalData.globalMicVolume;
			
			if (MediaData.codec == "SPEEX") 
			{
				mic.encodeQuality = MediaData.speexQuality;
				mic.codec = SoundCodec.SPEEX;
				mic.framesPerPacket = MediaData.framesPerPacket;
				mic.rate = MediaData.speexRate; 
			} 
			else 
			{
				mic.codec = SoundCodec.NELLYMOSER;
				mic.rate = MediaData.nellymoserRate;
			}			
			
			outgoingStream.attachAudio(mic);
			
			if (!GlobalData.isSendVideo)
				outgoingStream.publish(GlobalData.userID, "LIVE");
			
			//if (!isOutgoingStreamPublished)
				//outgoingStream.publish(GlobalData.userID, "LIVE");
			
			dispatchEvent(new StreamEvent(StreamEvent.SENDMEDIASTATE));
			shareMicLevel(true);
		}
		
		private var to:int;
		
		/**
		 * 마이크Level 공유(이퀄라이저) 
		 */
		public function shareMicLevel(value:Boolean):void
		{
			if(value)  
				timerObject.addEventListener(Event.ENTER_FRAME, stage_EnterFrame);
			else
				timerObject.removeEventListener(Event.ENTER_FRAME, stage_EnterFrame);
		}
		
		private function stage_EnterFrame(e:Event):void
		{
			//trace( "================= stage_EnterFrame GlobalData.userName : " + GlobalData.userName );
			if ( mic ) socket.emit("shareMicLevel", {userID: GlobalData.userID, micLevel: mic.activityLevel}, null); 
		}
		
		private function onAsyncError(event:AsyncErrorEvent):void
		{
			// debug("onAsyncError " + event.error.message, 4, this);
		}
		
		// 사용자가 '허용' 또는 '거부'를 클릭시
		// [참고] http://help.adobe.com/ko_KR/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d49.html
		private function onStatusEvent(event:StatusEvent):void
		{
			switch (event.code)
			{
				case "Camera.Muted":
					break;
				case "Camera.Unmuted":
					break;
			}
		}
		
		// [참고] http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/events/NetStatusEvent.html
		public function onNetStatus(event:NetStatusEvent):void
		{
			//debug("event.info.code : " + event.info.code, 3, this);
			switch (event.info.code)
			{
				case "NetStream.Publish.Start":
					isOutgoingStreamPublished = true;
					// dispatchEvent(new StreamEvent(StreamEvent.SENDMEDIASTATE));
					// dispatchEvent(new StreamEvent(StreamEvent.STREAM_PUBLISH));
					// debug(outgoingStream.info.uri + ", " + GlobalData.userID, 4, this);
					// sendMetaData();
					break;
			}
		}
		
		private function sendMetaData():void
		{
			// You have to send MetaData after publishing the stream. 
			var metaData:Object=new Object();
			metaData.streamID=GlobalData.userID;
			metaData.roomID=GlobalData.roomID;
			metaData.width=camWidth;
			metaData.height=camHeight;
			outgoingStream.send("@setDataFrame", "onMetaData", metaData);
		}
		
		private function onMetadata(o:Object):void
		{
			// debug("metadata : " + ObjectUtil.toString(o));
		}
		
		
		private function onActivity(event:ActivityEvent):void
		{
			// debug("event.activating " + event.activating);
		}
		
		
		public function stopPublishingVideo():void
		{
			
			if (outgoingStream)
				outgoingStream.attachCamera(null);
			cam = Camera.getCamera(null);
			cam = null;
			//checkStream();
			dispatchEvent(new StreamEvent(StreamEvent.SENDMEDIASTATE));
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_PLAY_STOP, GlobalData.userID));
		}
		
		public function stopPublishingAudio():void
		{
			shareMicLevel(false);
			//mic = Microphone.getMicrophone(-1);
			//mic = null;
			if (outgoingStream)
				outgoingStream.attachAudio(null);
			//checkStream();
			dispatchEvent(new StreamEvent(StreamEvent.SENDMEDIASTATE));
		}
		
		
		
		private function checkStream():void
		{
			if (!(GlobalData.isSendVideo || GlobalData.isSendAudio))
			{
				if (outgoingStream)
				{
					outgoingStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
					outgoingStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
					outgoingStream.close();
					outgoingStream=null;
				}
			}
		}
		
		
		public function closeSession():void
		{
			// remove OutgoingStream
			if(!outgoingStream) return;
			outgoingStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			outgoingStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			outgoingStream.close();
			outgoingStream=null;
			
			// remove IncomingStream
			// FIXME [성윤작성] incomingStreams의 이벤트도 remove해야됨
			for (var j:int=0; j < incomingStreams.length; j++)
			{
				incomingStreams.getItemAt(j).stream.close();
				incomingStreams.getItemAt(j).stream = null;
			}
			incomingStreams.removeAll();
			isOutgoingStreamPublished = false;
		}
		
		/**
		 * audio on particular user. called from VideListRenderer.mxml
		 */
		public function audioOn(streamID:String):void
		{
			getNetStream(streamID).receiveAudio(true);
		}
		
		/**
		 * audio off particular user. called from VideListRenderer.mxml
		 */
		public function audioOff(streamID:String):void
		{
			getNetStream(streamID).receiveAudio(false);
		}
		
		/**
		 * video on particular user. called from VideListRenderer.mxml
		 */
		public function videoOn(streamID:String):void
		{
			getNetStream(streamID).receiveVideo(true);
		}
		
		/**
		 * video off particular user. called from VideListRenderer.mxml
		 */
		public function videoOff(streamID:String):void
		{
			getNetStream(streamID).receiveVideo(false);
		}
		
		/**
		 * 내 마이크 볼륨 조절
		 */
		public function changeMicVolume(volume:int):void
		{
			if(mic)
				mic.gain = volume;
			
			GlobalData.globalMicVolume = volume;
		}
		
		/**
		 * 전체 스피커 볼륨 조절
		 */
		public function changeAllVolumes(volume:int):void
		{
			for (var i:int=0; i < incomingStreams.length; i++)
			{
				if (incomingStreams.getItemAt(i).streamID != GlobalData.userID)
				{
					var soundTransform:SoundTransform = new SoundTransform((incomingStreams.getItemAt(i).volume*volume)*0.0001);
					incomingStreams.getItemAt(i).stream.soundTransform = soundTransform;
				}
			}
		}
		
		/**
		 * 개개인 스피커 볼륨조절 
		 */
		public function changeUserVolume(streamID:String, volume:int):void
		{
			for (var i:int=0; i < incomingStreams.length; i++)
			{
				if (incomingStreams.getItemAt(i).streamID == streamID)
				{
					incomingStreams.getItemAt(i).volume = volume;
					var soundTransform:SoundTransform = new SoundTransform((volume*GlobalData.globalSpeakerVolume)*0.0001);
					incomingStreams.getItemAt(i).stream.soundTransform = soundTransform;
				}
			}
		}
		
	}
}


class PrivateClass
{
	public function PrivateClass()
	{
	}
}
