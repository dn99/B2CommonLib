package com.b2max.common.utils
{
	import flash.display.Bitmap;

	/**
	 *  ValidateUtil
	 */
	public class ValidateUtil
	{
		/**
		 *  입력값이 특정 문자(chars)만으로 되어있는지 체크
		 * 	특정 문자만 허용하려 할 때 사용
		 *	ex) if (!hasCharsOnly(form.blood,"ABO")) {....}
		 *
		 * 	@param input	 입력값
		 * 	@param chars	 특정문자
		 *
		 * 	@return Boolean
		 */
		public static function hasCharsOnly( input:String, chars:String ):Boolean
		{
			for (var inx:int = 0; inx < input.length; inx++)
			{
				if (chars.indexOf(input.charAt(inx)) == -1)
					return false;
			}
			return true;
		}

		/**
		 *  입력값에 숫자만 있는지 체크
		 * 	(번호 입력란 체크.금액입력란은 isNumComma를 사용해야 합니다.)
		 *
		 * 	@param input	 입력값
		 *
		 * 	@return Boolean
		 */
		public static function isNumber( input:String ):Boolean
		{
			var chars:String = "0123456789";
			return hasCharsOnly(input, chars);
		}

		/**
		 *  입력값이 null이거나 값이 없는지를 체크
		 *
		 *  @param input	 입력값
		 *
		 *  @return Boolean
		 */
		public static function isNull( input:* ):Boolean
		{
			return ( input == null || input == "" || input == "null" || input == "NULL" ) ? true : false;
		}

		/**
		 *  링크 설정
		 *  @param url 링크 URL.
		 *  @param window, _self, _blank.
		 */
		public static function getNavigateURL( url:String ):String
		{
			if (url.indexOf("http://") == -1)
				url = "http://" + url;

			return url;
		}

	}
}