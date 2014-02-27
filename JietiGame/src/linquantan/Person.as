package linquantan
{
	import flash.events.KeyboardEvent;

	public class Person extends PersonImage
	{
		private const WALK_SPEED:int=10;
		private var DOWN_SPEED:int=2;
		public function Person()
		{
			super();
		
			
		}
		public function setDownSpeed(ds:int):void{
			DOWN_SPEED=ds;
		}
		public function walkRight():void{
			this.x+=WALK_SPEED;
			
			
			this.gotoAndPlay('walk_right');
		}
		public function walkLeft():void{
			this.x-=WALK_SPEED;
			
			this.gotoAndPlay('walk_left');
		}
		public function down():void{
			this.y+=DOWN_SPEED;
			
			
		}
		
		
	}
}