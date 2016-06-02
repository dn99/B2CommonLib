package com.b2max.common.domain
{

	[Bindable]
	[RemoteClass(alias="com.b2max.solution.user.domain.UserInfoVO")]
	public class UserInfoVO
	{
		private var username:String;
		private var password:String;

		private var idx:int;
		private var siteIdx:int;
		private var id:String;
		private var passwd:String;
		private var name:String;
		private var mobileNo:String;
		private var email:String;
		private var delYn:String;
		private var mobileId:String;
		private var joinPathCd:String;
		private var authGrpIdx:String;
		private var mbrGbCd:int;
		private var col:String;
		private var regDate:String;
		private var modDate:String;
		private var regUserId:String;
		private var modUserId:String;
		private var saveIdCheck:String;

		private var departmentIdx:int;
		private var departmentName:String;
		private var positionIdx:int;
		private var positionName:String;
		private var userAuthGrpIdx:int;
		private var userAuthGrpName:String;
	}
}
