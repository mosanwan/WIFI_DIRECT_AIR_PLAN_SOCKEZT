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
		public function WIFI_AIR_SOCKET()
		{
			
			mainToMe=Worker.current.getSharedProperty("mainToWorker");
			meToMain=Worker.current.getSharedProperty("workerToMain");
			if(mainToMe&&meToMain)
			{
				meToMain.send("threadReay");
				mainToMe.addEventListener(Event.CHANNEL_MESSAGE,onStatus);
			}
		}
		
		protected function onStatus(event:Event):void
		{
			trace("Socket线程 "+mainToMe.receive());
			
		}
	}
}