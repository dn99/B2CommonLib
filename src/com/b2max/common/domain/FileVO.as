package com.b2max.common.domain
{	
	
	[Bindable]
	[RemoteClass(alias="com.b2max.solution.b2conference.domain.FileVO")]
	public class FileVO
	{
		public var idx:int;
		public var siteIdx:int;
		public var docID:String;
		public var fileName:String;
		public var realName:String;
		public var fileType:String;
		public var swfFileName:String;
		public var uploaderUserID:String;
		public var uploaderUserName:int;
		public var uploadTime:int;
		public var totalPage:int;
		public var fileURL:String;
		
		public var selected:Boolean;
		
		public function FileVO( obj:Object=null )
		{
			if ( !obj ) return;	
			
			this.docID = obj.docID;
			this.fileName = obj.fileName;
			this.realName = obj.realName;
			this.fileType = obj.fileType;
			this.swfFileName = obj.swfFileName;
			this.uploaderUserID = obj.uploaderUserID;
			this.uploaderUserName = obj.uploaderUserName;
			this.uploadTime = obj.uploadTime;
			this.totalPage = obj.totalPage;
		}
		
	}
}