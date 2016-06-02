package com.b2max.common.domain
{
	[Bindable]
	[RemoteClass(alias="com.b2max.web.department.domain.OrgUserInfoVO")]
	public class OrgUserInfoVO
	{
		public var id:String;
		public var username:String;
		public var mobileNo:String;
		public var departmentName:String;
		public var positionName:String;
		public var connStatusCd:String;
		public var msgIntroduce:String;
	}
}