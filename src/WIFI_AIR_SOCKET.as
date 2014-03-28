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
		
		private var serverList:Array;//用于重连
		private var yourServerAddress:String;
		private var yourServerPort:int;
		
		static public const YOU_CONNET_A_SERVER:int=0;
		static public const YOU_ACT_AS_A_SERVER:int=0;
		//为上面两种值 这个值由你主现成决定
		static public var your_actor_state:int;
		
		//超时设置
		static public var timeOut:int;
 
		
	
		public function WIFI_AIR_SOCKET()
		{
			
			mainToMe=Worker.current.getSharedProperty("mainToWorker");
			meToMain=Worker.current.getSharedProperty("workerToMain");
			if(mainToMe&&meToMain)
			{
				meToMain.send("threadReay");
				mainToMe.addEventListener(Event.CHANNEL_MESSAGE,onStatus);
				mainToMe.addEventListener(Event.CHANNEL_MESSAGE,onMessage);
			}
 
		}
		
		protected function onStatus(event:Event):void
		{
			trace("Socket线程 :"+mainToMe.receive());	
			
		}
		
		protected function onMessage(event:Event):void
		{
			trace("Socket消息:"+mainToMe.receive());
		}
		
	 
		protected function onRun():void
		{
 			//思路是这样的：
			//如果你正在玩  而且连上别人的服务器  那么你的服务器就关闭  维护一个成员列表（你们所有参加的人的address 和 port)
				//别人的服务器down了 那么你会重新连接其他人的服务器，而且有可能打开自己的服务器
			//如果你在玩，不是连别人的服务器   你的服务器就是开着的	
			if(your_actor_state==YOU_ACT_AS_A_SERVER)
			{
				Server.getInstance().init(yourServerAddress,yourServerPort);
			}
			else if(your_actor_state==YOU_CONNET_A_SERVER)
			{
			 
				//如果服务器down了或者超时 那么重连
				doReconnet();				
			}
			
		}
		
		static public function getYourActorState():int
		{
			return your_actor_state;
		}
		
		public function  doReconnet():void
		{
			//服务器down了
		}
	 

		
 
	}

}

internal class serverInfo
{
	public var address:String;
	public var port:int;
}