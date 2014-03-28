package
{
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;

	/**
	 *author T
	 *2014-3-27下午10:26:16
	 */
	public class Server
	{
		private static var _ins:Server;
		public static function getInstance():Server
		{
			if(!_ins) _ins=new Server();
			return _ins;
		}
		private var _serverSocket:ServerSocket;
		public function Server()
		{
		}
		public function init(adess:String,port:int):void
		{
			_serverSocket=new ServerSocket();
			_serverSocket.bind(port,adess);
			_serverSocket.listen();
			_serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT,onClientConnect);	
		}
		
		protected function onClientConnect(event:ServerSocketConnectEvent):void
		{
			var socket:Socket=event.socket;
			
		}
		
		public function close():void
		{
			_serverSocket.close();
		}
	}
}