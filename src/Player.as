package{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;

    public class Player extends FlxSprite{

		[Embed(source="../assets/sprites/player_sheet.png")] private var ImgPlayer:Class;
		
        public var upPressLimit:int = 4;
        public static var gravity:int = -25;
		public var jumping:Boolean = false;

        public function Player(x:int,y:int){
            super(x,y);

            loadGraphic(ImgPlayer,true,true,30,40,true);
			addAnimation("idle",[14]);
			addAnimation("jump",[0,1,2,3],14);
			addAnimation("fall",[4,5],14,false);
			addAnimation("run",[6,7,8,9,10,11,12,13],14,true);

            var runSpeed:uint = 10;
            drag.x = runSpeed*80;
            drag.y = runSpeed*80;

        }

        override public function update():void{
           
            var _jumppower:int = 430;
            var maxHeight:int = 30;
            var playerOriginPoint:int = this.y;

            acceleration.x = 0;
            acceleration.y = 0;

            velocity.y -= gravity;

            if(FlxG.keys.LEFT) {
                velocity.x = -100;
				facing = LEFT;
            } else if(FlxG.keys.RIGHT){
                velocity.x = 100;
				facing = RIGHT
            } else if(FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("UP")){
                if(upPressLimit > 0){
                    upPressLimit -= 1;
                    velocity.y = -_jumppower;
                }
            }
			
			if(jumping == true){
				if(velocity.y < 0){
				play("jump");
				}else if (velocity.y > 4){
				play("fall");
				}
			}else{
				if (velocity.x < -.5 || velocity.x > .5){
					play("run");
				}else{
					play("idle");
				}
			}
			super.update();
        }
    }
}
