package
{
	/**
	 * author:MK
	 * 2014-3-28
	 * 
	 */
	
	public class ClientManager
	{
		public var clientList:Array=[];
		
		public function ClientManager()
		{
		}
		
		public function addClient(client:Client):void
		{
			var isIn:Boolean = false;
			for each(var temp:Client in clientList)
			{
				if(client.socket.localAddress==temp.socket.localAddress)
				{
					isIn = true;
				}
			}
			if(!isIn)
			{
				clientList.push(client);
			}
		}
		
		
	}
}