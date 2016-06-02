package com.b2max.common.ui.utils
{
	import flash.text.TextLineMetrics;
	
	import mx.core.UIComponent;

	public class DisplayObjectUtil
	{
		/**
		 * Set button width to text width in flex.
		 * This function will accept the text and the UI component and set the width to the width of the text
		 * @param text the text or label of the component
		 * @param container the container casted to a UIComponent
		 *
		 */
		public static function measureTextWidthAndResizeComponent( text:String, container:UIComponent ):void
		{
			var _measuredWidth:Number = 0;
			var  _paddingLeft:uint = 0;
			var _paddingRight:uint = 0;
			var _horizontalGap:uint = 0;
			var _addedToWidth:int;
			
			if(text == null)
				return;
			
			if(text.length <= 1)
				return;
			
			_paddingLeft = container.getStyle("paddingLeft");
			_paddingRight = container.getStyle("paddingRight");
			_horizontalGap = container.getStyle("horizontalGap");
			
			_addedToWidth = int(_horizontalGap + _paddingLeft + _paddingRight);
			
			var lineMetrics:TextLineMetrics = container.measureText( text );
			
			_measuredWidth = ( lineMetrics.width + _addedToWidth );
			container.width = _measuredWidth;
		}
	}
}