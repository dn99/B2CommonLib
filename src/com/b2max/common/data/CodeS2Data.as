package com.b2max.common.data
{
	import com.b2max.common.vo.DataInfoVO;

	/**
	 * 부모코드 S2OPT
	 */ 
	public class CodeS2Data
	{
		/**----------------------------- 화상솔루션 (solution2) ------------------------------------**/
		
		//OP101	회의실
		//OP102	강의실
		//OP103	상담실
		//OP104	토론실
		//OP105	방송실
		//OP106	원격공유/제어
		//OP107	채팅
			
		public static const OP101:DataInfoVO = InterfaceData.ROOM_TYPE_CONF;		// 회의
		public static const OP102:DataInfoVO = InterfaceData.ROOM_TYPE_EDU;			// 교육
		public static const OP103:DataInfoVO = InterfaceData.ROOM_TYPE_COUNSEL;		// 상담
		public static const OP104:DataInfoVO = InterfaceData.ROOM_TYPE_DEBATE;		// 토론
		public static const OP105:DataInfoVO = InterfaceData.ROOM_TYPE_BROAD;		// 방송
		public static const OP106:DataInfoVO = InterfaceData.ROOM_TYPE_REMOTE;		// 원격제어
		public static const OP107:DataInfoVO = InterfaceData.ROOM_TYPE_CHAT;		// 채팅
		
		//OP201	원격제어
		//OP202	캡쳐방어
		//OP203	파일연동
		//OP204	성적연동
		//OP205	서버녹화
		//OP206	음성인식(번역)
		//OP207	자동회의록
		
		public static const OP201:String = "OP201";
		public static const OP202:String = "OP202";
		public static const OP203:String = "OP203";
		public static const OP204:String = "OP204";
		public static const OP205:String = "OP205";
		public static const OP206:String = "OP206";
		public static const OP207:String = "OP207";
		
	}
}