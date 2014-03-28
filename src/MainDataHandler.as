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
		public function hand(d:Object):void
		{
			
		}
	}
}