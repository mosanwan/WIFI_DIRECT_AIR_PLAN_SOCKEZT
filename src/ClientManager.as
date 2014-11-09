package
{
	/**
	 * author:MK
	 * 2014-3-28
	 * 
	 */
	
	public class ClientManager
	{
		private  var clientList:Array=[];
		static private var _ins:ClientManager;
		static public function getInstance():ClientManager
		{
			if(!_ins) _ins= new ClientManager();
			return _ins;
		}
		
		public function ClientManager()
		{
		}
		
		
		public function clear():void
		{
			clientList=[];
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
				client.init();
				clientList.push(client);
				MeToMainCC.sendAddClient(client.client_id);
			}
		}
		public function deleteClient(id:int):void
		{
			var index:int=0;
			for each(var temp:Client in clientList)
			{
				if(temp.client_id == id)
				{
					clientList.slice(index,1);
					MeToMainCC.sendDeleteClient(temp.client_id);
				}
				index++;
			}
		}
		
		
	}
}