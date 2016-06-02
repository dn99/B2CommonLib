package com.b2max.common.domain
{
	[Bindable]
	[RemoteClass(alias="com.b2max.solution.b2conference.domain.AuthInfoVO")]
	public class AuthInfoVO
	{
		public var siteIdx:String;			// idx
		public var roomID:String;			// 방 id
		public var roomName:String;			// 방 이름
		public var userID:String;			// 유저 아이디
		public var userName:String;			// 유저 이름
		public var userState:String;		// 유저 상태 0:강사(방장), 1:학생(방원), 2:옵저버
		public var courseIdx:String;		// 교재 idx
		public var authKey:String;			// 암호화 key
		public var actionTp:String;			//  0:기존방식, 1:api연동방식
		
		public var nickName:String;			// 사용자별칭
		public var companyName:String;		// 업체이름
		public var siteStateCd:String;		// 업체상태(00001:운영, 00002:정지, 00003:중지, 00004:설정대기)
		public var mgrDiskSize:int;			// 업체관리용량
		public var logoName:String;			// 업체로고명
		public var enterCnt:int;			// LMS입장가능인원수
		public var solution1:String;		// 클라우드
		public var solution2:String;		// 화상솔루션
		public var solution3:String;		// 동영상솔루션
		public var solution4:String;		// 시험솔루션
		public var solution5:String;		// 웹상담솔루션
		public var solution6:String;		// LMS
		public var solution7:String;		// 통합APP
		public var result:Boolean;			// 실행결과(true:성공, false:실패)
		public var resMsg:String;			// 결과메시지
		
		public var isAllowIP:Boolean;		// 허용 IP 여부
	}
}

