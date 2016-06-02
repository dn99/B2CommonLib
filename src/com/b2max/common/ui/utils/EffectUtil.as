package com.b2max.common.ui.utils
{
	import mx.effects.Parallel;
	
	import spark.effects.Fade;
	import spark.effects.Move;
	import spark.effects.Resize;

	public class EffectUtil
	{
		public static function getEffectResize( target:Object, 
												widthTo:Number=-1, heightTo:Number=-1, 
												isPlay:Boolean=true, duration:int=200 ):Resize
		{
			var resize:Resize = new Resize( target );
			resize.duration = duration;
			
			if ( target.width == widthTo ) widthTo = -1;
			if ( target.height == heightTo ) heightTo = -1;
			
			if ( widthTo != -1 ) resize.widthTo = widthTo;
			if ( heightTo != -1 ) resize.heightTo = heightTo;
			
			
			if ( isPlay ) resize.play();
			
			return resize;
		}
		
		public static function getEffectAlpah( target:Object, 
											   alphaTo:Number=-1,
											   isPlay:Boolean=true, duration:int=200 ):Fade
		{
			var fade:Fade = new Fade( target );
			fade.duration = duration;
			
			if ( target.alpha == alphaTo ) alphaTo = -1;
			
			if ( alphaTo != -1 ) fade.alphaTo = alphaTo;
			
			if ( isPlay ) fade.play();
			
			return fade;
		}
		
		public static function getEffectMove( target:Object, 
											  xTo:Number=-1, yTo:Number=-1, 
											  isPlay:Boolean=true, duration:int=200 ):Move
		{
			var move:Move = new Move( target );
			move.duration = duration;
			
			if ( target.x == xTo ) xTo = -1;
			if ( target.y == yTo ) yTo = -1;
			
			if ( xTo != -1 ) move.xTo = xTo;
			if ( yTo != -1 ) move.yTo = yTo;
			
			if ( isPlay ) move.play();
			
			return move;
		}
		
		public static function getEffectParallel( target:Object, 
												  widthTo:Number=-1, heightTo:Number=-1, 
												  xTo:Number=-1, yTo:Number=-1, 
												  isPlay:Boolean=true, duration:int=200 ):Parallel
		{
			var parallel:Parallel = new Parallel();
			parallel.duration = duration;
			
			var resize:Resize = getEffectResize( target, widthTo, heightTo, false );
			var move:Move = getEffectMove( target, xTo, yTo, false );
			
			parallel.addChild( resize );
			parallel.addChild( move );
			
			if ( isPlay ) parallel.play();
			
			return parallel;
		}
	}
}