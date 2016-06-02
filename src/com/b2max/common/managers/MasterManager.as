////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.managers
{
	import flash.system.Security;

	public class MasterManager
	{ 
		private static var _instance:MasterManager;
		
		public var interfaceManager:Object;
		
		public function MasterManager( secure:PrivateClass ) {}
		
		public static function getInstance():MasterManager
		{
			if ( !_instance ) 
			{
				_instance = new MasterManager( new PrivateClass() );
				_instance.interfaceManager = {};
				
//				Security.loadPolicyFile( ConnectProperties.POLICY_FILE_URL );
//				Security.allowDomain( ConnectProperties.URL_POLICY );
//				Security.allowInsecureDomain( ConnectProperties.URL_POLICY );
			}
			
			return _instance;
		}
	}
}
class PrivateClass
{
	public function PrivateClass() {}
}