//package com.b2max.common.ui.controls
//{
//	import flash.display.Sprite;
//	import flash.geom.Matrix;
//	import flash.media.Video;
//	
//	public class MobileVideo extends Sprite
//	{
//		private var originalWidth:Number=0;
//		private var originalHeight:Number=0;
//		private var video:Video;
//		
//		public function MobileVideo(video:Video, camIndex:int)
//		{
//			super();
//			
//			this.video=video;
//			originalWidth=video.width;
//			originalHeight=video.height;
//			addChild(video);
//			if(camIndex == 1)
//				frontCamera();
//			else
//				backCamera();
//		}
//		
//		
//		private function frontCamera():void
//		{
//			var mat:Matrix=transform.matrix;
//			var cx:Number=originalWidth / 2;
//			var cy:Number=originalHeight / 2;
//			mat.identity();
//			mat.a=-1;
//			mat.tx=originalWidth;
//			mat.translate(-cx, -cy);
//			mat.rotate(90 * Math.PI / 180);
//			transform.matrix=mat;
//			width=video.height;
//			height=video.width + 1;	 
//		}
//		
//		
//		private function backCamera():void
//		{
//			//			var mat:Matrix=container.transform.matrix;
//			//			var cx:Number=originalWidth / 2;
//			//			var cy:Number=originalHeight / 2;
//			//			mat.identity();
//			//			mat.translate(-cx, -cy);
//			//			mat.rotate(Math.PI / 2);
//			//			container.transform.matrix=mat;
//			//			width=container.height;
//			//			height=container.width;	 
//		}
//	}
//}



package com.b2max.common.ui.controls
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.media.Video;
	
	public class MobileVideo extends Sprite
	{
		private var container:Sprite;
		private var originalWidth:Number=0;
		private var originalHeight:Number=0;
		private var video:Video;
		
		public function MobileVideo(video:Video, camIndex:int)
		{
			super();
			
			container=new Sprite;
			addChild(container);
			this.video=video;
			originalWidth=video.width;
			originalHeight=video.height;
			container.addChild(video);
			if(camIndex == 1)
				frontCamera();
			else
				backCamera();
		}
		
		
		public function frontCamera():void
		{
			var mat:Matrix=container.transform.matrix;
			var cx:Number=originalWidth / 2;
			var cy:Number=originalHeight / 2;
			mat.identity();
			mat.a=-1;
			mat.tx=originalWidth;
			mat.translate(-cx, -cy);
			mat.rotate(90 * Math.PI / 180);
			container.transform.matrix=mat;
			width=container.height;
			height=container.width + 1;	 
			container.x = container.x + cy;
			container.y = container.y + cx;
		}
		
		
		public function backCamera():void
		{
			var mat:Matrix=container.transform.matrix;
			var cx:Number=originalWidth / 2;
			var cy:Number=originalHeight / 2;
			mat.identity();
			mat.translate(-cx, -cy);
			mat.rotate(Math.PI / 2);
			container.transform.matrix=mat;
			width=container.height;
			height=container.width;	 
			container.x = container.x + cy;
			container.y = container.y + cx;
		}
	}
}
