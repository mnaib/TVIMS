package com
{ import components.*;
	
	import flash.events.*;
	import flash.events.TimerEvent;
	import flash.net.XMLSocket;
	import flash.sensors.Geolocation;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.Float;
	
	import mx.formatters.Formatter;
	
	import spark.events.ViewNavigatorEvent;
	
	[Bindable]
	public class COSoket 
	{
		private var hostName:String ="ttnda.az";
		private var portNumber:int = 27006;
		private var _connected:Boolean;
		private var _messageCount:int=0;
		
		private var _interval:int;
		
		
		
		private var _ad:String;
		private var _istif:String;
		private var _obyekt:String;
		private var _qeyd:String;
		private var _suret:Number;
		private var _say:int;
		private var _qeyd1:String;
		private var _say1:Number;
		
		protected var g:Geolocation = new Geolocation();    
		
		
		
		private var socket:XMLSocket;
		
		public function Soket()
		{
			socket = new XMLSocket();
			configureListeners(socket);
			
			if(Geolocation.isSupported)
			{ 					
				g = new Geolocation(); 
				
				if(g.muted){ 
					
					
					MobileAlert.show("GPS işə salın\n" , 'Məlumat');						
					trace("Hey, turn on your GPS please"); 
					
				} 
				
				
				g.setRequestedUpdateInterval(_interval); 
				
				
				g.addEventListener(GeolocationEvent.UPDATE,onUpdate);       
				g.removeEventListener(GeolocationEvent.UPDATE,onUpdate);	
				
				
			} else 
			{ 
				
				trace("GPS not supported"); 
				//testduz				MobileAlert.show("GPS YOXDUR\n " , 'Məlumat');	
			} 
			
			
		} 
		
		
		
		protected function onUpdate(event:GeolocationEvent):void
		{
			trace("Update event called");
			
			if (!connected) connects();
			gonderXml(event.longitude.toString(),event.latitude.toString(),event.altitude.toString(),_ad,
				_istif,
				_obyekt,
				_qeyd,
				_suret,
				_say,
				_qeyd1,
				_say1);
			
		}
		
		
		public   function  get ad():String {
			return _ad;
		}
		public   function  set ad(pst:String):void {
			_ad=pst;
		}
		
		
		public   function  get istif():String {
			return _istif;
		}
		public   function  set istif(pst:String):void {
			_istif=pst;
		}
		
		
		public   function  get obyekt():String {
			return _obyekt;
		}
		public   function  set obyekt(pst:String):void {
			_obyekt=pst;
		}
		
		
		public   function  get qeyd():String {
			return _qeyd;
		}
		public   function  set qeyd(pst:String):void {
			_qeyd=pst;
		}
		
		
		public   function  get suret():Number {
			return _suret;
		}
		public   function  set suret(pst:Number ):void {
			_suret=pst;
		}
		
		
		public   function  get say():int {
			return _say;
		}
		public   function  set say(pst:int):void {
			_say=pst;
		}
		
		
		public   function  get qeyd1():String {
			return _qeyd1;
		}
		public   function  set qeyd1(pst:String):void {
			_qeyd1=pst;
		}
		
		
		
		public   function  get say1():Number {
			return _say1;
		}
		public   function  set say1(pst:Number):void {
			_say1=pst;
		}
		
		
		
		
		
		
		
		
		
		
		public   function  set host(hst:String):void {
			hostName=hst;
		}
		
		
		public   function  get connected():Boolean {
			_connected=socket.connected;
			return _connected;
		}
		public   function  set port(pst:int):void {
			portNumber=pst;
		}
		
		public   function  get messageCount():int {
			return _messageCount;
		}
		public   function  set messageCount(pst:int):void {
			_messageCount=pst;
		}
		public   function  get interval():int {
			return _interval;
		}
		
		public   function  set interval(pst:int):void {
			
			_interval=pst;
			g.setRequestedUpdateInterval(_interval); 
		}
		public function connects():void
		{
			
			socket.connect(hostName, portNumber);
		}
		
		
		public function connect(hst:String,pst:int):void
		{
			hostName=hst;
			portNumber=pst;
			socket.connect(hostName, portNumber);
		}
		
		
		public function start():void
		{
			
			g.addEventListener(GeolocationEvent.UPDATE,onUpdate);    
		}
		
		
		public function stop():void {
			
			g.removeEventListener(GeolocationEvent.UPDATE,onUpdate);
		}
		
		
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(Event.CONNECT, connectHandler);
			dispatcher.addEventListener(DataEvent.DATA, dataHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
		}
		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
			
		}
		private function dataHandler(event:DataEvent):void {
			trace("dataHandler: " + event);
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		public function sendxml(data:Object):void {
			socket.send(data);
			_messageCount++;
		}
		
		public function gonderXml(x:String,y:String,z:String,
								  ad:String,
								  istif:String,
								  obyekt:String,
								  qeyd:String,
								  suret:Number,
								  say:int,
								  qeyd1:String,
								  say1:Number):void 
		{
			
			
			//		_ad=ad;			
			////		_istif=istif;
			//		_obyekt=obyekt;
			//		_qeyd=qeyd;
			//		_suret=suret;
			//		_say=say;
			//		_qeyd1=qeyd1;
			//		_say1=say1;
			
			var st:String="\"";
			var dd:Date=new Date();
			
			var ss:String;
			if ((dd.month+1)<10)
				ss="0"+(dd.month+1).toString();
			else 
				ss=(dd.month+1).toString();
			var stt:String=ss+'/'+dd.date.toString()+'/'+dd.fullYear.toString()+" "+dd.hours.toString()+":"+dd.minutes.toString()+":"+dd.seconds;
			var 	xml:String;
			// {7CD77A74-CEC5-4ED2-8D29-6F0E39B0DC88}  
			xml=("<MESSAGE ID=\"" +"{F1C31E8F-8664-442C-AACD-3A8DE202A8CE}" + "\">");
			xml=xml+("<FIELD>" + x + "," + y + "," + z + "</FIELD>");
			xml=xml+("<FIELD>" + ad+ "</FIELD>");
			xml=xml+("<FIELD>" + istif+ "</FIELD>");
			xml=xml+("<FIELD>" + obyekt + "</FIELD>");
			xml=xml+("<FIELD>" + qeyd + "</FIELD>");
			
			xml=xml+("<FIELD>" + suret.toFixed(2)+ "</FIELD>");
			xml=xml+("<FIELD>" + say.toString()+ "</FIELD>");
			xml=xml+("<FIELD>" + qeyd1 + "</FIELD>");
			xml=xml+("<FIELD>" + say1.toFixed(3) + "</FIELD>");
			
			
			xml=xml+("<FIELD>" + stt + "</FIELD>");
			xml=xml+("</MESSAGE>");
			_messageCount++;
			socket.send(xml);
			trace(" socket.send(xml) : " );
			
		}
		
	}
}
