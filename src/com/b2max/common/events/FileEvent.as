package com.b2max.common.events
{
	import flash.events.Event;

	public class FileEvent extends Event
	{
		public static const FILE_SELECT:String = "file_Select";
		public static const FILE_LOAD_COMPLETE:String = "file_Load_Complete";
		public static const FILE_UPLOADING:String = "file_Uploading";
		public static const FILE_UPLOAD_COMPLETE:String = "file_upload_complete";
		public static const FILE_CONVERTED_COMPLETE:String = "file_Converted_Complete";
		public static const FILE_LIST_SELECT:String = "file_List_Select";
		public var data:*;

		public function FileEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}

		/**
		 *  override clone.
		 */
		override public function clone():Event
		{
			return new FileEvent(type, data, bubbles, cancelable);
		}
	}
}

