////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.managers
{
	import com.b2max.blazeds.AMFServiceManager;
	import com.b2max.blazeds.BlazedsConstant;
	import com.b2max.common.data.ConstData;
	import com.b2max.common.data.GlobalData;
	import com.b2max.common.events.FileEvent;
	import com.b2max.common.utils.CommonUtil;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	import mx.core.DebuggableWorker;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;
	
	[Event(name="file_Load_Complete", type="com.b2max.common.events.FileEvent")]
	[Event(name="file_Uploading", type="com.b2max.common.events.FileEvent")]
	[Event(name="file_Upload_Complete", type="com.b2max.common.events.FileEvent")]
	
	public class FileManager extends EventDispatcher
	{
		private static var _instance:FileManager;
		
		public var URL:String;
		public var storagePath:String;
		private var fr:FileReference;
		public var isDoc:Boolean;
		
		public function FileManager(secure:PrivateClass)
		{
		}
		
		public static function getInstance():FileManager
		{
			if (!_instance)
				_instance=new FileManager(new PrivateClass());
			
			return _instance;
		}
		
		public function startUpload( fileExtension:Array ):void
		{
			debug("startUpload()", 1, this);
			fr=new FileReference();
			fr.addEventListener(Event.SELECT, fileSelectHandler);
			fr.addEventListener(Event.COMPLETE, completeHandler);
			fr.addEventListener(ProgressEvent.PROGRESS, progressEventHandler);
			fr.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			fr.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteDataHandler);	
			
			var fileFilter:Array=[];
			var description:String = CommonUtil.getFileExtension( fileExtension, "," );
			var extension:String = CommonUtil.getFileExtension( fileExtension, ";" );
			var filter:FileFilter = new FileFilter( description, extension );
			fileFilter.push( filter );
			
			//fileFilter.push(new FileFilter("*.odt, *.sxw, *.rtf, *.doc, *.docx, *.wpd, *.txt, *.html, *.ods, *.sxc, *.xls, *.xlsx, *.csv, *.tsv, *.odp, *.sxi, *.ppt, *.pptx, *.odg, *.pdf", "*.odt; *.sxw; *.rtf; *.doc; *.docx; *.wpd; *.txt; *.html; *.ods; *.sxc; *.xls; *.xlsx; *.csv; *.tsv; *.odp; *.sxi; *.ppt; *.pptx; *.odg; *.pdf"));
			/*
			fileFilter.push(new FileFilter("Text포멧", "*.odt; *.sxw; *.rtf; *.doc; *.docx; *.wpd; *.txt; *.html"));
			fileFilter.push(new FileFilter("SpreadSheet포멧", "*.ods; *.sxc; *.xls; *.xlsx; *.csv; *.tsv"));
			fileFilter.push(new FileFilter("Presentation포멧", "*.odp; *.sxi; *.ppt; *.pptx"));
			fileFilter.push(new FileFilter("Drawing포멧", "*.odg"));
			fileFilter.push(new FileFilter("PDF포멧", "*.pdf"));
			*/
			
			fr.browse(fileFilter);
		}
		
		
		private var uuid:String;
		private var realName:String;
		
		private function fileSelectHandler(event:Event):void
		{
			dispatchEvent(new FileEvent(FileEvent.FILE_SELECT, event.target.name));
			var url:String = ConnectProperties.FILE_CONVERTING_UPLOAD_SERVER; 
			var req:URLRequest = new URLRequest(url); 
			req.contentType = "multipart/form-data";
			
			var param:URLVariables = new URLVariables();
			param.savePath = ConnectProperties.STORAGEPATH + GlobalData.roomID;
			
			/* 
			 * FIXME 랜덤파일을 서버에서
			 * 이미지일 경우 파일명을 랜덤하게 생성후 서버에 저장한다.
			 * 한글파일명 sandbox 오류 임시방편. 랜덤파일을 서버에서 생성해야 무결하다.
			 * 또한 Request방식을 POST로 바꾸어야한다. GET은 길이제한도 있고, 무결하지 않음
			 * @date 20150226
			 * @author 김성윤
			 */
			if(!isDoc)	
			{
				uuid = UIDUtil.createUID();
				param.uuid = uuid;
				realName = uuid + "." + CommonUtil.getExtension(event.target.name); 
			}
			req.data = param;
			
			req.method = URLRequestMethod.GET;
			fr.upload(req);
		}
		
		
		private function progressEventHandler(event:ProgressEvent):void
		{
			//debug("progressEventHandler() - " + event.bytesLoaded + "/" + event.bytesTotal, 1, this);
			var uploadingInfo:Object=new Object();
			uploadingInfo.bytesLoaded=event.bytesLoaded;
			uploadingInfo.bytesTotal=event.bytesTotal;
			
			dispatchEvent(new FileEvent(FileEvent.FILE_UPLOADING, uploadingInfo));
		}
		
		private function completeHandler(event:Event):void
		{
			debug("completeHandler()", 1, this);
		}
		
		
		/**
		 * 업로드가 완료되는 시점.
		 */
		private function uploadCompleteDataHandler(event:DataEvent):void 
		{
			var obj:Object = new Object();
			obj.fileName = event.target.name;
			obj.realName = realName;
			dispatchEvent(new FileEvent(FileEvent.FILE_UPLOAD_COMPLETE, obj));
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			//trace("Error : " + e.text);
		}
		
	}
}

class PrivateClass
{
	public function PrivateClass()
	{
	}
}


