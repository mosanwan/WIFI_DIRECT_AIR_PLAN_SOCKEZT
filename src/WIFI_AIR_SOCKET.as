package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	
	public class WIFI_AIR_SOCKET extends Sprite
	{
		private var mainToMe:MessageChannel;
		private var meToMain:MessageChannel;
		
		//这个游戏网络中所有ip和端口
		static public var serverList:Array;//用于重连
		//你构建的服务器的地址和端口
		static public var yourServerAddress:String;
		static public var yourServerPort:int;
		
		//你连接的服务器的地址和端口
		static public var serverAddress:String;
		static public var serverPort:int;
		
		//作为一个连接服务器的状态
		static public const YOU_CONNET_A_SERVER:int=0;
		//作为一个服务器的状态
		static public const YOU_ACT_AS_A_SERVER:int=0;
		//当前服务器和客户端属性
		//为上面两种值 这个值由你主线程决定
		static public var your_actor_state:int;
		
		//超时设置
		static public var timeOut:int;
		//设置唯一的client_id
		static public var client_id:int=0;
 
		
	
		public function WIFI_AIR_SOCKET()
		{
			
			mainToMe=Worker.current.getSharedProperty("mainToWorker");
			meToMain=Worker.current.getSharedProperty("workerToMain");
			//初始化MainClient
			MainClient.getInstance();
			if(mainToMe&&meToMain)
			{
				meToMain.send("threadReay");
				mainToMe.addEventListener(Event.CHANNEL_MESSAGE,onStatus);
			}

 
		}
		
		
		
		protected function onStatus(event:Event):void
		{
			trace("Socket线程 :"+mainToMe.receive());	
			
		}
		
		/**
		 *获得当前服务器和客户端属性 
		 * @return 
		 * 
		 */
	 	
		static public function getYourActorState():int
		{
			return your_actor_state;
		}	
		
		/**
		 *设置当前服务器客户端的状态 
		 * @param state
		 * @param address
		 * @param port
		 * 
		 */
		static public function setYourActorState(state:int,address:String,port:int):void
		{
			your_actor_state = state;
			if(your_actor_state==YOU_ACT_AS_A_SERVER)
			{
				yourServerAddress = address;
				yourServerPort = port;
				//如果你在玩，不是连别人的服务器   你的服务器就是开着的	 mainclient 就不必连接了
				Server.getInstance().init(address,port);	
				MainClient.getInstance().close();
			}
			else if(your_actor_state==YOU_CONNET_A_SERVER)
			{
				//如果你正在玩  而且连上别人的服务器  那么你的服务器就关闭  
				serverAddress = address;
				serverPort = port;
				MainClient.getInstance().init(address,port);
				Server.getInstance().close();
			}
		}
		
		/**
		 *随机不重复产生客户端id 
		 * @return 
		 * 
		 */
		static public function getClientId():int
		{
			client_id++;
			return client_id;
		}
 
	}

}

internal class serverInfo
{
	public var address:String;
	public var port:int;
}