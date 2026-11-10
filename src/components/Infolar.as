package components
{
	import flash.events.Event;
	
	public class Infolar extends Event
	{
		
		
		public static var MENU_SELECTED:String = "menuSelected";
public static var SUBMENU_SELECTED:String = "submenuSelected";
public static var ITEM_SELECTED:String = "itemSelected";
public static var NAV_NEXT:String = "navNext";
public static var NAV_PREVIOUS:String = "navPrevious";
public static var NAV_LAST:String = "navLast";
public static var NAV_FIRST:String = "navFirst";
public static var CLOSE:String = "close";

public var menuIdx:int;
//public var menuType:String;
public var menuId:int;
public var menuName:String;
public var itemId:int;
		
	/*	

public static var DATA_LOADED:String = "dataLoaded";

private var _data:ArrayCollection;

public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:ArrayCollection=null)
{
	super(type, bubbles, cancelable);
	_data = data;
}

override public function clone():Event
{
	return new CustomEvent(type, bubbles, cancelable, data);
}

public function get data():ArrayCollection
{
	return _data;
}  */
		
		public function Infolar(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
		}
	}
}


 