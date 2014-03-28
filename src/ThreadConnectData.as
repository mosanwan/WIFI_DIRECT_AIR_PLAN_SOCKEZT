package 
{
	public class ThreadConnectData
	{
		public var dataType:String;
		public var data:Array;
		
		public static const INIT_SOCKET:String="initSocket"; //启动服务器  数据说明 [boolean 是否为服务器, String 服务器IP]
		
		
		
		public function ThreadConnectData(type:String,_data=null)
		{
			dataType=type;
			data=_data;
		}
	}
}