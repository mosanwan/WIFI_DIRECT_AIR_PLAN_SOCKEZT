package
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	/**
	 *author T
	 *2014-3-27下午10:29:18
	 */
	public class Client
	{
  		public var socket:Socket;
		public var client_id:int;
		
		
		public function Client(_socket:Socket)
		{
			socket = _socket
			client_id = WIFI_AIR_SOCKET.getClientId();
		}
		public function init():void
		{
			socket.addEventListener(Event.CONNECT,onConnet);
			socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);		 
		}		
 
		private function onConnet(e:Event):void
		{
			trace("a client connet us");
		}
		
		private function onError(e:Event):void
		{
			trace("meet a connet error");
			socket.close();
			socket.removeEventListener(Event.CONNECT,onConnet);
			socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA,onData);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);		
			ClientManager.getInstance().deleteClient(this.client_id);
		}
		
		private function onData(e:ProgressEvent):void
		{
			//传给main thread
			MeToMainCC.sendClientMsg(this.client_id,e.target);
		}
		


	}
}