package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import linquantan.Map;
	import linquantan.Person;
	
	
   [SWF(width=1280,height=768,backgroundColor="#D6E3F7",frameRate="100")]
	public class JietiGame extends MovieClip
	{
		//游戏状态
		private static const STATE_START_GAME:int = 10;
		private static const STATE_PLAY:int = 20;
		private static const STATE_END_GAME:int = 30;
		private var gameState:int =0;
		
		
		private var person:Person=new Person();;
		private var map:Map;
		private var jifen:Jifen;
		private var isDown:Boolean=true;
		private var iss:Boolean=true;
		private var sbtu:Start_btu;
		private var rbtu:Replay_btu;
		private var ss:Start;
		private var soundstop:SoundStop=new SoundStop();
		private var st:SoundChannel;
		
		
		public function JietiGame()
		{
			
			ss=new Start();
			ss.width=1280;
			ss.height=768;
			addChild(ss);
			sbtu=new Start_btu();
			sbtu.x=640;
			sbtu.y=384;
			addChild(sbtu);
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			sbtu.addEventListener(MouseEvent.MOUSE_DOWN,onMouse);
			
			
			
			//stage.addEventListener(Event.ENTER_FRAME,onEF);
		}
		
		protected function onMouse(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			gameState=STATE_START_GAME;
			removeChild(sbtu);
			sbtu.removeEventListener(MouseEvent.MOUSE_DOWN,onMouse);
			
		}
		
		protected function gameLoop(event:Event):void
		{
			// TODO Auto-generated method stub
			switch(gameState)
			{
				case STATE_START_GAME :
					initGame();
					break;
				case STATE_PLAY :
					playGame();
					break;
				case STATE_END_GAME :
					endGame();
					break;
			}
		}
		
		private function initGame():void{
			
			//person=new Person();
			
			
			map=new Map();
			addChild(map);
			//map.setSpeed(5);
			
			person.x=400;
			person.y=150;
			addChild(person);
			jifen=new Jifen();
			jifen.x=640;
			jifen.y=0;
			addChild(jifen);
			TweenLite.to(jifen,2,{y:50,ease:Back.easeOut});
			stage.addEventListener(KeyboardEvent.KEY_DOWN,move);
			gameState=STATE_PLAY;
			
			
		}
		private function playGame():void
		{
			jifen.wenzi.text=String(map.dengji);
			person.setDownSpeed(map.speed);
			
			testEndGame();
			map.test();
			if(isDown) person.down();
			
			// TODO Auto-generated method stub
			
			for(var i:int=0;i<map.board_arr.length;i++){
				if(map.board_arr[i].hitTestPoint(person.x,person.y,true))
			
				{
					
					person.y=map.board_arr[i].y;
					isDown=false;
					
				}
				else isDown=true;
				
			}
			
		}
		private function endGame():void{
			
			
			
		
		}
		private function testEndGame():void{
			
			if(person.y>=768+50||person.y<=0){
				gameState=STATE_END_GAME;
				removeChild(person);
				rbtu=new Replay_btu();
				rbtu.x=640;
				rbtu.y=384;
				addChild(rbtu);
			
				st=soundstop.play(0,1);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,move);
				rbtu.addEventListener(MouseEvent.MOUSE_DOWN,onReplay);
				
				trace("game over");
			}
			
		}
		
		private function onReplay(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			rbtu.removeEventListener(MouseEvent.MOUSE_DOWN,onReplay);
			removeChild(rbtu);
			removeChild(jifen);
			map.destoryAll();
			removeChild(map);
			addChild(person);
			addChild(map);
			
			gameState=STATE_START_GAME;
			
		}
		
		protected function move(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			
		
			if (event.keyCode == 37)
			{person.walkLeft();
				
			}
			else if (event.keyCode==39)
			{
				person.walkRight();
			}
			
		}
		
	}
}