package com.b2max.common.vo
{
	[Bindable]
	public class LabelFileVO
	{	
		public var labelKey:String = "02";
		
		public var item_doc_name:String = "문서명";
		public var item_file_name:String = "파일명";
		public var item_file_delete:String = "삭제";
		
		public function LabelFileVO( obj:Object=null )
		{
			if ( !obj ) return;
			
			item_doc_name = obj.item_doc_name;
			item_file_name = obj.item_file_name;
			item_file_delete = obj.item_file_delete;
		}
	}
}

