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
	public class Soket 
	{
	 
		private var _messageCount:int=0;
		
		private var _interval:int;
		
		private var _usid:String="";
		private var _osid:String="";
		private var _yt:String="";
		private var _qeyd:String="";
		private var _mesaj:String="";
		
		
		 
		private var _istif:String;
 
		
		private var _suret:Number;
		private var _say:int;
		private var _qeyd1:String;
		private var _say1:Number;
		
		protected var g:Geolocation = new Geolocation();    
		
		
		
		 
		public function Soket()
		{
		 
			
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
			
			 
			gonderXml(event.longitude.toString(),event.latitude.toString(),event.altitude.toString(),+
				 
				_suret
			 );
			
		}
		 
		public   function  get istif():String {
			return _istif;
		}
		public   function  set istif(pst:String):void {
			_istif=pst;
		}
		
		public   function  get usid():String {
			return _usid;
		}
		public   function  set usid(pst:String):void {
			_usid=pst;
		}
		
		public   function  get osid():String {
			return _osid;
		}
		public   function  set osid(pst:String):void {
			_osid=pst;
		}
		public   function  get mesaj():String {
			return _mesaj;
		}
		public   function  set mesaj(pst:String):void {
			_mesaj=pst;
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
		 
		
		public function gonderXml(x:String,y:String,z:String, suret:Number 
								 ):void 
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
			 
			_messageCount++;
			var gdata:String="EXEC Mufettis.dbo.MobGpsData "+usid+","+osid+",'"+qeyd+"','"+mesaj+"',"+x+","+y+","+z+",'"+stt+"'";
			nlib.GetUrl(gdata,function aa():void{});
			 
		 
			 
			trace(" socket.send(xml) : " +gdata );
			
		}
		
	}
}


