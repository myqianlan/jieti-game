package linquantan
{
	import flash.display.MovieClip;
	import flash.events.Event;
	//*******************************************************
	//@author: Linquan Tan
	//@date:  2012.09.15
	//*******************************************************

	public class Map extends MovieClip
	{
		
		public var speed:Number=1;
		public var dengji:int=0;
		
		public var board_arr:Array=new Array();
		private var amount:int;		
		private var flag:Number;
		private var jietiNum:int=0;
		
		public function Map()
		{
		creatMap();
			
		}
		
		public function test():void{
			
			move();
			testCreat();
			testDestroy();
	
		}
		
	    private function creatMap():void{
		    creatBoard();
		}
		
		private function testDestroy():void{
			
			for(var i:int=0;i<board_arr.length;i++){
				if(board_arr[i].y<=-50){
					jietiNum++;
					//控制显示等级
					if(jietiNum%10==0){
						dengji++;
					}
					//控制砖块速度
					if(jietiNum!=0&&jietiNum%50==0){
						speed+=0.1;
					}
					removeChild(board_arr[i]);
					board_arr.splice(i,1);
					
				
				}
			}
		}
		private function move():void{
			for(var i:int=0;i<board_arr.length;i++){
				board_arr[i].y-=speed;
			}
			
		}
		private function testCreat():void{
			flag=board_arr.length-1;
			if(flag>=0)
			{	
				if(768-board_arr[flag].y>=20)
				{
					creatBoard()
					
				}
			}
		}
		public function destoryAll():void{
			for(var i:int=0;i<board_arr.length;){
				removeChild(board_arr[i]);
				board_arr.splice(i,1);
			}
		}
		private function creatBoard():void{
			var board:BoardImage=new BoardImage();
			board.y=768+Math.random()*50;
			board.x=Math.random()*900+100;
	        addChild(board);
			board_arr.push(board);
			
		}
	}
}