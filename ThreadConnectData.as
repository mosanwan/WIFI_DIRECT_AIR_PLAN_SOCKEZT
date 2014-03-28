package 
{
	public class ThreadConnectData
	{
		public var dataType:String;
		public var data:Object;
		
		public static const INIT_SOCKET:String="initSocket";
		
		
		
		public function ThreadConnectData(type:String,_data=null)
		{
			dataType=type;
			data=_data;
		}
	}
}