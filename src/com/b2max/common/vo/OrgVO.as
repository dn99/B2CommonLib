package com.b2max.common.vo
{
	import com.b2max.common.domain.OrgInfoVO;
	import com.b2max.common.domain.OrgUserInfoVO;
	
	import mx.collections.ArrayCollection;

	public class OrgVO
	{
		// 유저 사진정보 필요
		// 유저 상태코더 정보 필요
		public var idx:int;
		public var siteIdx:int;
		public var departmentName:String;
		public var parentDepartmentIdx:int;
		public var orderNo:int;
		public var lev:int;
		
		public var id:String;
		public var username:String;
		public var mobileNo:String;
		public var positionName:String;
		public var connStatusCd:String;
		public var msgIntroduce:String;
		
		public var label:String;
		public var parent:OrgVO;
		public var children:ArrayCollection;
		public var isOpen:Boolean;
		public var checked:String = "0";
		
		public function OrgVO( obj:Object=null ):void
		{
			if ( obj is OrgInfoVO )
			{
				idx = obj.idx;
				siteIdx = obj.siteIdx;
				departmentName = obj.departmentName;
				parentDepartmentIdx = obj.parentDepartmentIdx;
				orderNo = obj.orderNo;
				lev = obj.lev;
			}
			
			if ( obj is OrgUserInfoVO )
			{
				id = obj.id;
				username = obj.username;
				mobileNo = obj.mobileNo;
				positionName = obj.positionName;
				connStatusCd = obj.connStatusCd;
				msgIntroduce = obj.msgIntroduce;
			}
		}
	}
}