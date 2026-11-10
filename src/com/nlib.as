package com
{
	import com.adobe.serializers.xml.XMLDecoder;
	import com.probertson.utils.GZIPEncoder;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.net.drm.AuthenticationMethod;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.xml.XMLDocument;
	
	import mx.core.FlexGlobals;
	import mx.events.Request;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	
	import org.apache.flex.spark.components.progressBar.ProgressBar;
	import org.osmf.events.TimeEvent;
	
	import spark.components.BusyIndicator;
	import spark.components.Image;
	import spark.core.SpriteVisualElement;
	
 //	import mx.utils.Base64Decoder;

	[Bindable]
	public class nlib
	{
		public function nlib()	
		{
			/*
			var xxml:XML = <soapenv:Envelope 
			xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<soapenv:Body>
			<mycustomersResponse xmlns="http://Services.com">
			<mycustomersReturn>
			<age>28</age>
			<name>Jack</name>
			</mycustomersReturn>
			<mycustomersReturn>
			<age>29</age>
			<name>Ben</name>
			</mycustomersReturn>
			</mycustomersResponse>
			</soapenv:Body>
			</soapenv:Envelope> 
			
			namespace ns = "http://Services.com";
			use namespace ns;
			
			namespace ns_soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
			use namespace ns_soapenv;
			
			
			//		var localns:Namespace = new Namespace("http://toto.com/");
			
			//	var collection:XMLList = _xml..localns::CCollection;
			//	trace(collection.toString());
			
			
			
			
			trace(xxml.Body.mycustomersResponse.mycustomersReturn.length()); //output 2
			
			//+'	namespace ns = "http://microsoft.com/webservices";		use namespace ns;  namespace ns_soapenv = "http://schemas.xmlsoap.org/soap/envelope/";		use namespace ns_soapenv;'
			
			var	ssoaota :XMLDocument = new XMLDocument(event.target.data);*/
		}
		public static function GetCedvel(stt:String,ff:Function):void
		{
			var request:URLRequest = new URLRequest();
			
			
			request.url="https://service.ttnda.az/planset/GetDB.asmx?WSDL";
			request.method = URLRequestMethod.POST;
			
			request.contentType = "text/xml; charset=utf-8";
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvel"));
			request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <SOAP-ENV:Body>    <tns:Cedvel xmlns:tns="http://tempuri.org/">      <tns:query>  {stt}  </tns:query>    </tns:Cedvel>  </SOAP-ENV:Body></SOAP-ENV:Envelope>;
			
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;//.BINARY;//
			loader.addEventListener(Event.COMPLETE, ff, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ierr);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, serr); 
			
			trace("Geturl vurdu "+stt +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);	
			function ierr(event:Event):void {
				
				trace("GetFtp IOERROR" +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function serr(event:Event):void {
				
				trace("GetFtp SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			function complit(event:Event):void {
				
				ff(event);
				trace("GetURL hazir "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
		}	
	
		public static function GetUrl(stt:String,ff:Function,eerr:Function=null):void
		{
			var request:URLRequest = new URLRequest();
			
			var busi:BusyIndicator=new  BusyIndicator();
			busi.scaleX=2;
			busi.scaleY=2;
			busi.setStyle("symbolColor","red");
			var parent:Sprite = new Sprite(); // SpriteVisualElement?
			parent = Sprite(FlexGlobals.topLevelApplication);
			
			PopUpManager.addPopUp(busi, parent, false);;
			
			PopUpManager.centerPopUp(busi);
			request.url="https://service.ttnda.az/planset/GetDB.asmx?WSDL";
			request.method = URLRequestMethod.POST;
		 
			request.contentType = "text/xml; charset=utf-8";
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvells"));
			 request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 
			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <SOAP-ENV:Body>    <tns:Cedvells xmlns:tns="http://tempuri.org/">      <tns:query>  {stt}  </tns:query>    </tns:Cedvells>  </SOAP-ENV:Body></SOAP-ENV:Envelope>;
			
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;//.BINARY;//
			loader.addEventListener(Event.COMPLETE, complit, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ierr);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, serr); 
			
			trace("Geturl vurdu "+stt +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);	
			function ierr(event:Event):void {
				PopUpManager.removePopUp(busi);			
				busi=null;
				parent=null
				trace("GetFtp IOERROR" +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
		if (eerr) eerr(event);
			}
			
			function serr(event:Event):void {
				PopUpManager.removePopUp(busi);			
				busi=null;
				parent=null
				trace("GetFtp SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
				if (eerr) eerr(event);
			}
			function complit(event:Event):void {
				
				
				PopUpManager.removePopUp(busi);			
				busi=null;
				parent=null;
				ff(event);
				trace("GetURL hazir "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
		}
		
		public static function GetUrl2(stt:String,ff:Function):void
		{
			var request:URLRequest = new URLRequest();
		 
		 
			request.url="https://service.ttnda.az/planset/GetDB.asmx?WSDL";
			request.method = URLRequestMethod.POST;
			 
			request.contentType = "text/xml; charset=utf-8";
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvells"));
			request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <SOAP-ENV:Body>    <tns:Cedvells xmlns:tns="http://tempuri.org/">      <tns:query>  {stt}  </tns:query>    </tns:Cedvells>  </SOAP-ENV:Body></SOAP-ENV:Envelope>;
			
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;//.BINARY;//
			loader.addEventListener(Event.COMPLETE, complit, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ierr);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, serr); 
			
			trace("Geturl vurdu "+stt +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);	
			function ierr(event:Event):void {
				 
				trace("GetFtp IOERROR" +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function serr(event:Event):void {
			 
				trace("GetFtp SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			function complit(event:Event):void {
				 
			ff(event);
				

			}
			
		}
		public  static function DataToXml(sttt:Object):String
		{
			trace("Geturl convert " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			var	ssoaota :XMLDocument = new XMLDocument(sttt.data);
	 	var ssss:String=ssoaota.firstChild.firstChild.firstChild.firstChild.firstChild.nodeValue;
		//	var _byteArr:ByteArray=new ByteArray();
		// 	var deccoder :Base64Decoder =new Base64Decoder();
		// 	deccoder.decode(ssss);
			var encoder :GZIPEncoder = new GZIPEncoder();
		 //	_byteArr=deccoder.toByteArray();
	 var bbyteArr:ByteArray=Dekod.decode(ssoaota.firstChild.firstChild.firstChild.firstChild.firstChild.nodeValue);
	 bbyteArr.position=0
			var uncdompressedData:ByteArray =encoder.uncompressToByteArray(bbyteArr);
			uncdompressedData.position=0;
			
			return uncdompressedData.readUTFBytes(uncdompressedData.length ); ;
		}	
	
		public static function GetFtp(rfol:String,rfile:String,lfile:File,imagf:Function):void
		{
			 var request:URLRequest = new URLRequest();
			 trace("Getftpp "  + rfol+"--"+rfile );
			request.url="https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";
			request.method = URLRequestMethod.POST;
			//	request.contentType = "gzip";  Ekspertfhn.apk    EkolKS.apk,fprog:Function
			//	request.setPropertyIsEnumerable(				
			//	header("Content-Encoding: gzip");  name="remoteFolder" type="s:string" maxOccurs="1" minOccurs="0"/><s:element name="remoteFile" type="s:string" 
			request.contentType = "text/xml; charset=utf-8";
			
			//	urlRequest.contentType="application/octet-stream";
			//	urlRequest.method=URLRequestMethod.POST;
			//	urlRequest.data=byteArrayEncode; 
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qdown"));
			//	request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvel"));
			request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			
			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">  <SOAP-ENV:Body> 
<tns:qdown xmlns:tns="http://microsoft.com/webservices/">    
<tns:remoteFolder> {rfol}  </tns:remoteFolder> 
<tns:remoteFile>  {rfile} </tns:remoteFile> 					
</tns:qdown> 
</SOAP-ENV:Body></SOAP-ENV:Envelope>;
			 
			
			var parent:Sprite = new Sprite(); // SpriteVisualElement?
			parent = Sprite(FlexGlobals.topLevelApplication);
			var waitingpopup:ProgressBar;
			waitingpopup = new ProgressBar();
			waitingpopup.width=250;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
			waitingpopup.height=30;
		
			waitingpopup.currentProgress =0;
			waitingpopup.totalProgress= 1;
			PopUpManager.addPopUp(waitingpopup, parent, false);;
			
				waitingpopup.x=80;
		waitingpopup.y=15;
		waitingpopup.alpha=0.6;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onResult, false, 0, true);
			loader.addEventListener(ProgressEvent.PROGRESS, fprog, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onRervv);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRercc);
			function fprog (event:ProgressEvent):void
			{
				waitingpopup.currentProgress =event.bytesLoaded;
				waitingpopup.totalProgress= event.bytesTotal;
			//	trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
				
				 
			}      
			function onRervv(event:Event):void {	PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("GetFtp IOERROR" +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRercc(event:Event):void {	PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("GetFtp SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRer(event:Event):void {
				PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null;
				trace("GetFtp HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			trace(" GetFtp vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);
			
			
					
	
		function onResult(event:Event):void {
			PopUpManager.removePopUp(waitingpopup);			
			waitingpopup=null;
			parent=null;
			
			trace("GetFtp HAZIR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			var	ssoaota :XMLDocument = new XMLDocument(event.target.data);
			var fad:String=ssoaota.firstChild.firstChild.firstChild.firstChild.firstChild.firstChild.firstChild.nodeValue;
			var ffile:String=ssoaota.firstChild.firstChild.firstChild.firstChild.firstChild.lastChild.firstChild.nodeValue;
			
			trace("SERVIS DECODE Yazir" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			//	var deccoder:Base64Decoder  =new Base64Decoder();
			
			//	deccoder.decode(soawtao);
			trace("SERVIS DECODE222 Yazir" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			
			// var bbt:ByteArray= deccoder.toByteArray();
			var bbt:ByteArray= Dekod.decode(ffile);
			trace("SERVIS FAYL Yazir" +(new Date()).toString()+"--"+(new Date()).milliseconds);
		 
	
			var stream:FileStream = new FileStream();    
			stream.open(lfile , FileMode.WRITE);
			stream.writeBytes(bbt);
			//		stream.addEventListener(
			stream.close();
			stream=null;
	//		rez();
			imagf(event);
			trace("SERVIS HHHH Hazir" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
		}	
		public static function GetFtpn(rfol:String,rfile:String,imagf:Function):void
		{
			var request:URLRequest = new URLRequest();
			
			request.url="https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";
			request.method = URLRequestMethod.POST;
			//	request.contentType = "gzip";  Ekspertfhn.apk    EkolKS.apk,fprog:Function
			//	request.setPropertyIsEnumerable(				
			//	header("Content-Encoding: gzip");  name="remoteFolder" type="s:string" maxOccurs="1" minOccurs="0"/><s:element name="remoteFile" type="s:string" 
			request.contentType = "text/xml; charset=utf-8";
			
			//	urlRequest.contentType="application/octet-stream";
			//	urlRequest.method=URLRequestMethod.POST;
			//	urlRequest.data=byteArrayEncode; 
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qdown"));
			//	request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvel"));
			request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			
			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">  <SOAP-ENV:Body> 
<tns:qdown xmlns:tns="http://microsoft.com/webservices/">    
<tns:remoteFolder> {rfol}  </tns:remoteFolder> 
<tns:remoteFile>  {rfile} </tns:remoteFile> 					
</tns:qdown> 
</SOAP-ENV:Body></SOAP-ENV:Envelope>;
			
			
			var parent:Sprite = new Sprite(); // SpriteVisualElement?
			parent = Sprite(FlexGlobals.topLevelApplication);
			var waitingpopup:ProgressBar;
			waitingpopup = new ProgressBar();
			waitingpopup.width=250;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
			waitingpopup.height=30;
			
			waitingpopup.currentProgress =0;
			waitingpopup.totalProgress= 1;
			PopUpManager.addPopUp(waitingpopup, parent, false);;
			
			waitingpopup.x=80;
			waitingpopup.y=15;
			waitingpopup.alpha=0.6;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onRer, false, 0, true);
			loader.addEventListener(ProgressEvent.PROGRESS, fprog, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onRervvv);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRerccc);
			function fprog (event:ProgressEvent):void
			{
				waitingpopup.currentProgress =event.bytesLoaded;
				waitingpopup.totalProgress= event.bytesTotal;
				//	trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}      
			function onRervvv(event:Event):void {	PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("GetFtpN IOERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRerccc(event:Event):void {	PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("GetFtpN SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRer(event:Event):void {
				
				PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null;
				imagf(event);
				trace("GetFtpN HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			trace("SERVIS SSSS vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);
			
		}
		
		public static function GetFtpnm(rfol:String,rfile:String,imagf:Function):void
		{
			var request:URLRequest = new URLRequest();
			request.url="https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";
			
		//	request.url="http://localhost:49423/ftpwebservice.asmx?WSDL";
			request.method = URLRequestMethod.POST;
			//	request.contentType = "gzip";  Ekspertfhn.apk    EkolKS.apk,fprog:Function
			//	request.setPropertyIsEnumerable(				
			//	header("Content-Encoding: gzip");  name="remoteFolder" type="s:string" maxOccurs="1" minOccurs="0"/><s:element name="remoteFile" type="s:string" 
			request.contentType = "text/xml; charset=utf-8";
			
			//	urlRequest.contentType="application/octet-stream";
			//	urlRequest.method=URLRequestMethod.POST;
			//	urlRequest.data=byteArrayEncode; 
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qdownm"));
			//	request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvel"));
			
			request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">  <SOAP-ENV:Body> 
<tns:qdownm xmlns:tns="http://microsoft.com/webservices/">    
<tns:remoteFolder> {rfol}  </tns:remoteFolder> 
<tns:remoteFile>  {rfile} </tns:remoteFile> 					
</tns:qdownm> 
</SOAP-ENV:Body></SOAP-ENV:Envelope>;
			
			
			var parent:Sprite = new Sprite(); // SpriteVisualElement?
			parent = Sprite(FlexGlobals.topLevelApplication);
			var waitingpopup:ProgressBar;
			waitingpopup = new ProgressBar();
			waitingpopup.width=250;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
			waitingpopup.height=30;
			
			waitingpopup.currentProgress =0;
			waitingpopup.totalProgress= 1;
			PopUpManager.addPopUp(waitingpopup, parent, false);;
			
			waitingpopup.x=80;
			waitingpopup.y=15;
			waitingpopup.alpha=0.6;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onRer, false, 0, true);
			loader.addEventListener(ProgressEvent.PROGRESS, fprog, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onRervvv);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRerccc);
			function fprog (event:ProgressEvent):void
			{
				waitingpopup.currentProgress =event.bytesLoaded;
				waitingpopup.totalProgress= event.bytesTotal;
			//	trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}      
			function onRervvv(event:Event):void {	PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("GetFtpmn IOERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRerccc(event:Event):void {	PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("GetFtpnm SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRer(event:Event):void {
				
				PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null;
				imagf(event);
				trace("GetFtpnm HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			trace("SERVIS SSSS vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);
		
		}
		import flash.events.TimerEvent;
		public static function UpFtp(lf:File,rfol:String,rfile:String,imagf:Function):void
		{
			//	var inFile:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
			var inStream:FileStream=new FileStream();
			var dataf:ByteArray=new ByteArray();
			inStream.open(lf, FileMode.READ);
			
			inStream.readBytes(dataf, 0, dataf.length);
			inStream.close();
			var parent:Sprite = new Sprite(); // SpriteVisualElement?
			parent = Sprite(FlexGlobals.topLevelApplication);
			var waitingpopup:ProgressBar;
			waitingpopup = new ProgressBar();
			waitingpopup.width=250;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
			waitingpopup.height=30;
			waitingpopup.direction="left"
			waitingpopup.color=0x2bdc0e;
			waitingpopup.currentProgress =0;
			waitingpopup.totalProgress= 1;
			PopUpManager.addPopUp(waitingpopup, parent, false);;
			
			waitingpopup.x=80;
			waitingpopup.y=15;
			waitingpopup.alpha=0.6;
			waitingpopup.totalProgress= dataf.length;
			waitingpopup.currentProgress =dataf.length/9 ;
			
			
				var timer:Timer=new Timer(700);
	 			 
					timer.addEventListener(TimerEvent.TIMER, onTimer);
					timer.start();
	 	 function onTimer(event:TimerEvent):void{
			 waitingpopup.totalProgress= dataf.length;
					waitingpopup.currentProgress +=dataf.length/20 ;
				} 
				
					var rds:String=Dekod.encode(dataf);
				var urlRequest:URLRequest = new URLRequest();
				urlRequest.url = "https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";;
				urlRequest.contentType = 'text/xml; charset=utf-8';
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
				urlRequest.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

				urlRequest.data = 	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
					<SOAP-ENV:Body>  
					  <tns:qup xmlns:tns="http://microsoft.com/webservices/">   
					   <tns:fileData>{rds}</tns:fileData>    
					  <tns:filename>{rfile}</tns:filename> 
						 <tns:remotePath>{rfol}</tns:remotePath>  
					  </tns:qup>  </SOAP-ENV:Body>
					</SOAP-ENV:Envelope>;
			 
				//	/	 	urlRequest.requestHeaders.push( new URLRequestHeader( 'Content-type', 'text/xml; charset=utf-8' ) );
				//	http://microsoft.com/webservices/qup
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				/*urlLoader.addEventListener(Event.COMPLETE, onComplete);*/
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRerv);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRerc);
				urlLoader.addEventListener(Event.COMPLETE, onRer);
				urlLoader.addEventListener(ProgressEvent.PROGRESS, fprog);
			//	urlLoader.addEventListener(Event.COMPLETE, imagf);
				urlLoader.load(urlRequest);
				
				
				function onRerv(event:Event):void {
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, onTimer);
					timer = null;
					PopUpManager.removePopUp(waitingpopup);			
					waitingpopup=null;
					parent=null
						
					trace("Upftp IOERROR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
				}
				
				function onRerc(event:Event):void {
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, onTimer);
					timer = null;
					PopUpManager.removePopUp(waitingpopup);			
					waitingpopup=null;
					parent=null
						
					trace("UpFtp SECERROR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
				}
				
				function onRer(event:Event):void {
					waitingpopup.totalProgress= dataf.length;
					waitingpopup.currentProgress =dataf.length;
					
					
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, onTimer);
					timer = null;
					PopUpManager.removePopUp(waitingpopup);			
					waitingpopup=null;
					parent=null
					
					imagf(event);
					trace("UpFtp HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
				}
				function fprog (event:ProgressEvent):void
				{
				//	waitingpopup.currentProgress =event.bytesLoaded;
				//	trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
					
					
					
				}      
				
				
				trace("SERVIS SSSS vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
		 
			 
		}		
		public static function UpFtpB(dataf:ByteArray,rfol:String,rfile:String,imagf:Function,pogr:Boolean=false):void
		{
			
			
			//	var inFile:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
			
				var parent:Sprite = new Sprite(); // SpriteVisualElement?
			parent = Sprite(FlexGlobals.topLevelApplication);
			var waitingpopup:ProgressBar;
			waitingpopup = new ProgressBar();
			waitingpopup.width=250;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
			waitingpopup.height=30;
		 	waitingpopup.direction="left"
		 	waitingpopup.color=0x2bdc0e;
		 
			  waitingpopup.currentProgress =0;
			  waitingpopup.totalProgress= 1;
			PopUpManager.addPopUp(waitingpopup, parent, false);;
			
			waitingpopup.x=80;
			waitingpopup.y=15;
			waitingpopup.alpha=0.6;
			waitingpopup.totalProgress= dataf.length;
			waitingpopup.currentProgress =dataf.length/2 ;
			
			
			var timer:Timer=new Timer(700);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			function onTimer(event:TimerEvent):void{
				waitingpopup.totalProgress= dataf.length;
				waitingpopup.currentProgress +=dataf.length/20 ;
			} 
		//	PopUpManager.centerPopUp(waitingpopup);
			var rds:String=Dekod.encode(dataf);
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = "https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";;
			urlRequest.contentType = 'text/xml; charset=utf-8';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
			urlRequest.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			urlRequest.data = 	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
				<SOAP-ENV:Body>  
				  <tns:qup xmlns:tns="http://microsoft.com/webservices/">   
				   <tns:fileData>{rds}</tns:fileData>    
				  <tns:filename>{rfile}</tns:filename> 
					 <tns:remotePath>{rfol}</tns:remotePath>  
				  </tns:qup>  </SOAP-ENV:Body>
				</SOAP-ENV:Envelope>;
			
			//	/	 	urlRequest.requestHeaders.push( new URLRequestHeader( 'Content-type', 'text/xml; charset=utf-8' ) );
			//	http://microsoft.com/webservices/qup
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		 urlLoader.addEventListener(Event.COMPLETE,onRer );
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRerv);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRerc);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, fprog);
			
			trace("UpftpB STaRT-OPEN"  +"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			urlLoader.load(urlRequest);
			
			
			function onRerv(event:Event):void {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer = null;
				PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("UpftpB IOERROR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRerc(event:Event):void {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer = null;
				PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				trace("UpFtpB SECERROR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRer(event:Event):void {
				waitingpopup.totalProgress= dataf.length;
				waitingpopup.currentProgress =dataf.length;
				
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer = null;
				PopUpManager.removePopUp(waitingpopup);			
				waitingpopup=null;
				parent=null
				imagf(event);
				trace("UpFtpB HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			function fprog (event:ProgressEvent):void
			{
					waitingpopup.currentProgress =event.bytesLoaded;
				
			//	trace("UpFtpB PROGRESS"+ event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
				
				
			}      
			
			
			trace("SERVIS SSSS vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			
			
			
		}		
	
		public static function UpFtpf(lf:File,rfol:String,rfile:String,imagf:Function):void
		{
		
			var fileRef:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
	//	 filr.upload(
	//	var fileRef:FileReference   = new FileReference();
		//fileRef.browse();
		 
		fileRef.addEventListener(Event.COMPLETE, completeHandler);
		fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataComplete);
		fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		fileRef.addEventListener(IOErrorEvent.IO_ERROR, handleError);
	 
 
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = "http://localhost:49423/ftpwebservice.asmx?WSDL";;
		//	urlRequest.url = "https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";;
			urlRequest.contentType = 'text/xml; charset=utf-8';
		 
		//	Content-Disposition with a name attribute set to "Filedata" by default and a filename attribute set to the name of the original file
		 
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
	
			urlRequest.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 
//	urlRequest.requestHeaders.push(  new URLRequestHeader("pragma", "no-cache"));
			
			var variables:URLVariables   = new URLVariables();
			variables.remotePath ="APK";
			
			variables.filename = "fam.jpg"; // This one the same
			
			
			urlRequest.data =  variables;
	 
			fileRef.upload(urlRequest,"filedata");
	 
		
		function handleError(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		 
		}
		// Function that fires off when upload is complete
		function completeHandler(event:Event):void {
		 
		}
		
		// Function that return data when upload is complete
		function uploadDataComplete(event:DataEvent):void {
			
			var xml:XML = new XML(event.data);
			trace(xml)
			var resultNum = xml.status
			
			if(resultNum == "OK") {
			 trace("Done")
			}
		}
		// Function that fires off when the upload progress begins
		function progressHandler(event:ProgressEvent):void {
		//	trace( " " + event.bytesTotal + "  " + event.bytesLoaded +"  sonsira "+"etap" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			 
		}	
	}
	/*	public static function UpFtgpf(lf:File,rfol:String,rfile:String,imagf:Function):void
	{
		
		
		var fileRef:FileReference   = new FileReference();
		fileRef.browse();
		fileRef.addEventListener(Event.SELECT, syncVariables);
		fileRef.addEventListener(Event.COMPLETE, completeHandler);
		fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataComplete);
		fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		fileRef.addEventListener(IOErrorEvent.IO_ERROR, handleError);
		
		//		
		
		// Function that fires off when File is selected  from PC and Browse dialogue box closes
		function syncVariables(event:Event):void {
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = "https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";;
			urlRequest.contentType = 'text/xml; charset=utf-8';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
			
			var variables:URLVariables   = new URLVariables();
			variables.remotePath ="APK";
			
			variables.filename = "famtt.jpg"; // This one the same
			
			
			urlRequest.data =  variables
			
			
			fileRef.upload(urlRequest,"filedata");
		}
		*/
		public static function UpFtps(lf:File,rfol:String,rfile:String,imagf:Function):void
		{
			var lf:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
			
			var dataf:ByteArray=new ByteArray();
			var inStream:FileStream=new FileStream();
			inStream.open(lf, FileMode.READ);
			
			inStream.readBytes(dataf, 0, dataf.length);
			inStream.close();
			var rds:String=Dekod.encode(dataf);
			var urlRequest:URLRequest = new URLRequest();
		//	urlRequest.url = "http://localhost:49423/ftpwebservice.asmx?WSDL";;
			//	urlRequest.url = "https://service.ttnda.az/FtpWebservice/ftpwebservice.asmx?WSDL";;
			urlRequest.url = "https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";;
			urlRequest.contentType = 'text/xml; charset=utf-8';
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
			urlRequest.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 

			urlRequest.data = 	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
				<SOAP-ENV:Body>  
				  <tns:qup xmlns:tns="http://microsoft.com/webservices/">   
				   <tns:fileData>{rds}</tns:fileData>    
				  <tns:filename>{rfile}</tns:filename> 
					 <tns:remotePath>{rfol}</tns:remotePath>  
				  </tns:qup>  </SOAP-ENV:Body>
				</SOAP-ENV:Envelope>;
			
			//	/	 	urlRequest.requestHeaders.push( new URLRequestHeader( 'Content-type', 'text/xml; charset=utf-8' ) );
			//	http://microsoft.com/webservices/qup
			
			var urlStream:URLStream = new URLStream();                
		  
			urlStream.addEventListener(Event.COMPLETE, completeHandler);
			 
			urlStream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlStream.addEventListener(Event.OPEN, openHandler);
			urlStream.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
 			
			try {
				urlStream.load(urlRequest);   	 
			} 
			catch (error:Error)
			{
				trace("Unable to load requested URL.");
			}
			
 			function completeHandler(event:Event):void {
				
				trace("completeHandler: " + event);
				
			 
				trace("FILE fffffffffffff HAZİR" +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
				
				urlStream.close();				
				urlStream =null;
	 			
			}
			
			function openHandler(event:Event):void {
				trace("openHandler: " + event);
							 
			}
 			function progressHandler(event:ProgressEvent):void {
				//	trace("progressHandler: " + event);
				
				 
				trace( " " + event.bytesTotal + "  " + event.bytesLoaded +"  sonsira "+"etap" +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
			}
			
			function securityErrorHandler(event:SecurityErrorEvent):void {
				trace("securityErrorHandler: " + event);
			 
			}
			
			 
			
			function ioErrorHandler(event:IOErrorEvent):void {
				trace("ioErrorHandler: " + event);
			 
			}
	 		}
		public static function UpFtpsf(lsf:File,rfol:String,rfile:String,imagf:Function):void
		{
				 
	//		Content-Disposition: form-data; name="Filedata"; filename="MyFile.jpg"
	//		Content-Type: application/octet-stream
			
	/*		otected function onObjectLoaded(event:Event):void
			{
				var byteArray:ByteArray = new ByteArray();
				var fileName:String = fileReference.name;
				var uploadPath:String = serviceURL;
				var parameters:Object = new Object();
				parameters.key = serviceKey;
				
				fileReference.data.readBytes(byteArray,0,fileReference.data.length);
				
				var urlRequest:URLRequest = new URLRequest();
				urlRequest.url = uploadPath;
				urlRequest.contentType = 'multipart/form-data; boundary=' + UploadPostHelper.getBoundary();
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.data = UploadPostHelper.getPostData(fileName, byteArray, "fileupload",  parameters);
				urlRequest.requestHeaders.push( new URLRequestHeader( 'Content-type', 'image/png' ) );
				
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
				/*urlLoader.addEventListener(Event.COMPLETE, onComplete);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				urlLoader.addEventListener(Event.COMPLETE, processResults);
				urlLoader.load(urlRequest);
			}
			
			
			*/
			
			
			
			var fileRef:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
		
		var dataf:ByteArray=new ByteArray();
		var inStream:FileStream=new FileStream();
		inStream.open(fileRef, FileMode.READ);
		
		inStream.readBytes(dataf, 0, dataf.length);
		inStream.close();
		var rds:String=Dekod.encode(dataf);
		var urlRequest:URLRequest = new URLRequest();
		//	urlRequest.url = "http://localhost:49423/ftpwebservice.asmx?WSDL";;
		//	urlRequest.url = "https://service.ttnda.az/FtpWebservice/ftpwebservice.asmx?WSDL";;
		urlRequest.url = "http://localhost/FileService/TransferService.svc?singleWsdl";;
		urlRequest.contentType = 'multipart/form-data';
	//	urlRequest.contentType = 'application/octet-stream';
		urlRequest.method = URLRequestMethod.POST;
		 
	 
		var loader : URLLoader = new URLLoader();
		var variables:URLVariables   = new URLVariables();
	 
		variables.FileName = "fam.jpg"; // This one the same
		variables.Length =dataf.length;
		urlRequest.data = variables;
		 
		
		fileRef.addEventListener(Event.COMPLETE, completeHandler);
		fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataComplete);
		fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		fileRef.addEventListener(IOErrorEvent.IO_ERROR, handleError);
		
	  	
		 
		
		fileRef.upload(urlRequest,"File");
		
		
		function handleError(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			
		}
		// Function that fires off when upload is complete
		function completeHandler(event:Event):void {
			
		}
		
		// Function that return data when upload is complete
		function uploadDataComplete(event:DataEvent):void {
			
			var xml:XML = new XML(event.data);
			trace(xml)
			var resultNum = xml.status
			
			if(resultNum == "OK") {
				trace("Done")
			}
		}
		// Function that fires off when the upload progress begins
		function progressHandler(event:ProgressEvent):void {
			trace( " " + event.bytesTotal + "  " + event.bytesLoaded +"  sonsira "+"etap" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			
		}	
	}
		
		
		
		
		public static function UpFtpddd(lf:File,rfol:String,rfile:String,imagf:Function):void
		{
			 	var lf:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
			
			var dataf:ByteArray=new ByteArray();
			var inStream:FileStream=new FileStream();
			inStream.open(lf, FileMode.READ);
			
			inStream.readBytes(dataf, 0, dataf.length);
			inStream.close();
			var rds:String=Dekod.encode(dataf);
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = "http://localhost/FileService/TransferService.svc?singleWsdl";;
		//	Content-Disposition: form-data; name="Filedata"; filename="MyFile.jpg"
			 
	 		urlRequest.contentType = 'application/octet-stream';
			urlRequest.method = URLRequestMethod.POST;
		//	urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
			
			//	/	 	urlRequest.requestHeaders.push( new URLRequestHeader( 'Content-type', 'text/xml; charset=utf-8' ) );
			//	http://microsoft.com/webservices/qup
			var urlLoader:URLLoader = new URLLoader();
			
			
			var variables:URLVariables   = new URLVariables();
			variables.remotePath ="APK";
			
			variables.filename = "fam.jpg"; // This one the same
		  
			
			urlRequest.data =  variables;
		 
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT
			/*urlLoader.addEventListener(Event.COMPLETE, onComplete);*/
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRerv);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, fprog);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRerc);
		 urlLoader.addEventListener(Event.COMPLETE, onRer);
		 
			urlLoader.load(urlRequest);
			
			
			function onRerv(event:Event):void {
				trace("Upftp IOERROR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRerc(event:Event):void {
				trace("UpFtp SECERROR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRer(event:Event):void {
				trace("UpFtp HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			function fprog (event:ProgressEvent):void
			{
				trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
				
				
			}      
			
			
		//	trace("SERVIS SSSS vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			
			
			
		}		
		
		
		public static function send_upload():void {
			
			var lf:File=File.documentsDirectory.resolvePath('ttnda/fam.jpg' );
			
			var dataf:ByteArray=new ByteArray();
			var inStream:FileStream=new FileStream();
			inStream.open(lf, FileMode.READ);
			
			inStream.readBytes(dataf, 0, dataf.length);
			inStream.close();
			//	var rds:String=Dekod.encode(dataf);
			
			//	urlRequest.url = "http://localhost/FileService/TransferService.svc?singleWsdl";;
			//	Content-Disposition: form-data; name="Filedata"; filename="MyFile.jpg"
			
		//	urlRequest.contentType = 'application/octet-stream';
			
		//	var rhArray:Array = new Array(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qup"));
			var req : URLRequest = new  URLRequest( "http://localhost/FileService/TransferService.svc?singleWsdl")
		//	req.contentType = 'multipart/form-data;' ;
			 req.contentType = 'application/octet-stream';
			var loader : URLLoader = new URLLoader();
			var variables:URLVariables   = new URLVariables();
			variables.remotePath ="APK";
			
			variables.FileName = "fam.jpg"; // This one the same
		//	variables.Length = rds;
			req.data = variables;
			req.method = URLRequestMethod.POST;
		//	req.requestHeaders = rhArray;
		loader.dataFormat = URLLoaderDataFormat.VARIABLES
			loader.addEventListener(ProgressEvent.PROGRESS, uploadProgress);
			loader.addEventListener(Event.COMPLETE, uploadComplete);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, uploadStatus);
			loader.load(req);
			
			function  uploadProgress(event:ProgressEvent):void
			{
				trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
				
				
			}      
			function uploadComplete(complete:Event):void { trace("upload  progress"); }
			function  uploadStatus(status:HTTPStatusEvent):void {
				trace("upload status");
				trace(status.status);
			}
			
		}	
		
	 
		
		public static function Azstr(sttt:String):String
		{
			//var sttt:String=str;
			
			var i:int;
			
			var   sts:String="";
			
			for (i=0; i<sttt.length; i++)
				
			{
				var cd:int=sttt.charCodeAt(i);
				
				if (sttt.charCodeAt(i)==1241) 
					
					sts+=String.fromCharCode(601);
					
				else
					if (sttt.charCodeAt(i)==1240) 
						
						sts+=String.fromCharCode( 399);
						
					else
									
					sts+=sttt.charAt(i);
			}
			
			return  sts;
		}
				
		
		public static function Azrec(sttt:String):String
		{
			//var sttt:String=str;
			
			var i:int;
			
			var   sts:String="";
			
			for (i=0; i<sttt.length; i++)
				
			{
				var cd:int=sttt.charCodeAt(i);
				
			
					if (sttt.charCodeAt(i)== 399) 
						
						sts+=String.fromCharCode(1240);
						
					else
						
						sts+=sttt.charAt(i);
			}
			
			return  sts;
		}
		
//		Ğ-011E---011C
	//		ğ-011F-----011D
		//		u-04D8 -018F
		//	u-04D9 - 0259
		
		
		//		u-04D8 - 1240 bb.ee
		//-018F-399 b.e
		//	u-04D9-1241 kicik e
		//	- 0259-601 k.e
		
		public static function GetFtpF(rfol:String,rfile:String,imagf:Function):void
		{
			var request:URLRequest = new URLRequest();
			
			request.url="https://service.ttnda.az/planset/ftpwebservice.asmx?WSDL";
			request.method = URLRequestMethod.POST;
			//	request.contentType = "gzip";  Ekspertfhn.apk    EkolKS.apk,fprog:Function
			//	request.setPropertyIsEnumerable(				
			//	header("Content-Encoding: gzip");  name="remoteFolder" type="s:string" maxOccurs="1" minOccurs="0"/><s:element name="remoteFile" type="s:string" 
			request.contentType = "text/xml; charset=utf-8";
			
			//	urlRequest.contentType="application/octet-stream";
			//	urlRequest.method=URLRequestMethod.POST;
			//	urlRequest.data=byteArrayEncode; 
			request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://microsoft.com/webservices/qdown"));
			
			request.requestHeaders.push(new URLRequestHeader("mobtoken", "K#j$k22lkh3u_)!!(*-+4U3GYF65T3RSq")); 
//	request.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/Cedvel"));
			
			
			request.data =	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">  <SOAP-ENV:Body> 
<tns:qdown xmlns:tns="http://microsoft.com/webservices/">    
<tns:remoteFolder> {rfol}  </tns:remoteFolder> 
<tns:remoteFile>  {rfile} </tns:remoteFile> 					
</tns:qdown> 
</SOAP-ENV:Body></SOAP-ENV:Envelope>;
			
			
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, imagf, false, 0, true);
			loader.addEventListener(ProgressEvent.PROGRESS, fprog, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onRervv);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRercc);
			function fprog (event:ProgressEvent):void
			{
				
				trace( " " + event.bytesTotal + "  " + event.bytesLoaded + "  sonsira "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
				
				
				
			}      
			function onRervv(event:Event):void {	 		
				
				trace("GetFtp IOERROR" +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRercc(event:Event):void {	 		
				
				trace("GetFtp SECERROR" +event.toString()+"  "  +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			function onRer(event:Event):void {
				
				trace("GetFtp HAZIR"  +event.toString()+"  " +(new Date()).toString()+"--"+(new Date()).milliseconds);
			}
			
			trace(" GetFtp vurdu" +(new Date()).toString()+"--"+(new Date()).milliseconds);
			loader.load(request);
			
			
			
			
			
		}	
		
		
	}
}