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
				case ThreadConnectData.start_a_server:
				 	WIFI_AIR_SOCKET.setYourActorState(WIFI_AIR_SOCKET.YOU_ACT_AS_A_SERVER,_data.data[0],_data.data[1]);
					break;
				case ThreadConnectData.server_list:
					server_list(_data.data);
					break ;
				case ThreadConnectData.connet_to_server:
					WIFI_AIR_SOCKET.setYourActorState(WIFI_AIR_SOCKET.YOU_CONNET_A_SERVER,_data.data[0],_data.data[1]);
					break ;
			}
		}
 
		//设置服务器列表
		private function server_list(data:Array):void
		{
			WIFI_AIR_SOCKET.serverList=data;
		}
		
		
 
 

 
	}
}