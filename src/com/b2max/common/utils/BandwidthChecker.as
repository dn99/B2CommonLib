package com.b2max.common.utils
{
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.system.Security;
	
	import mx.charts.ColumnChart;
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.controls.TextArea;
	
	import spark.components.Application;

	public class BandwidthChecker extends Application
	{
		Security.LOCAL_TRUSTED;

		public var nc:NetConnection;
		private var data:Object = new Object();

		private var testNumber:int = 0;

		public var output:TextArea;
		public var runButton:Button;

		private var run:Boolean = false;

		public var chart:ColumnChart = new ColumnChart();

		[Bindable]
		public var chartData:ArrayCollection = new ArrayCollection();


		public function start():void
		{
			testNumber = 0;
			chartData = new ArrayCollection()
			var clientObj:Object = new Object();

			if (run)
			{
				run = false;
				runButton.label = "Run";
			}
			else
			{	
				runButton.label = "Stop";
				run = true;
				doClientBWCheck();		
			}
		}
		private function doClientBWCheck():void
		{
			output.text = "";

			data.latency = 0;
			data.cumLatency = 1;
			data.bwTime = 0;
			data.count = 0;
			data.sent = 0;
			data.kbitUp = 0;
			data.deltaUp = 0;
			data.deltaTime = 0;
			data.pakSent = new Array();
			data.pakRecv = new Array();
			data.beginningValues = {};

			nc.call("onClientBWCheck", new Responder(bwResponse));
		}

		private function bwResponse(p_res:Object):void
		{
			var deltaTime:Number;
			var deltaUp:Number;
			var kbitUp:Number;
			var payload:Array = new Array();
			for (var i:int=0; i<1200; i++){
				payload[i] = Math.random();	//16K approx
			}

			var now:Number = (new Date()).getTime()/1;
			if(data.sent == 0) {
				data.beginningValues = p_res;
				data.beginningValues.time = now;
				data.pakSent[data.sent++] = now;
				nc.call("onClientBWCheck", new Responder(bwResponse), now);
			} else {
				data.pakRecv[data.count] = now;
				//trace( "Packet interval = " + (data.pakRecv[data.count] - data.pakSent[data.count])*1  );
				output.text += "Packet interval = " + (data.pakRecv[data.count] - data.pakSent[data.count])*1  ;
				data.count++;
				var timePassed:Number = (now - data.beginningValues.time);

				if (data.count == 1) {
					data.latency = Math.min(timePassed, 800);
					data.latency = Math.max(data.latency, 10);
					data.overhead = p_res.cOutBytes - data.beginningValues.cOutBytes;
					//trace("overhead: "+data.overhead);
					data.pakSent[data.sent++] = now;
					nc.call("onClientBWCheck", new Responder(bwResponse), now, payload);
				}
				//trace("count: "+data.count+ " sent: "+data.sent+" timePassed: "+timePassed+" latency: "+data.latency);

				output.text += "count: "+data.count+ " sent: "+data.sent+" timePassed: "+timePassed+" latency: "+data.latency+"\n";

				// If we have a hi-speed network with low latency send more to determine
				// better bandwidth numbers, send no more than 6 packets
				if ( (data.count >= 1) && (timePassed<1000))
				{
					data.pakSent[data.sent++] = now;
					data.cumLatency++;
					nc.call("onClientBWCheck", new Responder(bwResponse), now, payload);
				} else if ( data.sent == data.count ) {	
					// See if we need to normalize latency
					if ( data.latency >= 100 )
					{ // make sure we detect sattelite and modem correctly
						if (  data.pakRecv[1] - data.pakRecv[0] > 1000 )
						{
							data.latency = 100;
						}
					}
					payload = new Array();
					// Got back responses for all the packets compute the bandwidth.
					var stats:Object = p_res;
					deltaUp = (stats.cOutBytes - data.beginningValues.cOutBytes)*8/1000;
					deltaTime = ((now - data.beginningValues.time) - (data.latency * data.cumLatency) )/1000;
					if ( deltaTime <= 0 )
						deltaTime = (now - data.beginningValues.time)/1000;

					kbitUp = Math.round(deltaUp/deltaTime);
					//trace("onBWDone: kbitUp = " + kbitUp + ", deltaUp= " + deltaUp + ", deltaTime = " + deltaTime + ", latency = " + data.latency + " KBytes " + (stats.cOutBytes - data.beginningValues.cOutBytes)/1024) ;
					output.text = "kbitUp = " + kbitUp + ", deltaUp= " + deltaUp + ", deltaTime = " + deltaTime + ", latency = " + data.latency + " KBytes " + (stats.cOutBytes - data.beginningValues.cOutBytes)/1024  + "/n/n" + output.text;	

					var obj:Object = new Object();
					obj.kbitUp = kbitUp;
					obj.deltaUp = deltaUp;
					obj.deltaTime = deltaTime;
					obj.latency = data.latency;
					obj.KBytes = (stats.cOutBytes - data.beginningValues.cOutBytes)/1024;
					obj.testNumber = "Test # " + ++testNumber;
					chartData.addItemAt(obj,0);

					if (run)
						doClientBWCheck();
				}
			}
		}
	}
}

