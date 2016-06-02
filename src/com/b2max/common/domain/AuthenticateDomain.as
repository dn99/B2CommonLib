package com.b2max.common.domain
{
	[Bindable]
	[RemoteClass(alias="com.b2max.solution.b2conference.domain.AuthenticateDomain")]
	public class AuthenticateDomain
	{
		public var userIdx:int;
		public var siteIdx:int;
		public var id:String;
		public var name:String;
		public var mobileNo:String;
		public var email:String;
		public var nickName:String;
		public var userPic:String;
		public var approvedStatusCd:String;
		public var companyName:String;
		public var siteStateCd:String;
		public var mgrDiskSize:String;
		public var logoName:String;
		public var enterCnt:int;
		public var solution1:String;
		public var solution2:String;
		public var solution3:String;
		public var solution4:String;
		public var solution5:String;
		public var solution6:String;
		public var solution7:String;
		
		public var sol1UseYn:String;
		public var sol2UseYn:String;
		public var sol3UseYn:String;
		public var sol4UseYn:String;
		public var sol5UseYn:String;    
		public var sol7UseYn:String;
		
		public var sol1ConnUserCount:String;
		public var sol2ConnUserCount:String;
		public var sol3ConnUserCount:String;
		public var sol4ConnUserCount:String;
		public var sol5ConnUserCount:String;
		
		public var sol1ConnIpNation:String;
		public var sol2ConnIpNation:String;
		public var sol3ConnIpNation:String;
		public var sol4ConnIpNation:String;
		public var sol5ConnIpNation:String;
		
		public var sol1Options:String;
		public var sol2Options:String;
		public var sol3Options:String;
		public var sol4Options:String;
		public var sol5Options:String;
		public var sol6Options:String;
		public var sol7Options:String;
		
		public var auth:Boolean;
		public var transactionId:String;
	}
}