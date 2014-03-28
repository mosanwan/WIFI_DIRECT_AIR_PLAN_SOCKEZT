package
{
	public class MainDataHandler
	{
		private static var _ins:MainDataHandler;
		public static function getInstance():MainDataHandler
		{
			if(!_ins)_ins=new MainDataHandler();
			return _ins;
		}
		/**
		 *处理主线程发送过来的数据 
		 * @param d 
		 * 
		 */		
		public function hand(d:Object):void
		{
			var _data:ThreadConnectData=d as ThreadConnectData;
			/**
			 * @param _data 线程之间数据传送的数据类
			 * @param _data.dataType 数据类型（String类型）
			 * @param _data.data 具体的数据( Array类型)。可以到ThreadConnectData类里查看具体数据的作用
			 * */
			switch(_data.dataType)
			{
				case ThreadConnectData.INIT_SOCKET:
					handInitSock(_data.data);
					break;
			}
		}
		
		private function handInitSock(data:Array):void 
		{
			var isServer:Boolean=data[0]; //是否是服务器
			var serverAdress:String=data[1]; //服务器IP
			if(isServer){
				//启动服务器Socket
			}else{
				//启动客户端Socket
			}
		}
	}
}