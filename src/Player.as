package{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;

    public class Player extends FlxSprite{

        public var upPressLimit:int = 4;
        public static var gravity:int = -25;

        public function Player(x:int,y:int){
            super(x,y);

            makeGraphic(20,20,0xffCC0000);

            var runSpeed:uint = 10;
            drag.x = runSpeed*80;
            drag.y = runSpeed*80;

        }

        override public function update():void{
            super.update();
            var _jumppower:int = 430;
            var maxHeight:int = 30;
            var playerOriginPoint:int = this.y;

            acceleration.x = 0;
            acceleration.y = 0;

            velocity.y -= gravity;

            if(FlxG.keys.LEFT) {
                acceleration.x -= drag.x;
            } else if(FlxG.keys.RIGHT){
                acceleration.x += drag.x;
            } else if(FlxG.keys.justPressed("UP")){
                if(upPressLimit > 0){
                    upPressLimit -= 1;
                    velocity.y = -_jumppower;
                }
            }
        }
    }
}
