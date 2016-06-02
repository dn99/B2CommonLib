package com.b2max.common.domain
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.b2max.web.department.domain.OrgInfoVO")]
	public class OrgInfoVO
	{
		public var idx:int;
		public var siteIdx:int;
		public var departmentName:String;
		public var parentDepartmentIdx:int;
		public var orderNo:int;
		public var lev:int;
		public var userList:ArrayCollection;
	}
}