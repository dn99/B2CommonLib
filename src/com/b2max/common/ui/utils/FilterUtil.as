package com.b2max.common.ui.utils
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;

	/**
	 *  FilterUtil
	 */ 
	public class FilterUtil
	{
		/**
		 *  GlowFilter 객체 생성 반환
		 * 
		 *  @param color 컬러.
		 *  @param alpha 투명도.
		 *  @param blurX X축 블러 범위.
		 *  @param blurY Y축 블러 범위.
		 *  @param inner inner여부, default false.
		 * 
		 *  @return GlowFilter
		 */ 
		public static function setGlowFilter(color:uint, alpha:Number, blurX:int, blurY:int, inner:Boolean=false):GlowFilter
		{
			var glowFilter:GlowFilter = new GlowFilter();
			glowFilter.color = color;
			glowFilter.alpha = alpha;
			glowFilter.blurX = blurX;
			glowFilter.blurY = blurY;
			glowFilter.inner = inner;

			glowFilter.quality = BitmapFilterQuality.HIGH;

			return glowFilter;
		}

		/**
		 *  DropShadowFilter 객체 생성 반환
		 * 
		 *  @param color 컬러.
		 *  @param alpha 투명도.
		 *  @param blurX X축 블러 범위.
		 *  @param blurY Y축 블러 범위.
		 *  @param angle 그림자 방위 수치.
		 *  @param distance 그림자 거리 수치.
		 *  @param inner inner여부, default false.
		 *  @param knockout knockout.
		 * 
		 *  @return DropShadowFilter
		 */ 
		public static function setDropShadowFilter(color:uint, alpha:Number, blurX:int, blurY:int, angle:int, distance:int, inner:Boolean = false, knockout:Boolean = false):DropShadowFilter
		{
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter();
			dropShadowFilter.color = color;
			dropShadowFilter.blurX = blurX;
			dropShadowFilter.blurY = blurY;
			dropShadowFilter.angle = angle;
			dropShadowFilter.distance = distance;
			dropShadowFilter.inner = inner;
			dropShadowFilter.knockout = knockout;
			dropShadowFilter.alpha = alpha;

			dropShadowFilter.quality = BitmapFilterQuality.HIGH;

			return dropShadowFilter;
		}
	}
}