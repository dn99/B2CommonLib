package com.b2max.common.vo
{
	[Bindable]
	public class RoomInfoVO
	{
		public var subject:String;					// 토론 주제
		public var type:int;						// 자유토론 0, 링컨-더글러스식 토론 1, 의회식 토론 2, CEDA식 토론 3, 칼포퍼식 토론 4
		public var mode:int;						// 진행자 유 0, 무 1
		public var userType:int = -1;				// 진행자 0, 찬성자 1, 반대자 2, 참관자 3
		public var debateItemList:Array = [];
		
		public var debateStartDate:Date;			// 토론시작 시간
		public var debateEndDate:Date;				// 토론종료 시간
		public var seconderName:String;				// 토론 찬성자
		public var seconderVoteCount:int;			// 찬성투표 수치
		public var seconderRequestCount:int;		// 찬성자 요청발언수
		public var seconderSpeakResult:String;		// 찬성자 결론
		public var seconderHighlightTime:String;	// 찬성자 하이라이트씬
		public var dissenterName:String;			// 토론 반대자	
		public var dissenterVoteCount:int;			// 반대투표 수치
		public var dissenterRequestCount:int;		// 반대자 요청발언수
		public var dissenterSpeakResult:String;		// 반대자 결론
		public var dissenterHighlightTime:String;	// 반대자 하이라이트씬
		
		public function RoomInfoVO( obj:Object=null )
		{
			if ( !obj ) return;
			
			subject = obj.subject;
			type = obj.type;
			mode = obj.mode;
			userType = obj.userType;
			debateItemList = obj.debateItemList;
		}

	}
}

