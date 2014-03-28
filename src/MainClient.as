package
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	/**
	 * author:MK
	 * 2014-3-28
	 * 
	 */
	
	public class MainClient
	{
		
	   static private var _ins:MainClient;
	   public var socket:Socket;
	   static public function getInstance():MainClient
	   {
		   if(!_ins) _ins= new MainClient();
		   return _ins;
	   }
	   
		public function MainClient()
		{
			socket = new Socket();	
			socket.addEventListener(Event.CONNECT,onConnet);
			socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
		}
		
		/**
		 *其实就是重新连接 
		 * @param address
		 * @param port
		 * 
		 */
		public function init(address:String,port:int):void
		{
			if(socket.connected)
				socket.close();
			socket.connect(address,port);
		} 
	 
		
		public function close():void
		{
			socket.close();
		}
		
		/**
		 *当连接建立的时候 
		 * @param e
		 * 
		 */
		private function onConnet(e:Event):void
		{
			trace(e.type);
			trace("game again");
		}
		
		/**
		 *用于当服务器down了后重新连接 或者你自己一个人了
		 * @param e
		 * 
		 */
		private function onError(e:Event):void
		{
			trace("meet a connet error");
			//别人的服务器down了  //服务器超时那么你会重新连接其他人的服务器，而且有可能打开自己的服务器
			if(WIFI_AIR_SOCKET.serverList.length>1)
			{
				var data:Array = WIFI_AIR_SOCKET.serverList[0] as Array;
				if(data[0] as String ==WIFI_AIR_SOCKET.yourServerAddress)
				{
					//表明你是候选服务器
					WIFI_AIR_SOCKET.setYourActorState(WIFI_AIR_SOCKET.YOU_ACT_AS_A_SERVER,data[0],data[1]);
				}
				else
				{
					//你不是候选服务器
					WIFI_AIR_SOCKET.setYourActorState(WIFI_AIR_SOCKET.YOU_CONNET_A_SERVER,data[0],data[1]);
				}
			}
			else
			{
				MeToMainCC.sendServerDownAndNoServer();
			}
 
		}
		
		/**
		 *服务器发送的消息 
		 * @param e
		 * 
		 */
		private function onData(e:ProgressEvent):void
		{
	 		//传给main thread
			MeToMainCC.sendServerMsg(e.target);
		}
	}
}