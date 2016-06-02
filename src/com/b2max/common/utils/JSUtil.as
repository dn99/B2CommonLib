package com.b2max.common.utils
{
	    import flash.external.ExternalInterface;
	 
	     /**
	      * Browser detect
	      * @author Yongho Ji
	      * @since 2009.03.24
	      * @see http://www.quirksmode.org/js/detect.html
	      */
	    public class JSUtil
	    {
		         /**
		          * Here we define javascript functions which will be inserted into the DOM
		          */
		        private static const DATA_OS:String =
			                "var dataOS = [" +
			                    "{" +
			                        "string: navigator.platform," +
			                        "subString: \"Win\"," +
			                        "identity: \"Windows\"" +
			                    "}," +
			                    "{" +
			                        "string: navigator.platform," +
			                        "subString: \"Mac\"," +
			                        "identity: \"Mac\"" +
			                    "}," +
			                    "{" +
			                        "string: navigator.userAgent," +
			                        "subString: \"iPhone\"," +
			                        "identity: \"iPhone/iPod\"" +
			                    "}," +
			                    "{" +
			                        "string: navigator.platform," +
			                        "subString: \"Linux\"," +
			                        "identity: \"Linux\"" +
			                    "}" +
			                "];";
		 
		        private static const DATA_BROWSER:String =
			                "var dataBrowser = [" +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"Chrome\"," +
			                            "identity: \"Chrome\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"OmniWeb\"," +
			                            "versionSearch: \"OmniWeb/\"," +
			                            "identity: \"OmniWeb\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.vendor," +
			                            "subString: \"Apple\"," +
			                            "identity: \"Safari\"," +
			                            "versionSearch: \"Version\"" +
			                        "}," +
			                        "{" +
			                            "prop: window.opera," +
			                            "identity: \"Opera\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.vendor," +
			                            "subString: \"iCab\"," +
			                            "identity: \"iCab\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.vendor," +
			                            "subString: \"KDE\"," +
			                            "identity: \"Konqueror\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"Firefox\"," +
			                            "identity: \"Firefox\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.vendor," +
			                            "subString: \"Camino\"," +
			                            "identity: \"Camino\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"Netscape\"," +
			                            "identity: \"Netscape\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"MSIE\"," +
			                            "identity: \"Explorer\"," +
			                            "versionSearch: \"MSIE\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"Gecko\"," +
			                            "identity: \"Mozilla\"," +
			                            "versionSearch: \"rv\"" +
			                        "}," +
			                        "{" +
			                            "string: navigator.userAgent," +
			                            "subString: \"Mozilla\"," +
			                            "identity: \"Netscape\"," +
			                            "versionSearch: \"Mozilla\"" +
			                        "}" +
			                    "];";       
		 
		        private static const FUNCTION_SEARCH_BROWSER:String =
			            "document.insertScript = function ()" +
			            "{" +
			                "if (document.searchBrowser==null)" +
			                "{" +
			                    "searchBrowser = function ()" +
			                    "{" +
			                        "var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;"+
									"var isFirefox = typeof InstallTrigger !== 'undefined';"+   
									"var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;"+
									"var isChrome = !!window.chrome && !isOpera;"+             
									"var isIE = false || !!document.documentMode;"+
									
									"var browser;"+
									
									"if(isOpera){"+
										"return 'Opera';"+
									"}else if(isFirefox){"+
										"return 'Firefox';"+
									"}else if(isSafari){"+
										"return 'Safari';"+
									"}else if(isChrome){"+
										"return 'Chrome';"+
									"}else if(isIE){"+
										"return 'IE';"+
									"}"+
			                    "}" +
			                "}" +
			            "}";
		 
		        private static const FUNCTION_SEARCH_BROWSER_VERSION:String =
			            "document.insertScript = function ()" +
			            "{" +
			                "if (document.searchBrowserVersion==null)" +
			                "{" +
			                    "searchBrowserVersion = function () " +
			                    "{" +
			                        DATA_BROWSER +
			                        "var browser;" +
			                        "for (var i=0;i<dataBrowser.length;i++)  " +
			                        "{" +
			                            "var browserString = dataBrowser[i].string;" +
			                            "var browserProp = dataBrowser[i].prop;" +
			                            "if (browserString) " +
			                            "{" +
			                                "if (browserString.indexOf(dataBrowser[i].subString) != -1)" +
			                                "{" +
			                                    "browser = dataBrowser[i];" +
			                                    "break;" +
			                                "}" +
			                            "}" +
			                            "else if (browserProp)" +
			                            "{" +
			                                "browser = dataBrowser[i];" +
			                                "break;" +
			                            "}" +
			                        "}" +
			                        "var versionSearchString = browser.versionSearch || browser.identity;" +
			                        "var index;" +
			                        "var version;" +
			                        "version = navigator.appVersion;" +
			                        "index = version.indexOf(versionSearchString);" +
			                        "if (index != -1) " +
			                        "{" +
			                            "return parseFloat(version.substring(index+versionSearchString.length+1));" +
			                        "}" +
			                        "version = navigator.userAgent;" +
			                        "index = version.indexOf(versionSearchString);" +
			                        "if (index != -1) " +
			                        "{" +
			                            "return parseFloat(version.substring(index+versionSearchString.length+1));" +
			                        "}" +
			                        "return \"an unknown version\";" +
			                    "}"+
			                "}"+
			            "}";    
		 
		        private static const FUNCTION_SEARCH_OS:String =
			            "document.insertScript = function ()" +
			            "{" +
			                "if (document.searchOS==null)" +
			                "{" +
			                    "searchOS = function ()" +
			                    "{" +
			                        DATA_OS +
			                        "var os = null;" +
			                        "for (var i=0;i<dataOS.length;i++)   " +
			                        "{" +
			                            "var dataString = dataOS[i].string;" +
			                            "var dataProp = dataOS[i].prop;" +
			                            "if (dataString) " +
			                            "{" +
			                                "if (dataString.indexOf(dataOS[i].subString) != -1)" +
			                                "{" +
			                                    "os = dataOS[i].identity;" +
			                                    "break;" +
			                                "}" +
			                            "}" +
			                            "else if (dataProp)" +
			                            "{" +
			                                "os = dataOS[i].identity;" +
			                                "break;" +
			                            "}" +
			                        "}" +
			                        "if( os == null )" +
			                        "{" +
			                            "os = \"An unknown OS\";" +
			                        "}" +
			                        "return os;" +
			                    "}"+
			                "}"+
			            "}";    
		 
		
				/**
				 * OS 비트수 구하는 스크립트 
				 */
				private static const FUNCTION_SEARCH_OS_BIT:String =
					"document.insertScript = function ()" +
					            "{" +
					                "if (document.searchOSbit==null)" +
					                "{" +
					                    "searchOSbit = function ()" +
					                    "{" +
											"var b, fi, r, w;"+
											"w = window.navigator.platform;"+
											"fi = function(s) {"+
											"return window.navigator.userAgent.indexOf(s) > -1;"+
										"};"+
									"if (fi('x86_64') || fi('x86-64') || fi('Win64') || fi('x64;') || fi('amd64') || fi('AMD64') || fi('WOW64') || fi('x64_64') || w === 'MacIntel' || w === 'Linux x86_64') {"+
										"b = 64;"+
									"} else if (w === 'Linux armv7l' || w === 'iPad' || w === 'iPhone' || w === 'Android' || w === 'iPod' || w === 'BlackBerry') {"+
										"b = 0;"+
									"} else if (w === 'Linux i686') {"+
										"b = -1;"+
									"}"+
									"if (b === -1) {"+
										"r = 'unknown';"+
									"} else if (b === 0) {"+
										"r = 'tablet.';"+
									"} else if (b === 64) {"+
										"r = '64';"+
									"} else {"+
										"r = '32';"+
									"}"+
										"return r;"+			
					      			    "}"+
					                "}"+
					            "}";  
				
					
			   /**
			    * 호스트 주소 알아내는 스크립트 
			    */		
			   private static const FUNCTION_SEARCH_HOST:String =
					            "document.insertScript = function ()" +
					            "{" +
					                "if (document.searchHost==null)" +
					                "{" +
					                    "searchHost = function ()" +
					                    "{" +
											"return window.location.host;"+
					                    "}" +
					                "}" +
					            "}";

			
		        private static var initFlag:Boolean = false;
		        private static var _browserVersion:String = null;
		        private static var _browser:String = null;
		        private static var _os:String = null;
		 		private static var _osBit:String = null;
				private static var _host:String = null;
				
		        private static function insertScript():void
		        {
			            if( initFlag ) return;
			            if (! ExternalInterface.available)
			            {
				                throw new Error("ExternalInterface is not available in this container. Internet Explorer ActiveX, Firefox, Mozilla 1.7.5 and greater, or other browsers that support NPRuntime are required.");
			            }
			 
			            initFlag = true;
			            ExternalInterface.call( FUNCTION_SEARCH_BROWSER );
			            ExternalInterface.call( FUNCTION_SEARCH_BROWSER_VERSION );
			            ExternalInterface.call( FUNCTION_SEARCH_OS );
			            ExternalInterface.call( FUNCTION_SEARCH_OS_BIT );
			            ExternalInterface.call( FUNCTION_SEARCH_HOST );
		        }
		 
		         /**
		          * browser name
		          */
		        public static function get browser():String
		        {
			            if( _browser ) return _browser;
			            insertScript();
			            _browser = ExternalInterface.call( "searchBrowser" );
			            return _browser;
		        }
		 
		        /**
		         * browser version
		         */
		        public static function get browserVersion():String
		        {
			            if( _browserVersion ) return _browserVersion;
			            insertScript();
			            _browserVersion = ExternalInterface.call( "searchBrowserVersion" );
			            return _browserVersion;
		        }
		 
		        /**
		         * OS name
		         */
		        public static function get OS():String
		        {
			            if( _os ) return _os;
			            insertScript();
			            _os = ExternalInterface.call( "searchOS" );
			            return _os;
		        }
		 
		  	    /**
		         * OS bit
		         */
		        public static function get osBit():String
		        {
			            if( _osBit ) return _osBit;
			            insertScript();
			            _osBit = ExternalInterface.call( "searchOSbit" );
			            return _osBit;
		        }
		
		  	    /**
		         * hostName
		         */
		        public static function get host():String
		        {
			            if( _host ) return _host;
			            insertScript();
			            _host = ExternalInterface.call( "searchHost" );
						if(_host.length == 0) _host="localhost";
			            return _host;
		        }
		
		
				/**
		         * ScreenShare애플릿 다운로드
		         */
		        public static function startScreenShareApplet():void
		        {
			            insertScript();
						ExternalInterface.call( "startScreenShare" );
		        }
	    }
}