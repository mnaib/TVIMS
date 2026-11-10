package com
{
	[Bindable]
	public class Azstring
	{
		public function Azstring()	
		{
			
		}
		
		public static function Azstr(sttt:String):String
		{
			//var sttt:String=str;
			if (sttt==null) return "";
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
			if (sttt==null) return "";
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
		
	}
}