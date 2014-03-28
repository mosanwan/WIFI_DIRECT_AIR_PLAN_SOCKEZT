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
		}
		
		public function init():void
		{
			socket.addEventListener(Event.CONNECT,onConnet);
			socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
		}
		public function reconnect(address:String,port:int):void
		{
			if(socket.connected)
				socket.close();
			socket.connect(address,port);
		}
		
		public function close():void
		{
			socket.close();
		}
		
		private function onConnet(e:Event):void
		{
			trace(e.type);
		}
		
		private function onError(e:Event):void
		{
			trace("meet a connet error");
			//服务器关闭了
			//服务器超时了
		}
		
		private function onData(e:ProgressEvent):void
		{
			trace("get"+e.bytesTotal+"bytes");
			trace("message is"+e.target.toString());
		}
	}
}