////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.utils
{
	import com.b2max.common.data.ConstData;
	
	import mx.core.FlexGlobals;

	public class CommonUtil
	{
		public static function getLengthUserName( str:String, length:int=5 ):String
		{
			if ( str.length > length )
				str = str.slice( 0, length ) + "..";
			
			return str;
		}
		
		public static function getFileExtension( fileExtension:Array, separator:String ):String
		{
			var extensionStr:String = "";
			var len:int = ConstData.FILE_EXTENSION_DOC.length;
			var index:int = 0;
			for each ( var extension:String in fileExtension )
			{
				index++;
				if ( index == len ) extensionStr += "*." + extension;
				else				extensionStr += "*." + extension + separator + " ";
			}
			//trace( ":::: extensionStr : " + extensionStr );
			return extensionStr;
		}
		
		
		/**
		 * 파일명을 받아와서 확장자를 구한다. 
		 */
		public static function getExtension(fileName:String):String
		{
			return fileName.substring(fileName.lastIndexOf(".")+1, fileName.length);
		}
		
		/**
		 * 파일명을 받아와서 파일타입이 이미지인지 구한다.
		 */
		public static function isImage(fileName:String):Boolean
		{
			var flag:Boolean = false;
			
			for(var i:int=0; i<ConstData.FILE_EXTENSION_IMG.length; i++)
			{
				if(ConstData.FILE_EXTENSION_IMG[i] == getExtension(fileName).toString().toLocaleLowerCase())
				{
					flag = true;		
				}
			}
			return flag;
		}
		
		public static function getParameter( paramName:String ):String
		{
			return FlexGlobals.topLevelApplication.parameters[paramName];
		}
		
		public static function getParameterBoolean( paramName:String ):Boolean
		{
			return FlexGlobals.topLevelApplication.parameters[paramName] as Boolean;
		}
		
		public static function getStrToArray( str:String, delim:String ):Array
		{
			if ( ValidateUtil.isNull( str ) ) return [];
			
			var arr:Array = str.split( delim );
			if ( arr == null || arr.length == 0 ) return [];
			
			return arr;
		}
	}
}